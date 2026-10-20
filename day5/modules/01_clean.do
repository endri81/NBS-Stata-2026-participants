* =====================================================================
* 01_clean.do  —  module 1: raw LFS file to the analysis file (Day 1)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : $root/data/lfs_raw.dta
* Outputs    : $root/data/lfs_${quarter}_teach.dta
* Packages   : none
* Called by  : master.do (needs the globals root and quarter)
* =====================================================================
version 17
use "$root/data/lfs_raw.dta", clear

* One person, one row: duplicates first, so later counts are of persons.
duplicates drop
isid unique_ind
isid unique_hhd ppno

* Don't-know (.a) and refused (.b) codes, as read from the labels.
mvdecode dem_mrt dem_edl, mv(97=.a \ 99=.b)
mvdecode mie_socpro, mv(97=.a)
mvdecode wkt_mj_acthrs, mv(997=.a)
assert missing(ilo_lfs19) if ilo_age < 15

* Teaching names for the design variables.
rename region_q region
rename district_q district
rename psu_nbs_2026 psu
rename ea_q ea
rename weight wgt_base
rename dis_weight wgt_adj
rename weights_dis wgt_final
label variable wgt_base "Base weight"
label variable wgt_adj "District adjustment"
label variable wgt_final "Final weight"

* Age groups used in every table of the week.
recode ilo_age (0/14 = .) (15/24 = 1) (25/34 = 2) ///
    (35/54 = 3) (55/max = 4), generate(agegrp)
label define agelbl 1 "15-24" 2 "25-34" 3 "35-54" 4 "55+"
label values agegrp agelbl
label variable agegrp "Age group"

* Variables nobody analyses: a merge flag, an empty name, free text and
* a constant 1 that only looks like a weight.
drop _merge dem_name mjj_occ_tle ilo_wgt
order unique_ind unique_hhd ppno region district psu ea wgt_*
isid unique_ind
assert inlist(region, 1, 2, 3, 4, 5, 6, 7)
label data "NBS LFS $quarter, teaching file"
compress
save "$root/data/lfs_${quarter}_teach.dta", replace
