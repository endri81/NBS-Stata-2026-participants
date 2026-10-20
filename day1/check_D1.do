* =====================================================================
* check_D1.do  —  Day 1 daily check
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 1 (16 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta (your product from Part 9)
* Outputs    : output/check_D1_<code>.csv (one line per check)
* Packages   : none
* ---------------------------------------------------------------------
* WHAT TO DO
*   1. Type your participant code between the quotes on the line
*      below (it is on your name card), e.g.  local code "P07"
*   2. Type one sentence between the quotes on the "unclear" line:
*      what was unclear today? (Leave it empty if nothing.)
*   3. Save, then run the whole file with Ctrl + D.
*   You will see "... of 6 checks done". This is not a grade.
*
* Lines below "TRAINER MACHINERY" use commands from later in the week.
* Do not change them.
* =====================================================================

local code    ""
local unclear ""


* ===================== TRAINER MACHINERY ==============================
version 17
clear all
cd "C:/NBS_Stata"
capture mkdir "output"

if "`code'" == "" {
    display as error "Type your participant code on the  local code  line, then run again."
    exit 198
}

tempname fh
file open `fh' using "output/check_D1_`code'.csv", write replace text
file write `fh' "code,day,check,result" _n

local done 0

* Check 1: the analysis file exists and opens
capture use "data/lfs_teach.dta", clear
local ok = (_rc == 0)
file write `fh' "`code',1,1_file_opens,`ok'" _n
local done = `done' + `ok'
if !`ok' {
    file write `fh' `"`code',1,unclear,"`unclear'""' _n
    file close `fh'
    display as error "lfs_teach.dta could not be opened: checks 2 to 6 cannot run."
    display as text "0 of 6 checks done. Ask the trainer for catchup_D1_S9.do."
    exit
}

* Check 2: one person, one row
capture isid unique_ind
local ok = (_rc == 0)
file write `fh' "`code',1,2_isid,`ok'" _n
local done = `done' + `ok'

* Check 3: duplicates removed (5,888 persons)
local ok = (_N == 5888)
file write `fh' "`code',1,3_n_persons,`ok'" _n
local done = `done' + `ok'

* Check 4: teaching names and a labelled final weight
capture confirm variable wgt_final region district psu
local ok = (_rc == 0)
if `ok' local ok = ("`: variable label wgt_final'" != "")
file write `fh' "`code',1,4_names_labels,`ok'" _n
local done = `done' + `ok'

* Check 5: don't-know and refusal codes are missing values
capture assert !inlist(dem_mrt, 97, 99) & !inlist(dem_edl, 97, 99)
local ok = (_rc == 0)
file write `fh' "`code',1,5_dk_codes,`ok'" _n
local done = `done' + `ok'

* Check 6: indicators built correctly
capture confirm variable employed unemployed agegrp
local ok = (_rc == 0)
if `ok' {
    capture assert employed + unemployed <= 1 if !missing(ilo_lfs19)
    local ok = (_rc == 0)
}
if `ok' {
    capture assert missing(agegrp) if ilo_age < 15
    local ok = (_rc == 0)
}
file write `fh' "`code',1,6_indicators,`ok'" _n
local done = `done' + `ok'

file write `fh' `"`code',1,unclear,"`unclear'""' _n
file close `fh'

display as text _n "`done' of 6 checks done. Thank you."
display as text "Your result file: output/check_D1_`code'.csv"
