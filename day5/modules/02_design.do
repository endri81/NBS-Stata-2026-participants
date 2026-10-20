* =====================================================================
* 02_design.do  —  module 2: the sample design and the flags (Day 3)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : $root/data/lfs_${quarter}_teach.dta
* Outputs    : $root/data/lfs_${quarter}_svy.dta
* Packages   : none
* Called by  : master.do (needs root, quarter and youth_max)
* =====================================================================
version 17
use "$root/data/lfs_${quarter}_teach.dta", clear

* The weights must follow the design before they are used.
assert abs(wgt_base * wgt_adj - wgt_final) < 1e-4
bysort psu: assert wgt_base == wgt_base[1]
bysort district: assert wgt_adj == wgt_adj[1]

* PSU = cluster, district = stratum, wgt_final = weight.
svyset psu [pweight = wgt_final], strata(district)

* ILO 19th ICLS flags, 0/1 and never missing.
generate wap = (ilo_age >= 15)
generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
generate unemp = (ilo_lfs19 == 2)
generate emp = (ilo_lfs19 == 1)
* Youth: 15 to $youth_max (a setting in master.do).
generate youth = inrange(ilo_age, 15, $youth_max)
generate lf_youth = lf * youth
assert !missing(wap, lf, unemp, emp, youth, lf_youth)

save "$root/data/lfs_${quarter}_svy.dta", replace
