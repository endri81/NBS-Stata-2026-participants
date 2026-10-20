* =====================================================================
* check_D5.do  —  Day 5 daily check
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : your products from today: day5/master.do,
*              logs/lab_D5_1.log, output/release_2026Q1.docx,
*              output/estimates_2026Q1.xlsx, output/my_release_2026Q1.docx,
*              day5/refactor/my_ilo.do
* Outputs    : output/check_D5_<code>.csv (one line per check)
* Packages   : none
* ---------------------------------------------------------------------
* WHAT TO DO
*   1. Type your participant code between the quotes on the line
*      below (it is on your name card), e.g.  local code "P07"
*   2. Type one sentence between the quotes on the "unclear" line:
*      what was unclear today? (Leave it empty if nothing.)
*   3. Close Word and Excel. Save, then run the whole file with Ctrl + D.
*   You will see "... of 6 checks done". This is not a grade.
*
* Lines below "TRAINER MACHINERY" write your result file with commands
* this course does not teach. Do not change them.
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
file open `fh' using "output/check_D5_`code'.csv", write replace text
file write `fh' "code,day,check,result" _n

local done 0
local k 0
foreach f in "day5/master.do" "logs/lab_D5_1.log" "output/release_2026Q1.docx" ///
             "output/estimates_2026Q1.xlsx" "output/my_release_2026Q1.docx" "day5/refactor/my_ilo.do" {
    local ++k
    capture confirm file "`f'"
    local ok = (_rc == 0)
    file write `fh' "`code',5,`k'_`f',`ok'" _n
    local done = `done' + `ok'
}

file write `fh' `"`code',5,unclear,"`unclear'""' _n
file close `fh'

display as text _n "`done' of 6 checks done. Thank you."
display as text "Your result file: output/check_D5_`code'.csv"
