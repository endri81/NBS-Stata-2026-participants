* =====================================================================
* lab_D3_2.do  —  Lab 2: The estimates release
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 3 (18 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta
* Outputs    : logs/lab_D3_2.log, output/release_q1.xlsx
* Packages   : none
* Location   : C:/NBS_Stata/day3/lab_D3_2.do (from this morning's download)
* ---------------------------------------------------------------------
* THE SITUATION
*   The labour statistics section prepares the Q1 2026 release:
*   unemployment and participation rates by sex and by age group, with
*   standard errors and intervals, in one Excel file, plus a notes
*   sheet that documents the design and flags imprecise figures.
*
* HOW THIS LAB WORKS
*   - Each task is written in the comments. Type your code on the
*     empty line(s) under  >>> YOUR CODE.
*   - Close Excel, then run the whole file with Ctrl + D after each task.
*   - Each task ends with a CHECK line, already written for you.
*     If the check is silent, your answer is correct.
*   - Do not change the CHECK lines.
*
* A CORRECT LAB: the whole file runs with no red text, ends with
*   "end of do-file", and output/release_q1.xlsx has the sheets
*   Unemployment, Participation and Notes.
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings, data, design
*   The five top lines (diary logs/lab_D3_2.log), open lfs_teach.dta
*   and declare the design.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
quietly svyset
assert "`r(su1)'" == "psu"


* ---------------------------------------------------------------------
* TASK 2 (Core)  Four flags
*   wap (15 and over), lf (employed or unemployed), unemp, emp:
*   0/1, never missing.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
assert !missing(wap, lf, unemp, emp)
quietly count if lf == 1
assert r(N) == 3126


* ---------------------------------------------------------------------
* TASK 3 (Core)  Unemployment by sex and by age group
*   Estimate the unemployment rate by sex and copy r(table)' into S;
*   then by age group into A. Run estat cv after the age groups.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
assert abs(S[2, 1] - .0317034) < 1e-6
assert abs(A[1, 1] - .1277627) < 1e-6


* ---------------------------------------------------------------------
* TASK 4 (Core)  Participation by sex and by age group
*   Same for the participation rate: matrices PS (sex) and PA (age).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
assert abs(PS[1, 1] - .6980329) < 1e-6
assert abs(PA[1, 1] - .5141823) < 1e-6


* ---------------------------------------------------------------------
* TASK 5 (Core)  The release file
*   Keep rate, SE, lower, upper; multiply by 100; give readable row
*   and column names. Write S and A to the sheet Unemployment, PS and
*   PA to the sheet Participation, in output/release_q1.xlsx.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct)
confirm file "output/release_q1.xlsx"
assert colsof(S) == 4


* ---------------------------------------------------------------------
* TASK 6 (Extension)  Notes and flags
*   A sheet Notes: a title, the svyset line, the source, and one line
*   naming every estimate with a CV above 30% (placeholder until NBS
*   confirms its threshold).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
import excel using "output/release_q1.xlsx", describe
assert r(N_worksheet) == 3


* ---------------------------------------------------------------------
* TASK 7 (Challenge)  Time-related underemployment
*   The share of the employed who are time-related underemployed
*   (ilo_joball_tru), with its CV. Look at how ilo_joball_tru is coded
*   before you use it. Call your 0/1 flag tru.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 7 (silent = correct)
assert abs(_b[tru] - .0159242) < 1e-6

log close
