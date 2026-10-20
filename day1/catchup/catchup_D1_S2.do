* =====================================================================
* catchup_D1_S2.do  —  Day 1 catch-up: end of Part 2, Do-files and logs
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 1 (16 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta
* Outputs    : logs/day1.log
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 2. To keep working, save this
*              file as day1/my_day1.do and add the next parts below it.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture log close
log using "logs/day1.log", replace text

* ---- Data in (Parts 1-2) -------------------------------------------------
use "data/lfs_raw.dta", clear
count
describe
tabulate ilo_sex

log close
