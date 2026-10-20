* =====================================================================
* catchup_D5_S7.do  —  Day 5 catch-up: end of Part 7, Discipline
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_2026Q1_svy.dta, data/lfs_raw.dta (rebuilt if missing)
* Outputs    : logs/day5.log
* Packages   : none
* USE        : close Word and Excel, open this file, press Ctrl + D. Your Stata is
*              now where the room is at the end of Part 7.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture log close
log using "logs/day5.log", replace text

global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24
capture confirm file "$root/data/lfs_${quarter}_svy.dta"
if _rc {
    log close
    do "day5/catchup/catchup_D5_S4.do"
    log using "logs/day5.log", append text
}
* ---- Part 7: Discipline
* Task 42: raw data is protected
use "$root/data/lfs_raw.dta", clear
capture save "$root/data/lfs_raw.dta"
display _rc
* Task 43: file names that sort and tell the story
local files : dir "$root/output" files "*2026Q1*"
foreach f of local files {
    display "output: `f'"
}
* Task 44: the version line
version
display c(stata_version)
* Task 45: has the file changed?
use "$root/data/lfs_${quarter}_svy.dta", clear
datasignature set, reset
capture datasignature confirm
display _rc
replace ilo_age = ilo_age + 1 in 1
capture datasignature confirm
display _rc

log close
