* =====================================================================
* catchup_D5_S4.do  —  Day 5 catch-up: end of Part 4, The master do-file
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta, data/cpi_divisions_long.dta, the five modules
* Outputs    : every master output, logs/master_2026Q1.log
* Packages   : none
* USE        : this IS the master do-file of Part 4. Save it as day5/master.do
*              (File > Save As), close Word and Excel, press Ctrl + D.
* =====================================================================

* ---- Settings: the only lines a colleague changes -------------------
version 17
clear all
global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24

* ---- Checks: stop early, with a clear message ------------------------
foreach f in "data/lfs_raw.dta" "data/cpi_divisions_long.dta" {
    capture confirm file "$root/`f'"
    if _rc {
        display as error "Input missing: $root/`f'"
        exit 601
    }
}
capture mkdir "$root/output"
capture mkdir "$root/logs"

* ---- One log for the whole run ---------------------------------------
capture log close
log using "$root/logs/master_${quarter}.log", replace text
display "Run on `c(current_date)' at Stata `c(stata_version)', quarter $quarter"

* ---- The modules, in order -------------------------------------------
timer clear
timer on 1
do "$root/day5/modules/01_clean.do"
do "$root/day5/modules/02_design.do"
do "$root/day5/modules/03_estimates.do"
do "$root/day5/modules/04_model.do"
do "$root/day5/modules/05_report.do"
timer off 1
timer list 1

log close
