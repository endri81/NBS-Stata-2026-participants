* =====================================================================
* catchup_D4_S3.do  —  Day 4 catch-up: end of Part 3, Diagnostics
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 4 (19 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_svy.dta (rebuilt by day3/catchup/catchup_D3_S3.do
*              if missing), data/cpi_divisions_long.dta
* Outputs    : logs/day4.log
* Packages   : none
* USE        : close Word, open this file, press Ctrl + D. Your Stata is
*              now where the room is at the end of Part 3. To keep working,
*              save this file as day4/my_day4.do and add the next parts.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture mkdir "output"
* Day 4 starts from Day 3's declared file: rebuild it if it is missing.
capture confirm file "data/lfs_svy.dta"
if _rc do "day3/catchup/catchup_D3_S3.do"
capture log close
log using "logs/day4.log", replace text

* ---- Part 1: Tests
* Task 2: yesterday's file carries the design, not the flags
use "data/lfs_svy.dta", clear
generate wap = (ilo_age >= 15)
generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
generate unemp = (ilo_lfs19 == 2)
generate emp = (ilo_lfs19 == 1)
svyset
* Task 3: a mean with its interval (no design: a quick look)
ci means ilo_job1_how_usual if emp == 1
* Task 4: two means
ttest ilo_job1_how_usual if emp == 1, by(ilo_sex)
* Task 5: unequal spreads
ttest ilo_job1_how_usual if emp == 1, by(ilo_sex) unequal
* Task 6: two shares
prtest unemp if lf == 1, by(ilo_sex)
* Task 7: the design-based gap, the version NBS publishes
svy, subpop(lf): mean unemp, over(ilo_sex)
lincom c.unemp@1.ilo_sex - c.unemp@2.ilo_sex
* Task 8: the names of the estimates
mean, coeflegend
* Task 9: the same question as a p-value
test c.unemp@1.ilo_sex = c.unemp@2.ilo_sex

* ---- Part 2: Regression
* Task 10: one explanatory variable
regress ilo_job1_how_usual ilo_age if emp == 1
* Task 11: categories with i.
regress ilo_job1_how_usual i.ilo_sex i.agegrp i.region if emp == 1
* Task 12: Perseverance as the base
regress ilo_job1_how_usual i.ilo_sex i.agegrp ib7.region if emp == 1
* Task 13: look at education first
codebook ilo_edu_aggregate, tabulate(10)
* Task 14: add education (base 1: three employed persons, see Part 3)
regress ilo_job1_how_usual i.ilo_sex i.agegrp i.region ///
    i.ilo_edu_aggregate if emp == 1
* Task 15: age as a curve
regress ilo_job1_how_usual i.ilo_sex c.ilo_age##c.ilo_age ///
    i.region i.ilo_edu_aggregate if emp == 1
* Task 16: fitted values and residuals
regress ilo_job1_how_usual i.ilo_sex i.agegrp i.region ///
    i.ilo_edu_aggregate if emp == 1
predict yhat if e(sample)
predict res if e(sample), residuals
summarize ilo_job1_how_usual yhat res if e(sample)
* Task 17: stored results
display e(N)
display e(r2)

* ---- Part 3: Diagnostics
* Task 18: residuals against fitted values
regress ilo_job1_how_usual i.ilo_sex i.agegrp i.region ///
    i.ilo_edu_aggregate if emp == 1
rvfplot, yline(0)
* Task 19: unequal spread
estat hettest
* Task 20: overlapping characteristics
estat vif
* Task 21: leverage
lvr2plot
* Task 22: the high-leverage rows
predict lev if e(sample), leverage
list unique_ind ilo_edu_aggregate ilo_job1_how_usual lev ///
    if lev > .1 & !missing(lev)
* Task 23: the education groups among the employed
tabulate ilo_edu_aggregate if emp == 1 & !missing(ilo_job1_how_usual)
* Task 24: a large base category
regress ilo_job1_how_usual i.ilo_sex i.agegrp i.region ///
    ib3.ilo_edu_aggregate if emp == 1
estat vif
* Task 25: robust standard errors
regress ilo_job1_how_usual i.ilo_sex i.agegrp i.region ///
    i.ilo_edu_aggregate if emp == 1, vce(robust)
* Task 26: clustered standard errors
regress ilo_job1_how_usual i.ilo_sex i.agegrp i.region ///
    i.ilo_edu_aggregate if emp == 1, vce(cluster psu)
* Task 27: the design-based regression
svy, subpop(emp): regress ilo_job1_how_usual i.ilo_sex ///
    i.agegrp i.region i.ilo_edu_aggregate
* Task 28: three standard errors side by side
quietly regress ilo_job1_how_usual i.ilo_sex i.agegrp ///
    i.region i.ilo_edu_aggregate if emp == 1
estimates store plain
quietly regress ilo_job1_how_usual i.ilo_sex i.agegrp ///
    i.region i.ilo_edu_aggregate if emp == 1, vce(cluster psu)
estimates store clus
quietly svy, subpop(emp): regress ilo_job1_how_usual i.ilo_sex ///
    i.agegrp i.region i.ilo_edu_aggregate
estimates store design
estimates table plain clus design, ///
    keep(2.ilo_sex) b(%7.3f) se(%7.3f)

log close
