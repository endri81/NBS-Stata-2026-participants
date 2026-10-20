* =====================================================================
* catchup_D2_S6.do  —  Day 2 catch-up: end of Part 6, Charts for the release
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 2 (17 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta (rebuilt by day1/catchup/catchup_D1_S9.do if missing)
*              data/lfs_jan.dta, lfs_feb.dta, lfs_mar.dta
*              data/lfs_person.dta, lfs_hh.dta, lfs_coding.dta
*              data/lfs_district_month.dta
* Outputs    : data/lfs_q1_appended.dta
*              output/district_indicators.dta
*              output/fig1_hours.png
*              logs/day2.log
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 6. To keep working, save this
*              file as day2/my_day2.do and add the next parts below it.
*              Close Excel and Word first: Part 7 writes to their files.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture mkdir "output"
* Day 2 starts from Day 1's analysis file: rebuild it if it is missing.
capture confirm file "data/lfs_teach.dta"
if _rc do "day1/catchup/catchup_D1_S9.do"
capture log close
log using "logs/day2.log", replace text

* ---- Part 1: append the three months -----------------------------------
use "data/lfs_jan.dta", clear
append using "data/lfs_feb.dta" "data/lfs_mar.dta", generate(source)
count
tabulate source
assert _N == 5888
tabulate district_q int_month
save "data/lfs_q1_appended.dta", replace

* ---- Part 2: merge households, persons, coding ------------------------
use "data/lfs_hh.dta", clear
isid unique_hhd
use "data/lfs_person.dta", clear
isid unique_ind
merge m:1 unique_hhd using "data/lfs_hh.dta", assert(match) nogenerate
merge 1:1 unique_ind using "data/lfs_coding.dta"
tabulate _merge ilo_lfs19, missing
assert ilo_lfs19 == 1 if _merge == 3
count
isid unique_ind
assert _N == 5888

* ---- Part 3: reshape the district x month table ------------------------
use "data/lfs_district_month.dta", clear
list in 1/6
reshape wide persons, i(district_q) j(int_month)
list in 1/6
reshape long persons, i(district_q) j(int_month)
assert _N == 78

* ---- Part 4: tables (from here on: Day 1's analysis file) --------------
use "data/lfs_teach.dta", clear
assert _N == 5888
tabulate region
tabulate region ilo_lfs19
tabulate region ilo_lfs19, row nofreq
tabstat ilo_job1_how_usual, statistics(mean p50 n) by(region)
table (region) (ilo_lfs19)
table (region) (ilo_lfs19), statistic(percent, across(ilo_lfs19))
table (region) (ilo_sex), statistic(mean ilo_job1_how_usual) ///
    statistic(count ilo_job1_how_usual)

* ---- Part 5: district indicators ---------------------------------------
preserve
collapse (mean) employed ilo_age ///
    (count) persons=employed ///
    if !missing(employed), by(district)
list in 1/5
save "output/district_indicators.dta", replace
restore
count
egen share_emp = mean(employed), by(district)
list district share_emp in 1/5

* ---- Part 6: charts -----------------------------------------------------
graph hbar (mean) ilo_job1_how_usual, over(region) ///
    title("Usual weekly hours, main job") ///
    ytitle("Mean hours") ///
    note("Source: NBS, LFS Q1 2026 (sample, unweighted)")
graph export "output/fig1_hours.png", replace
histogram ilo_job1_how_usual
use "output/district_indicators.dta", clear
twoway scatter employed ilo_age

log close
