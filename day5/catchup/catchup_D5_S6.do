* =====================================================================
* catchup_D5_S6.do  —  Day 5 catch-up: end of Part 6, Refactoring
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta
* Outputs    : data/lfs_ilo_2026Q1.dta, logs/my_ilo.log
* Packages   : none
* USE        : this IS the refactored legacy file of Part 6. Save it as
*              day5/refactor/my_ilo.do, then press Ctrl + D.
* =====================================================================

* ---- Fix 2: one settings block; every global set once --------------
version 17
clear all
global root "C:/NBS_Stata"
global quarter "2026Q1"
global wgt "weights_dis"

* ---- Fix 3: a log and an input check -------------------------------
capture log close
log using "$root/logs/my_ilo.log", replace text
capture confirm file "$root/data/lfs_raw.dta"
if _rc {
    display as error "Input missing: $root/data/lfs_raw.dta"
    exit 601
}

* ---- Fix 1: every path built from $root ----------------------------
use "$root/data/lfs_raw.dta", clear
duplicates drop
drop if ilo_age < 15
generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
generate un = (ilo_lfs19 == 2)
* unemployment rate (quick weighted look; the published figure uses svy)
tabulate un if lf == 1 [iweight = $wgt]
tabulate un dem_sex if lf == 1 [iweight = $wgt], column
tabulate un region_q if lf == 1 [iweight = $wgt], column nofreq
save "$root/data/lfs_ilo_${quarter}.dta", replace
log close
