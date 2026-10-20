* =====================================================================
* catchup_D4_S1.do  —  Day 4 catch-up: end of Part 1, Tests
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 4 (19 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_svy.dta (rebuilt by day3/catchup/catchup_D3_S3.do
*              if missing), data/cpi_divisions_long.dta
* Outputs    : logs/day4.log
* Packages   : none
* USE        : close Word, open this file, press Ctrl + D. Your Stata is
*              now where the room is at the end of Part 1. To keep working,
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

log close
