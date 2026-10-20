* =====================================================================
* check_D3.do  —  Day 3 daily check
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 3 (18 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_svy.dta, output/estimates_q1.xlsx,
*              output/release_q1.xlsx (your products from today)
* Outputs    : output/check_D3_<code>.csv (one line per check)
* Packages   : none
* ---------------------------------------------------------------------
* WHAT TO DO
*   1. Type your participant code between the quotes on the line
*      below (it is on your name card), e.g.  local code "P07"
*   2. Type one sentence between the quotes on the "unclear" line:
*      what was unclear today? (Leave it empty if nothing.)
*   3. Close Excel. Save, then run the whole file with Ctrl + D.
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

if "`code'" == "" & "$NBS_CODE" != "" local code "$NBS_CODE"
if "`code'" == "" {
    display as error "Type your participant code on the  local code  line, then run again."
    exit 198
}

tempname fh
file open `fh' using "output/check_D3_`code'.csv", write replace text
file write `fh' "code,day,check,result" _n

local done 0

* Check 1: the declared file exists and carries NBS's design (Part 3)
local ok 0
capture use "data/lfs_svy.dta", clear
if _rc == 0 {
    quietly svyset
    local ok = ("`r(su1)'" == "psu" & "`r(strata1)'" == "district" & strpos("`r(wexp)'`r(wvar)'", "wgt_final") > 0)
}
file write `fh' "`code',3,1_design,`ok'" _n
local done = `done' + `ok'

* Check 2: the design gives NBS's national unemployment rate (Part 4)
local ok 0
if `ok' == 0 & _N == 5888 {
    capture {
        generate _lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
        generate _un = (ilo_lfs19 == 2)
        quietly svy, subpop(_lf): mean _un
    }
    if _rc == 0 local ok = (abs(_b[_un] - .033066) < 1e-5 & abs(_se[_un] - .0034775) < 1e-6)
}
file write `fh' "`code',3,2_national_rate,`ok'" _n
local done = `done' + `ok'

* Check 3: the estimates file, Unemployment sheet: 7 regions (Part 8)
local ok 0
capture import excel using "output/estimates_q1.xlsx", sheet("Unemployment") clear
if _rc == 0 local ok = (_N == 8)
file write `fh' "`code',3,3_unemployment_sheet,`ok'" _n
local done = `done' + `ok'

* Check 4: the Participation sheet (Part 8)
local ok 0
capture import excel using "output/estimates_q1.xlsx", sheet("Participation") clear
if _rc == 0 local ok = (_N == 8)
file write `fh' "`code',3,4_participation_sheet,`ok'" _n
local done = `done' + `ok'

* Check 5: the Notes sheet with the svyset line (Part 8 extra)
local ok 0
capture import excel using "output/estimates_q1.xlsx", sheet("Notes") clear
if _rc == 0 {
    capture confirm string variable A
    if _rc == 0 {
        quietly count if strpos(A, "svyset") > 0
        local ok = (r(N) >= 1)
    }
}
file write `fh' "`code',3,5_notes_sheet,`ok'" _n
local done = `done' + `ok'

* Check 6: Lab 2's release file with three sheets
local ok 0
capture import excel using "output/release_q1.xlsx", describe
if _rc == 0 local ok = (r(N_worksheet) == 3)
file write `fh' "`code',3,6_release_file,`ok'" _n
local done = `done' + `ok'

file write `fh' `"`code',3,unclear,"`unclear'""' _n
file close `fh'

display as text _n "`done' of 6 checks done. Thank you."
display as text "Your result file: output/check_D3_`code'.csv"
