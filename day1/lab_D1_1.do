* =====================================================================
* lab_D1_1.do  —  Lab 1: First look at the Q1 2026 file
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 1 (16 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta
* Outputs    : logs/lab_D1_1.log
* Packages   : none
* Save as    : C:/NBS_Stata/day1/lab_D1_1.do
* ---------------------------------------------------------------------
* THE SITUATION
*   Your section head asks three quick questions about the Q1 2026
*   LFS file before the team starts work on it:
*     how many records, how many variables, how many men and women?
*   Answer them from a do-file that leaves a log, so the answers can
*   be checked by anyone.
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
*   text, ends with "end of do-file", and logs/lab_D1_1.log exists.
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings and the diary
*   Type these four lines exactly:
*     version 17
*     clear all
*     cd "C:/NBS_Stata"
*     log using "logs/lab_D1_1.log", replace text
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
assert c(version) == 17


* ---------------------------------------------------------------------
* TASK 2 (Core)  Open the survey file
*   Open lfs_raw.dta from the data folder. Use the short path and the
*   clear option, as in your my_day1.do.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
assert c(N) == 5895


* ---------------------------------------------------------------------
* TASK 3 (Core)  How many records?
*   Count the records in the file.
*   Write the number in the comment:  * Records: ______
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct; must come right after your command)
assert r(N) == 5895


* ---------------------------------------------------------------------
* TASK 4 (Core)  How many men and women?
*   Make a table of ilo_sex.
*   Write the two counts in the comment:  * Men: ____  Women: ____
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct; must come right after your command)
assert r(N) == 5895 & r(r) == 2


* ---------------------------------------------------------------------
* TASK 5 (Extension)  Where do they live?
*   Make a table of the region variable. Find its name in the
*   Variables window.
*   Which region has the most records?  * Region: ______
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct; must come right after your command)
assert r(r) == 7


* ---------------------------------------------------------------------
* TASK 6 (Challenge)  A file that survives a broken run
*   When a run stops halfway, its diary stays open and the next run
*   stops at the log using line.
*   1. Put a * in front of the last line (log close) and run twice:
*      see the red text on the second run.
*   2. Add one line near the top so this never blocks a run again.
*   3. Run twice more: both runs must be clean.
*   4. Remove the * from the last line.
*   No CHECK line: two clean runs in a row are the check.
* ---------------------------------------------------------------------


* ---------------------------------------------------------------------
* Close the diary (keep this as the last line)
log close
