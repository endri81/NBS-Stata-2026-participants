* =====================================================================
* setup_check.do  —  is this PC ready for the course?
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, 16-20 Nov 2026
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Purpose    : seven checks on one PC: Stata version, the course folder
*              and its subfolders, the 13 data files, the raw file opens,
*              and Stata can write a log, an Excel file, a Word file and
*              a chart. Run it after install_course.do (or after the
*              folders and data were copied by hand), before Day 1.
* Inputs     : C:/NBS_Stata and its data folder
* Outputs    : on screen; test files are written and deleted again
* Packages   : none
* USE        : open in the Do-file Editor, Ctrl + D. Last line:
*              "setup check: 7 of 7 OK". Anything else: the red lines
*              say what to fix.
* STATUS     : verified 20 Oct 2026, Stata 19.5 MP: 7 of 7 OK
* =====================================================================
version 17
clear all
set more off
local course "C:/NBS_Stata"
local ok 0

* 1 Stata version ------------------------------------------------------
if c(stata_version) >= 17 {
    display as result "ok    1 Stata `c(stata_version)' (`c(edition_real)')"
    local ++ok
}
else display as error "FAIL  1 Stata `c(stata_version)': the course needs 17 or newer"

* 2 Folders --------------------------------------------------------------
local miss ""
foreach f in "" data output logs day1 day2 day3 day4 day5 {
    mata: st_local("there", strofreal(direxists("`course'/`f'")))
    if `there' == 0 local miss "`miss' `f'"
}
if "`miss'" == "" {
    display as result "ok    2 folders in `course'"
    local ++ok
}
else display as error "FAIL  2 folder(s) missing in `course':`miss'"

* 3 Data files -----------------------------------------------------------
local miss ""
foreach f in lfs_raw.dta lfs_jan.dta lfs_feb.dta lfs_mar.dta lfs_hh.dta ///
    lfs_person.dta lfs_coding.dta lfs_district_month.dta district_lookup.csv ///
    district_lookup.xlsx cpi_monthly.dta cpi_divisions_wide.dta cpi_divisions_long.dta {
    capture confirm file "`course'/data/`f'"
    if _rc local miss "`miss' `f'"
}
if "`miss'" == "" {
    display as result "ok    3 all 13 data files in `course'/data"
    local ++ok
}
else display as error "FAIL  3 missing in `course'/data:`miss'"

* 4 The raw file opens ---------------------------------------------------
capture {
    use "`course'/data/lfs_raw.dta", clear
    assert _N == 5895
}
if _rc == 0 {
    display as result "ok    4 lfs_raw.dta opens: 5,895 records"
    local ++ok
}
else display as error "FAIL  4 lfs_raw.dta does not open, or is not the course file"

* 5 A log can be written -------------------------------------------------
capture {
    log using "`course'/logs/_setup_test.log", replace text name(setuptest)
    log close setuptest
    erase "`course'/logs/_setup_test.log"
}
if _rc == 0 {
    display as result "ok    5 Stata can write in `course'/logs"
    local ++ok
}
else display as error "FAIL  5 cannot write in `course'/logs (folder blocked?)"

* 6 Excel and Word -------------------------------------------------------
capture {
    putexcel set "`course'/output/_setup_test.xlsx", replace
    putexcel A1 = "setup test"
    putexcel clear
    erase "`course'/output/_setup_test.xlsx"
    putdocx clear
    putdocx begin
    putdocx paragraph
    putdocx text ("setup test")
    putdocx save "`course'/output/_setup_test.docx", replace
    erase "`course'/output/_setup_test.docx"
}
if _rc == 0 {
    display as result "ok    6 Excel and Word files can be written"
    local ++ok
}
else display as error "FAIL  6 Excel or Word file not written (is the output folder blocked?)"

* 7 A chart can be saved -------------------------------------------------
capture {
    histogram ilo_age, frequency
    graph export "`course'/output/_setup_test.png", replace
    graph close _all
    erase "`course'/output/_setup_test.png"
}
if _rc == 0 {
    display as result "ok    7 charts can be drawn and saved"
    local ++ok
}
else display as error "FAIL  7 the chart was not saved"

clear
display _n as result "setup check: `ok' of 7 OK"
