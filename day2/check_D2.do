* =====================================================================
* check_D2.do  —  Day 2 daily check
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 2 (17 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : output/district_indicators.dta, output/tables.xlsx,
*              output/pack.xlsx, output/pack.docx,
*              output/fig1_hours.png, output/hours_region1-7.png
*              (your products from Parts 5 to 8)
* Outputs    : output/check_D2_<code>.csv (one line per check)
* Packages   : none
* ---------------------------------------------------------------------
* WHAT TO DO
*   1. Type your participant code between the quotes on the line
*      below (it is on your name card), e.g.  local code "P07"
*   2. Type one sentence between the quotes on the "unclear" line:
*      what was unclear today? (Leave it empty if nothing.)
*   3. Close Excel and Word. Save, then run the whole file with Ctrl + D.
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
file open `fh' using "output/check_D2_`code'.csv", write replace text
file write `fh' "code,day,check,result" _n

local done 0

* Check 1: the district file (Part 5): 26 districts, one row each
capture use "output/district_indicators.dta", clear
local ok = (_rc == 0)
if `ok' {
    capture isid district
    local ok = (_rc == 0 & _N == 26)
}
file write `fh' "`code',2,1_district_file,`ok'" _n
local done = `done' + `ok'

* Check 2: shares between 0 and 1; persons add to the working age (4,627)
local ok 0
capture confirm variable employed persons
if _rc == 0 {
    capture assert inrange(employed, 0, 1)
    if _rc == 0 {
        quietly summarize persons
        local ok = (r(sum) == 4627)
    }
}
file write `fh' "`code',2,2_district_values,`ok'" _n
local done = `done' + `ok'

* Check 3: the bar chart was exported (Part 6)
capture confirm file "output/fig1_hours.png"
local ok = (_rc == 0)
file write `fh' "`code',2,3_chart_png,`ok'" _n
local done = `done' + `ok'

* Check 4: Excel: the table export and the Notes sheet with the mean in B3
local ok 0
capture confirm file "output/tables.xlsx"
if _rc == 0 {
    capture import excel using "output/pack.xlsx", sheet("Notes") clear
    if _rc == 0 {
        capture confirm numeric variable B
        if _rc == 0 & _N >= 3 local ok = (abs(B[3] - 39.83) < 0.01)
    }
}
file write `fh' "`code',2,4_excel,`ok'" _n
local done = `done' + `ok'

* Check 5: the Word pack (Part 7)
capture confirm file "output/pack.docx"
local ok = (_rc == 0)
file write `fh' "`code',2,5_word,`ok'" _n
local done = `done' + `ok'

* Check 6: the loop wrote seven region charts (Part 8)
local ok 1
foreach r in 1 2 3 4 5 6 7 {
    capture confirm file "output/hours_region`r'.png"
    if _rc local ok 0
}
file write `fh' "`code',2,6_loop_charts,`ok'" _n
local done = `done' + `ok'

file write `fh' `"`code',2,unclear,"`unclear'""' _n
file close `fh'

display as text _n "`done' of 6 checks done. Thank you."
display as text "Your result file: output/check_D2_`code'.csv"
