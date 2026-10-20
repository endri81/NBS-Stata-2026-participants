* =====================================================================
* check_D4.do  —  Day 4 daily check
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 4 (19 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : your products from today: output/models.docx,
*              output/note_q1.docx, output/D4_margins.png,
*              output/D4_infl.png, output/model_q1.docx, logs/lab_D4_1.log
* Outputs    : output/check_D4_<code>.csv (one line per check)
* Packages   : none
* ---------------------------------------------------------------------
* WHAT TO DO
*   1. Type your participant code between the quotes on the line
*      below (it is on your name card), e.g.  local code "P07"
*   2. Type one sentence between the quotes on the "unclear" line:
*      what was unclear today? (Leave it empty if nothing.)
*   3. Close Word. Save, then run the whole file with Ctrl + D.
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
file open `fh' using "output/check_D4_`code'.csv", write replace text
file write `fh' "code,day,check,result" _n

local done 0
local k 0
foreach f in "logs/lab_D4_1.log" "output/models.docx" "output/D4_margins.png" ///
             "output/D4_infl.png" "output/note_q1.docx" "output/model_q1.docx" {
    local ++k
    capture confirm file "`f'"
    local ok = (_rc == 0)
    file write `fh' "`code',4,`k'_`f',`ok'" _n
    local done = `done' + `ok'
}

file write `fh' `"`code',4,unclear,"`unclear'""' _n
file close `fh'

display as text _n "`done' of 6 checks done. Thank you."
display as text "Your result file: output/check_D4_`code'.csv"
