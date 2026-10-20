* =====================================================================
* catchup_D1_S6.do  —  Day 1 catch-up: end of Part 6, New variables
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 1 (16 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta, data/district_lookup.xlsx
* Outputs    : logs/day1.log
* Packages   : none
* USE        : open this file, press Ctrl + D. Your Stata is now where the
*              room is at the end of Part 6. To keep working, save this
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

* ---- Part 3: the district list from Excel, saved as a Stata file --------
import excel "data/district_lookup.xlsx", firstrow clear
save "data/district_lookup.dta", replace
use "data/lfs_raw.dta", clear

* ---- Part 4: don't-know codes -------------------------------------------
* .a = don't know, .b = refused (labels read first with codebook)
mvdecode dem_mrt dem_edl, mv(97=.a \ 99=.b)
mvdecode mie_socpro, mv(97=.a)
assert missing(ilo_lfs19) if ilo_age < 15

* ---- Part 5: labels ------------------------------------------------------
label variable weight "Base weight"
label variable dis_weight "District adjustment"
label variable weights_dis "Final weight"
label define sexlbl 1 "Male" 2 "Female"
label values dem_sex sexlbl
label define DEM_MRT .a "Don't know" .b "Refusal", add

* ---- Part 6: teaching names and indicators ------------------------------
rename region_q region
rename district_q district
rename psu_nbs_2026 psu
rename ea_q ea
rename weight wgt_base
rename dis_weight wgt_adj
rename weights_dis wgt_final
generate employed = (ilo_lfs19 == 1) if !missing(ilo_lfs19)
generate unemployed = 0 if !missing(ilo_lfs19)
replace unemployed = 1 if ilo_lfs19 == 2
assert employed + unemployed <= 1 if !missing(ilo_lfs19)
recode ilo_age (0/14 = .) (15/24 = 1) (25/34 = 2) ///
    (35/54 = 3) (55/max = 4), generate(agegrp)
label define agelbl 1 "15-24" 2 "25-34" 3 "35-54" 4 "55+"
label values agegrp agelbl
label variable agegrp "Age group"
egen hhsize = count(unique_ind), by(unique_hhd)
mvdecode wkt_mj_acthrs, mv(997=.a)

log close
