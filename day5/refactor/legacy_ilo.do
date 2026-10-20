* ILO indicators LFS - quarterly
* updated many times, last by JP
*cd "Z:\LFS\2026\Q1\"
*global wgt weights_dis
*global qtr "Q1"

use "Z:\LFS\2026\Q1\data\lfs_raw.dta", clear
drop if ilo_age<15
gen lf=1 if ilo_lfs19==1|ilo_lfs19==2
replace lf=0 if lf==.
gen un=ilo_lfs19==2
* unemployment rate
tab un if lf==1 [iw=$wgt]
* by sex
tab un dem_sex if lf==1 [iw=$wgt], col
* by region
tab un region_q if lf==1 [iw=$wgt], col nofreq
save "Z:\LFS\2026\Q1\data\lfs_ilo_$qtr.dta", replace
