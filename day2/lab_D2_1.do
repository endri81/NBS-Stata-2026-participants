* =====================================================================
* lab_D2_1.do  —  Lab 1: Assemble Q1 from its parts
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 2 (17 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_jan.dta, lfs_feb.dta, lfs_mar.dta,
*              data/lfs_person.dta, lfs_hh.dta, lfs_coding.dta
* Outputs    : logs/lab_D2_1.log
* Packages   : none
* Location   : C:/NBS_Stata/day2/lab_D2_1.do (from this morning's download)
* ---------------------------------------------------------------------
* THE SITUATION
*   The Q1 2026 LFS reaches the analysis team in pieces: one file per
*   interview month, and separately a person file, a household file
*   and the occupation coding file. Your section head wants proof that
*   both routes give the same quarter, and a region x month table of
*   interviews for the fieldwork report.
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
*   text, ends with "end of do-file", and logs/lab_D2_1.log exists.
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings and the diary
*   Write the five top lines of every course do-file. The diary is
*   logs/lab_D2_1.log.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
assert c(version) == 17


* ---------------------------------------------------------------------
* TASK 2 (Core)  Route A: the quarter from its three months
*   Open lfs_jan.dta, then add lfs_feb.dta and lfs_mar.dta below it in
*   one append line. Keep a variable called source that says which
*   file each row came from.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
assert _N == 5888
assert inlist(source, 0, 1, 2)


* ---------------------------------------------------------------------
* TASK 3 (Core)  Each part holds its own month
*   source is 0 for January, 1 for February, 2 for March, and
*   int_month is 1, 2, 3. Write ONE assert line that is true only if
*   every row came from the file of its own month.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
count if int_month != source + 1
assert r(N) == 0


* ---------------------------------------------------------------------
* TASK 4 (Core)  Route B: persons and their households
*   Open lfs_person.dta. Join lfs_hh.dta by unique_hhd so that the
*   merge stops if any person has no household, and creates no _merge.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
assert _N == 5888
assert !missing(region_q, int_month)


* ---------------------------------------------------------------------
* TASK 5 (Core)  Add the occupation coding, then check the key
*   Join lfs_coding.dta by unique_ind. Only employed persons are coded,
*   so keep _merge this time (no assert, no nogenerate).
*   Then prove there is still one row per person.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct)
assert _N == 5888
assert (_merge == 3) == (ilo_lfs19 == 1)


* ---------------------------------------------------------------------
* TASK 6 (Extension)  The region x month table
*   The next line is written for you: it turns the person file into
*   one row per region and month, with the number of persons in
*   persons. (Part 5 explains this kind of command.)
*   Reshape the result so that each region is one row and the three
*   months are three columns.
* ---------------------------------------------------------------------
contract region_q int_month, freq(persons)
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
assert _N == 7
assert c(k) == 4


* ---------------------------------------------------------------------
* TASK 7 (Challenge)  Does the table add up to the quarter?
*   1. An empty cell here would mean no interviews: make any empty
*      cell 0 in each of the three month columns. How many changes
*      does Stata report? Write it:  * Changes: ____
*   2. Create total = the sum of the three month columns.
*   3. Run summarize on total.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 7 (silent = correct; must come right after summarize)
assert r(sum) == 5888


* ---------------------------------------------------------------------
* Close the diary (keep this as the last line)
log close
