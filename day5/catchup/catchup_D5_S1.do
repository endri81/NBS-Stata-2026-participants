* =====================================================================
* catchup_D5_S1.do  —  Day 5 catch-up: end of Part 1, Macros
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta, data/lfs_raw.dta
* Outputs    : logs/day5.log
* Packages   : none
* USE        : close Word and Excel, open this file, press Ctrl + D. Your Stata is
*              now where the room is at the end of Part 1.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture log close
log using "logs/day5.log", replace text

* ---- Part 1: Macros
* Task 2: a local holds a list
use "data/lfs_teach.dta", clear
local vars "ilo_sex agegrp region"
display "`vars'"
foreach v of local vars {
    tabulate `v'
}
* Task 3: a global holds a setting
global root "C:/NBS_Stata"
global quarter "2026Q1"
display "$root"
display "$quarter"
* Task 4: paths built from the root
use "$root/data/lfs_raw.dta", clear
describe, short
* Task 5: Stata's own facts
display "Run on `c(current_date)' with Stata `c(stata_version)'"
display c(N)
* Task 6: a local lives for one run
local tmp "only here"
display "[`tmp']"
* Task 7: the globals that are set
macro list root quarter
* Task 8: text or a number
local a 2+2
local b = 2+2
display "`a'"
display "`b'"
display `a' * 3
display `b' * 3
* Task 9: a setting used in a condition
use "$root/data/lfs_teach.dta", clear
global youth_max 24
count if inrange(ilo_age, 15, $youth_max)

log close
