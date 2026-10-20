* =====================================================================
* catchup_D5_S2.do  —  Day 5 catch-up: end of Part 2, Loops and checks
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta, data/lfs_raw.dta, data/lfs_svy.dta
* Outputs    : logs/day5.log
* Packages   : none
* USE        : close Word and Excel, open this file, press Ctrl + D. Your Stata is
*              now where the room is at the end of Part 2.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture log close
log using "logs/day5.log", replace text

* ---- Part 1: Macros
* Task 2: a local holds a list
use "data/lfs_teach.dta", clear
local vars "ilo_sex agegrp region"
display "`vars'"
foreach v of local vars {
    tabulate `v'
}
* Task 3: a global holds a setting
global root "C:/NBS_Stata"
global quarter "2026Q1"
display "$root"
display "$quarter"
* Task 4: paths built from the root
use "$root/data/lfs_raw.dta", clear
describe, short
* Task 5: Stata's own facts
display "Run on `c(current_date)' with Stata `c(stata_version)'"
display c(N)
* Task 6: a local lives for one run
local tmp "only here"
display "[`tmp']"
* Task 7: the globals that are set
macro list root quarter
* Task 8: text or a number
local a 2+2
local b = 2+2
display "`a'"
display "`b'"
display `a' * 3
display `b' * 3
* Task 9: a setting used in a condition
use "$root/data/lfs_teach.dta", clear
global youth_max 24
count if inrange(ilo_age, 15, $youth_max)

* ---- Part 2: Loops and checks
* Task 10: one rate per region
use "$root/data/lfs_svy.dta", clear
quietly generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
quietly generate unemp = (ilo_lfs19 == 2)
quietly generate emp = (ilo_lfs19 == 1)
quietly generate wap = (ilo_age >= 15)
forvalues r = 1/7 {
    quietly svy, subpop(if lf == 1 & region == `r'): mean unemp
    matrix T = r(table)
    display "Region `r': " %5.2f 100 * T[1, 1]
}
* Task 11: the name from the value label
forvalues r = 1/7 {
    local name : label (region) `r'
    quietly svy, subpop(if lf == 1 & region == `r'): mean unemp
    matrix T = r(table)
    display "`name'" _col(24) %5.2f 100 * T[1, 1]
}
* Task 12: the same rates in one command
svy, subpop(lf): mean unemp, over(region)
* Task 13: foreach over numbers
foreach a of numlist 15 25 35 55 {
    quietly count if ilo_age >= `a'
    display "aged `a' and over: " r(N)
}
* Task 14: foreach over variables
foreach v of varlist ilo_sex agegrp {
    quietly svy, subpop(lf): mean unemp, over(`v')
    matrix T = r(table)
    display "`v': " %5.2f 100 * T[1, 1] "  " %5.2f 100 * T[1, 2]
}
* Task 15: steps other than one
forvalues y = 2010(5)2025 {
    display "year `y'"
}
* Task 16: a loop inside a loop
forvalues r = 1/7 {
    local name : label (region) `r'
    forvalues s = 1/2 {
        quietly svy, subpop(if lf == 1 & region == `r' & ilo_sex == `s'): mean unemp
        matrix T = r(table)
        display "`name'" _col(24) "sex `s'" _col(32) %5.2f 100 * T[1, 1]
    }
}
* Task 17: into a matrix
matrix R = J(7, 2, .)
forvalues r = 1/7 {
    forvalues s = 1/2 {
        quietly svy, subpop(if lf == 1 & region == `r' & ilo_sex == `s'): mean unemp
        matrix T = r(table)
        matrix R[`r', `s'] = 100 * T[1, 1]
    }
}
matrix colnames R = men women
matrix list R, format(%5.2f)
* Task 18: did it work?
capture confirm file "$root/data/lfs_raw.dta"
display _rc
capture confirm file "$root/data/lfs_2025Q4_raw.dta"
display _rc
* Task 19: check the input, stop with a message
capture confirm file "$root/data/lfs_raw.dta"
if _rc {
    display as error "Input missing: $root/data/lfs_raw.dta"
    exit 601
}

log close
