* =====================================================================
* lab_D3_1.do  —  Lab 1: Document the design
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 3 (18 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta
* Outputs    : logs/lab_D3_1.log, output/design_D3.xlsx
* Packages   : none
* Location   : C:/NBS_Stata/day3/lab_D3_1.do (from this morning's download)
* ---------------------------------------------------------------------
* THE SITUATION
*   The methodology unit asks for a one-page note on the design of the
*   Q1 2026 LFS: strata, PSUs, weights and the svyset line, with every
*   number produced by Stata, not copied from a report.
*
* HOW THIS LAB WORKS
*   - Each task is written in the comments. Type your code on the
*     empty line(s) under  >>> YOUR CODE.
*   - Run the whole file with Ctrl + D after each task.
*   - Each task ends with a CHECK line, already written for you.
*     If the check is silent, your answer is correct.
*     If you see red text under a CHECK line, fix that task.
*   - Do not change the CHECK lines.
*
* A CORRECT LAB: the whole file runs from top to bottom with no red
*   text, ends with "end of do-file", logs/lab_D3_1.log exists, and
*   the five-line design note in Task 5 is filled in.
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings and the diary
*   Write the five top lines of every course do-file. The diary is
*   logs/lab_D3_1.log.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
assert c(version) == 17


* ---------------------------------------------------------------------
* TASK 2 (Core)  The weights
*   Open lfs_teach.dta. Summarize wgt_final and display the sum of
*   the weights with a thousands comma.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
quietly summarize wgt_final
assert abs(r(sum) - 101363.92) < 0.1


* ---------------------------------------------------------------------
* TASK 3 (Core)  PSUs per district
*   Create first_psu (1 on the first row of each PSU) and n_psu (the
*   number of PSUs in the person's district). Tabulate n_psu, one row
*   per PSU.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
quietly count if first_psu
assert r(N) == 146
assert n_psu >= 2


* ---------------------------------------------------------------------
* TASK 4 (Core)  Rebuild the final weight
*   Create check_w = base weight times district adjustment, and write
*   one assert that proves it equals wgt_final (allow for rounding).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
assert abs(check_w - wgt_final) < 1e-4


* ---------------------------------------------------------------------
* TASK 5 (Core)  Declare and describe the design
*   Declare the design with svyset and run svydescribe. Then complete
*   the five-line note below from the output.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* DESIGN NOTE (Q1 2026 LFS, teaching file)
*   1. Design:
*   2. PSUs and strata:
*   3. Weights:
*   4. Variance method:
*   5. Declaration:

* CHECK Task 5 (silent = correct)
quietly svyset
assert "`r(su1)'" == "psu"
assert "`r(strata1)'" == "district"


* ---------------------------------------------------------------------
* TASK 6 (Extension)  PSUs per district into Excel
*   One row per district with its number of PSUs, exported to
*   output/design_D3.xlsx.  Hint: table ... if first_psu, then
*   collect export.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
confirm file "output/design_D3.xlsx"


* ---------------------------------------------------------------------
* TASK 7 (Challenge)  Districts interviewed in one month only
*   Count, for each district, the months in which it was interviewed
*   (n_month). How many districts were interviewed in one month only,
*   and how does their mean weight compare with the others?
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 7 (silent = correct)
egen _first_d = tag(district)
quietly count if _first_d & n_month == 1
assert r(N) == 13
drop _first_d

log close
