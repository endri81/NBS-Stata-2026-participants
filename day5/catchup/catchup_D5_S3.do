* =====================================================================
* catchup_D5_S3.do  —  Day 5 catch-up: end of Part 3, Modules
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta and the five modules
* Outputs    : logs/day5.log, data/lfs_2026Q1_*.dta, output/estimates_2026Q1.xlsx
* Packages   : none
* USE        : close Word and Excel, open this file, press Ctrl + D. Your Stata is
*              now where the room is at the end of Part 3.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture log close
log using "logs/day5.log", replace text

global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24
* ---- Part 3: Modules
* Task 20: the modules
local files : dir "$root/day5/modules" files "*.do"
foreach f of local files {
    display "`f'"
}
* Task 22: module 01 with its settings
global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24
do "$root/day5/modules/01_clean.do"
* Task 23: module 02 reads what 01 saved
do "$root/day5/modules/02_design.do"
count if lf_youth == 1
* Task 24: module 03 and its Excel file
do "$root/day5/modules/03_estimates.do"
import excel using "$root/output/estimates_${quarter}.xlsx", sheet("National") firstrow clear
list

log close
