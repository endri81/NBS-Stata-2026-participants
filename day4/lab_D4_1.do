* =====================================================================
* lab_D4_1.do  —  Lab 1: Hours worked
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 4 (19 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_svy.dta
* Outputs    : logs/lab_D4_1.log
* Packages   : none
* Location   : C:/NBS_Stata/day4/lab_D4_1.do (from this morning's download)
* ---------------------------------------------------------------------
* THE SITUATION
*   The Minister's office asks whether employed women work fewer usual
*   hours than men of the same age, region and education, and whether
*   the public and the private sector differ.
*
* HOW THIS LAB WORKS
*   - Each task is written in the comments. Type your code on the
*     empty line(s) under  >>> YOUR CODE.
*   - Run the whole file with Ctrl + D after each task.
*   - Each task ends with a CHECK line, already written for you.
*     If the check is silent, your answer is correct.
*   - Do not change the CHECK lines.
*
* A CORRECT LAB: the whole file runs with no red text and ends with
*   "end of do-file".
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings, data, flags
*   The five top lines (diary logs/lab_D4_1.log), open lfs_svy.dta and
*   build the 0/1 flags lf (employed or unemployed) and emp (employed).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
quietly count if emp == 1
assert r(N) == 3012


* ---------------------------------------------------------------------
* TASK 2 (Core)  The design-based gap in usual hours
*   Estimate mean usual hours of the employed by sex with svy, then the
*   gap men minus women with lincom.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
assert abs(r(estimate) - 3.048675) < 1e-5


* ---------------------------------------------------------------------
* TASK 3 (Core)  The plain model, with a sensible base
*   Regress usual hours on sex, age group, region and education for the
*   employed. Use Intermediate (code 3) as the education base.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
assert abs(_b[1.ilo_edu_aggregate] - 8.195958) < 1e-5


* ---------------------------------------------------------------------
* TASK 4 (Core)  Check the model
*   Check the VIFs, then test for unequal spread.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
assert r(p) < .01


* ---------------------------------------------------------------------
* TASK 5 (Core)  The design-based model
*   The same model with svy and the employed as the subpopulation.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct)
assert abs(_b[2.ilo_sex] - (-3.111163)) < 1e-5


* ---------------------------------------------------------------------
* TASK 6 (Extension)  Public and private
*   Add the institutional sector (ilo_job1_ins_sector) to the
*   design-based model. Do private-sector employees work more hours?
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
assert abs(_b[2.ilo_job1_ins_sector] - 1.691148) < 1e-5


* ---------------------------------------------------------------------
* TASK 7 (Challenge)  Is the gap the same in both sectors?
*   Let the effect of sex differ by sector (##). Is the interaction
*   significant?
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 7 (silent = correct)
assert abs(_b[2.ilo_sex#2.ilo_job1_ins_sector] - (-.9428898)) < 1e-5

log close
