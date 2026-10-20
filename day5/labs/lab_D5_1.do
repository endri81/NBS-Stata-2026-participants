* =====================================================================
* lab_D5_1.do  —  Lab 1: Assemble the pipeline
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta, data/cpi_divisions_long.dta,
*              the five modules in day5/modules
* Outputs    : logs/lab_D5_1.log and everything the modules write
* Packages   : none
* Location   : C:/NBS_Stata/day5/labs/lab_D5_1.do
* ---------------------------------------------------------------------
* THE SITUATION
*   Next quarter a colleague must produce the LFS mini-release while
*   you are on leave. She should change one block of settings, press
*   Ctrl + D, and get the same files you get today. This lab file is
*   that master do-file.
*
* HOW THIS LAB WORKS
*   - Each task is written in the comments. Type your code on the
*     empty line(s) under  >>> YOUR CODE.
*   - Close Word and Excel. Run the whole file with Ctrl + D after
*     each task.
*   - Each task ends with a CHECK line, already written for you.
*     If the check is silent, your answer is correct.
*   - Do not change the CHECK lines.
*
* A CORRECT LAB: the whole file runs with no red text and ends with
*   "end of do-file".
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  The settings block
*   version 17, clear all, and three globals: root (C:/NBS_Stata),
*   quarter (2026Q1) and youth_max (24).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
assert "$quarter" == "2026Q1"
assert $youth_max == 24
confirm file "$root/data/lfs_raw.dta"


* ---------------------------------------------------------------------
* TASK 2 (Core)  Check the inputs before anything runs
*   A foreach loop over the two input files (data/lfs_raw.dta and
*   data/cpi_divisions_long.dta). For each: capture confirm file; if it
*   fails, display a red message naming the file and exit 601.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
confirm file "$root/data/cpi_divisions_long.dta"


* ---------------------------------------------------------------------
* TASK 3 (Core)  Folders and one log
*   Create the folders output and logs if they are missing (capture
*   mkdir). Close any open log, then open logs/lab_D5_1.log (replace,
*   text).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
confirm file "$root/logs/lab_D5_1.log"


* ---------------------------------------------------------------------
* TASK 4 (Core)  The five modules, timed
*   timer clear and timer on 1; run the five modules in order with do;
*   timer off 1 and timer list 1.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
confirm file "$root/output/release_${quarter}.docx"
confirm file "$root/output/estimates_${quarter}.xlsx"


* ---------------------------------------------------------------------
* TASK 5 (Core)  Read the result back
*   Import the Regions sheet of output/estimates_2026Q1.xlsx (firstrow,
*   clear) and list it. Which region has the highest rate?
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct)
assert _N == 7
assert Region[5] == "West"
assert abs(Rate[5] - 5.3162335) < 1e-5


* ---------------------------------------------------------------------
* TASK 6 (Extension)  One person, one row
*   (a) Open the raw file and run duplicates report unique_ind: how
*       many surplus rows are there?
*   (b) Open data/lfs_2026Q1_teach.dta. Check it with capture isid
*       unique_ind; if that fails, display a red message and exit 459.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
isid unique_ind
assert _N == 5888


* ---------------------------------------------------------------------
* TASK 7 (Challenge)  Which module is the slowest?
*   Put the five module names in a local. In a foreach loop, give each
*   module its own timer (1 to 5): timer on, quietly do, timer off.
*   Then timer list. Close the log at the end.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 7 (silent = correct)
quietly timer list
assert r(t5) > 0
