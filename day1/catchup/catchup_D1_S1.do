* =====================================================================
* catchup_D1_S1.do  —  Day 1 catch-up: end of Part 1, Your first hour
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 1 (16 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta
* Outputs    : none
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 1. To keep working, save this
*              file as day1/my_day1.do and add the next parts below it.
* =====================================================================

use "C:\NBS_Stata\data\lfs_raw.dta", clear
count
describe
tabulate ilo_sex
