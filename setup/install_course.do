* =====================================================================
* install_course.do  —  set up the course folder on a PC
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, 16-20 Nov 2026
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Purpose    : build the course folder C:/NBS_Stata on one PC from this
*              package: folders, the five days' exercise files, the
*              data (if the package holds them). Run once per PC, before
*              Day 1. Safe to run again: files are replaced, your own
*              my_dayN.do files are never touched.
* Inputs     : this package
* Outputs    : C:/NBS_Stata and its subfolders
* Packages   : none
* USE        : double-click this file, then Ctrl + D. Last line:
*              "setup OK" with your Stata version.
* =====================================================================
version 17
clear all

* ---- The only line to check: where this package is ---------------------
* If you opened this file by double-clicking it in the package's setup
* folder, leave the line as it is. Otherwise type the package folder,
* for example "E:/NBS_Stata_Workshop".
global pkg ""

* ---- Settings (do not change: every course file uses this folder) ------
global course "C:/NBS_Stata"
* Trainer PC only: 1 also copies the solutions to C:/NBS_Stata/_trainer.
global with_solutions 0

if "$pkg" == "" {
    * Stata starts in the folder of a double-clicked do-file: setup/
    local here = subinstr("`c(pwd)'", "\", "/", .)
    capture confirm file "`here'/../setup/install_course.do"
    if _rc == 0 global pkg "`here'/.."
    capture confirm file "`here'/setup/install_course.do"
    if _rc == 0 global pkg "`here'"
}
capture confirm file "$pkg/setup/install_course.do"
if _rc {
    display as error "Package not found. Type its folder on the  global pkg  line."
    exit 601
}

* The full package keeps exercises in dayN/exercises; the USB copy in dayN
global ex ""
capture confirm file "$pkg/day1/exercises/lab_D1_1.do"
if _rc == 0 global ex "exercises/"

* ---- Stata version ------------------------------------------------------
if c(stata_version) < 17 {
    display as error "This course needs Stata 17 or newer. This PC has `c(stata_version)'."
    exit 9
}

* ---- Folders --------------------------------------------------------------
capture mkdir "$course"
capture mkdir "$course/data"
capture mkdir "$course/output"
capture mkdir "$course/logs"
capture mkdir "$course/day1"
capture mkdir "$course/day2"
capture mkdir "$course/day3"
capture mkdir "$course/day4"
capture mkdir "$course/day5"
capture mkdir "$course/day1/catchup"
capture mkdir "$course/day2/catchup"
capture mkdir "$course/day3/catchup"
capture mkdir "$course/day4/catchup"
capture mkdir "$course/day5/catchup"
capture mkdir "$course/day5/labs"
capture mkdir "$course/day5/modules"
capture mkdir "$course/day5/practice"
capture mkdir "$course/day5/refactor"

* ---- Exercise files, laid out as the slides show them ----------------------
* Day 1
copy "$pkg/day1/${ex}lab_D1_1.do" "$course/day1/lab_D1_1.do", replace
copy "$pkg/day1/${ex}lab_D1_2.do" "$course/day1/lab_D1_2.do", replace
copy "$pkg/day1/${ex}practice_D1.do" "$course/day1/practice_D1.do", replace
copy "$pkg/day1/${ex}check_D1.do" "$course/day1/check_D1.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S1.do" "$course/day1/catchup/catchup_D1_S1.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S2.do" "$course/day1/catchup/catchup_D1_S2.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S3.do" "$course/day1/catchup/catchup_D1_S3.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S4.do" "$course/day1/catchup/catchup_D1_S4.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S5.do" "$course/day1/catchup/catchup_D1_S5.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S6.do" "$course/day1/catchup/catchup_D1_S6.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S7.do" "$course/day1/catchup/catchup_D1_S7.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S8.do" "$course/day1/catchup/catchup_D1_S8.do", replace
copy "$pkg/day1/${ex}catchup/catchup_D1_S9.do" "$course/day1/catchup/catchup_D1_S9.do", replace
* Day 2
copy "$pkg/day2/${ex}lab_D2_1.do" "$course/day2/lab_D2_1.do", replace
copy "$pkg/day2/${ex}lab_D2_2.do" "$course/day2/lab_D2_2.do", replace
copy "$pkg/day2/${ex}practice_D2.do" "$course/day2/practice_D2.do", replace
copy "$pkg/day2/${ex}check_D2.do" "$course/day2/check_D2.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S1.do" "$course/day2/catchup/catchup_D2_S1.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S2.do" "$course/day2/catchup/catchup_D2_S2.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S3.do" "$course/day2/catchup/catchup_D2_S3.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S4.do" "$course/day2/catchup/catchup_D2_S4.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S5.do" "$course/day2/catchup/catchup_D2_S5.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S6.do" "$course/day2/catchup/catchup_D2_S6.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S7.do" "$course/day2/catchup/catchup_D2_S7.do", replace
copy "$pkg/day2/${ex}catchup/catchup_D2_S8.do" "$course/day2/catchup/catchup_D2_S8.do", replace
* Day 3
copy "$pkg/day3/${ex}lab_D3_1.do" "$course/day3/lab_D3_1.do", replace
copy "$pkg/day3/${ex}lab_D3_2.do" "$course/day3/lab_D3_2.do", replace
copy "$pkg/day3/${ex}practice_D3.do" "$course/day3/practice_D3.do", replace
copy "$pkg/day3/${ex}check_D3.do" "$course/day3/check_D3.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S1.do" "$course/day3/catchup/catchup_D3_S1.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S2.do" "$course/day3/catchup/catchup_D3_S2.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S3.do" "$course/day3/catchup/catchup_D3_S3.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S4.do" "$course/day3/catchup/catchup_D3_S4.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S5.do" "$course/day3/catchup/catchup_D3_S5.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S6.do" "$course/day3/catchup/catchup_D3_S6.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S7.do" "$course/day3/catchup/catchup_D3_S7.do", replace
copy "$pkg/day3/${ex}catchup/catchup_D3_S8.do" "$course/day3/catchup/catchup_D3_S8.do", replace
* Day 4
copy "$pkg/day4/${ex}lab_D4_1.do" "$course/day4/lab_D4_1.do", replace
copy "$pkg/day4/${ex}lab_D4_2.do" "$course/day4/lab_D4_2.do", replace
copy "$pkg/day4/${ex}practice_D4.do" "$course/day4/practice_D4.do", replace
copy "$pkg/day4/${ex}check_D4.do" "$course/day4/check_D4.do", replace
copy "$pkg/day4/${ex}catchup/catchup_D4_S1.do" "$course/day4/catchup/catchup_D4_S1.do", replace
copy "$pkg/day4/${ex}catchup/catchup_D4_S2.do" "$course/day4/catchup/catchup_D4_S2.do", replace
copy "$pkg/day4/${ex}catchup/catchup_D4_S3.do" "$course/day4/catchup/catchup_D4_S3.do", replace
copy "$pkg/day4/${ex}catchup/catchup_D4_S4.do" "$course/day4/catchup/catchup_D4_S4.do", replace
copy "$pkg/day4/${ex}catchup/catchup_D4_S5.do" "$course/day4/catchup/catchup_D4_S5.do", replace
copy "$pkg/day4/${ex}catchup/catchup_D4_S6.do" "$course/day4/catchup/catchup_D4_S6.do", replace
copy "$pkg/day4/${ex}catchup/catchup_D4_S7.do" "$course/day4/catchup/catchup_D4_S7.do", replace
* Day 5
copy "$pkg/day5/${ex}labs/lab_D5_1.do" "$course/day5/labs/lab_D5_1.do", replace
copy "$pkg/day5/${ex}practice/practice_D5.do" "$course/day5/practice/practice_D5.do", replace
copy "$pkg/day5/${ex}check_D5.do" "$course/day5/check_D5.do", replace
copy "$pkg/day5/${ex}refactor/legacy_ilo.do" "$course/day5/refactor/legacy_ilo.do", replace
copy "$pkg/day5/${ex}modules/01_clean.do" "$course/day5/modules/01_clean.do", replace
copy "$pkg/day5/${ex}modules/02_design.do" "$course/day5/modules/02_design.do", replace
copy "$pkg/day5/${ex}modules/03_estimates.do" "$course/day5/modules/03_estimates.do", replace
copy "$pkg/day5/${ex}modules/04_model.do" "$course/day5/modules/04_model.do", replace
copy "$pkg/day5/${ex}modules/05_report.do" "$course/day5/modules/05_report.do", replace
copy "$pkg/day5/${ex}catchup/catchup_D5_S1.do" "$course/day5/catchup/catchup_D5_S1.do", replace
copy "$pkg/day5/${ex}catchup/catchup_D5_S2.do" "$course/day5/catchup/catchup_D5_S2.do", replace
copy "$pkg/day5/${ex}catchup/catchup_D5_S3.do" "$course/day5/catchup/catchup_D5_S3.do", replace
copy "$pkg/day5/${ex}catchup/catchup_D5_S4.do" "$course/day5/catchup/catchup_D5_S4.do", replace
copy "$pkg/day5/${ex}catchup/catchup_D5_S5.do" "$course/day5/catchup/catchup_D5_S5.do", replace
copy "$pkg/day5/${ex}catchup/catchup_D5_S6.do" "$course/day5/catchup/catchup_D5_S6.do", replace
copy "$pkg/day5/${ex}catchup/catchup_D5_S7.do" "$course/day5/catchup/catchup_D5_S7.do", replace

* ---- Data: copied if the package holds them (the NBS USB does) -------------
local missing 0
foreach f in ///
    "lfs_raw.dta" ///
    "lfs_jan.dta" ///
    "lfs_feb.dta" ///
    "lfs_mar.dta" ///
    "lfs_hh.dta" ///
    "lfs_person.dta" ///
    "lfs_coding.dta" ///
    "lfs_district_month.dta" ///
    "district_lookup.csv" ///
    "district_lookup.xlsx" ///
    "cpi_monthly.dta" ///
    "cpi_divisions_wide.dta" ///
    "cpi_divisions_long.dta" {
    capture confirm file "$pkg/data/`f'"
    if _rc == 0 copy "$pkg/data/`f'" "$course/data/`f'", replace
    capture confirm file "$course/data/`f'"
    if _rc {
        display as error "Data file missing: `f' (copy it from the NBS USB to $course/data)"
        local ++missing
    }
}

* ---- Solutions: trainer PC only ---------------------------------------------
capture confirm file "$pkg/day1/solutions/lab_D1_1_solution.do"
if $with_solutions == 1 & _rc == 0 {
    capture mkdir "$course/_trainer"
    capture mkdir "$course/_trainer/day1"
    copy "$pkg/day1/solutions/lab_D1_1_solution.do" "$course/_trainer/day1/lab_D1_1_solution.do", replace
    copy "$pkg/day1/solutions/lab_D1_2_solution.do" "$course/_trainer/day1/lab_D1_2_solution.do", replace
    copy "$pkg/day1/solutions/practice_D1_solution.do" "$course/_trainer/day1/practice_D1_solution.do", replace
    copy "$pkg/day1/solutions/my_day1_complete.do" "$course/_trainer/day1/my_day1_complete.do", replace
    capture mkdir "$course/_trainer/day2"
    copy "$pkg/day2/solutions/lab_D2_1_solution.do" "$course/_trainer/day2/lab_D2_1_solution.do", replace
    copy "$pkg/day2/solutions/lab_D2_2_solution.do" "$course/_trainer/day2/lab_D2_2_solution.do", replace
    copy "$pkg/day2/solutions/practice_D2_solution.do" "$course/_trainer/day2/practice_D2_solution.do", replace
    capture mkdir "$course/_trainer/day3"
    copy "$pkg/day3/solutions/lab_D3_1_solution.do" "$course/_trainer/day3/lab_D3_1_solution.do", replace
    copy "$pkg/day3/solutions/lab_D3_2_solution.do" "$course/_trainer/day3/lab_D3_2_solution.do", replace
    copy "$pkg/day3/solutions/practice_D3_solution.do" "$course/_trainer/day3/practice_D3_solution.do", replace
    copy "$pkg/day3/solutions/my_day3_complete.do" "$course/_trainer/day3/my_day3_complete.do", replace
    capture mkdir "$course/_trainer/day4"
    copy "$pkg/day4/solutions/lab_D4_1_solution.do" "$course/_trainer/day4/lab_D4_1_solution.do", replace
    copy "$pkg/day4/solutions/lab_D4_2_solution.do" "$course/_trainer/day4/lab_D4_2_solution.do", replace
    copy "$pkg/day4/solutions/practice_D4_solution.do" "$course/_trainer/day4/practice_D4_solution.do", replace
    copy "$pkg/day4/solutions/my_day4_complete.do" "$course/_trainer/day4/my_day4_complete.do", replace
    capture mkdir "$course/_trainer/day5"
    copy "$pkg/day5/solutions/lab_D5_1_solution.do" "$course/_trainer/day5/lab_D5_1_solution.do", replace
    copy "$pkg/day5/solutions/practice_D5_solution.do" "$course/_trainer/day5/practice_D5_solution.do", replace
    copy "$pkg/day5/solutions/my_day5_complete.do" "$course/_trainer/day5/my_day5_complete.do", replace
    copy "$pkg/day5/solutions/master.do" "$course/_trainer/day5/master.do", replace
    copy "$pkg/day5/solutions/legacy_ilo_fixed.do" "$course/_trainer/day5/legacy_ilo_fixed.do", replace
}

* ---- Result -----------------------------------------------------------------
cd "$course"
if `missing' == 0 {
    use "data/lfs_raw.dta", clear
    assert _N == 5895
    display as result _n "setup OK  ·  Stata `c(stata_version)'  ·  course folder `c(pwd)'"
}
else {
    display as error _n "Folders and exercises are in place; `missing' data file(s) still missing."
}
