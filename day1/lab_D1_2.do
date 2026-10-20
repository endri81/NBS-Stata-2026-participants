* =====================================================================
* lab_D1_2.do  —  Lab 2: Clean the job variables
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 1 (16 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta (your product from Part 9)
* Outputs    : logs/lab_D1_2.log
* Packages   : none
* Save as    : C:/NBS_Stata/day1/lab_D1_2.do
* ---------------------------------------------------------------------
* THE SITUATION
*   The employment section asks for clean job variables before it
*   prepares the hours and social-protection tables of the release:
*   hours without codes, labels a reader understands, and a 0/1
*   indicator for "employer pays social contributions".
*
* HOW THIS LAB WORKS
*   As in Lab 1: write code under >>> YOUR CODE, run the whole file
*   with Ctrl + D after each task, and read the CHECK lines.
*   Silent = correct. Red under a CHECK line = look again at that task.
*
* A CORRECT LAB: the whole file runs with no red text, ends with
*   "end of do-file", and logs/lab_D1_2.log exists.
*   This lab does not save over lfs_teach.dta.
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings, diary, data
*   Settings and diary as in every do-file today, then open
*   data/lfs_teach.dta. Log name: logs/lab_D1_2.log
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
assert c(version) == 17
assert c(N) == 5888
isid unique_ind


* ---------------------------------------------------------------------
* TASK 2 (Core)  Usual hours without codes
*   wkt_mj_ushrs_rep holds usual weekly hours in the main job.
*   Find the code above 168 (codebook), check its label, and turn it
*   into .a with mvdecode, as you did for actual hours.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
assert wkt_mj_ushrs_rep <= 168 | missing(wkt_mj_ushrs_rep)


* ---------------------------------------------------------------------
* TASK 3 (Core)  A label a reader understands
*   Give wkt_mj_ushrs_rep the variable label: Usual hours, main job
*   (exactly this text).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
assert "`: variable label wkt_mj_ushrs_rep'" == "Usual hours, main job"


* ---------------------------------------------------------------------
* TASK 4 (Core)  Paid leave: don't-know codes
*   mie_pvaclv (paid annual leave) and mie_pscklv (paid sick leave).
*   Read both labels with codebook. If 97 means don't know, make it .a
*   in both variables with one mvdecode line.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
assert mie_pvaclv != 97 & mie_pscklv != 97


* ---------------------------------------------------------------------
* TASK 5 (Core)  A 0/1 indicator for social contributions
*   Create socsec: 1 if mie_socpro is YES (1), 0 if NO (2), missing
*   otherwise. Hint: generate ... if ... , as for employed.
*   Then label it: Employer pays social contributions (0/1)
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct)
assert socsec == (mie_socpro == 1) if inlist(mie_socpro, 1, 2)
assert missing(socsec) if !inlist(mie_socpro, 1, 2)


* ---------------------------------------------------------------------
* TASK 6 (Extension)  Part time and full time
*   Group actual hours (wkt_mj_acthrs) into hrsgrp:
*   1 = under 35 hours, 2 = 35 hours or more. Use recode with
*   generate(). Label the two groups "Under 35" and "35 or more".
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
assert inlist(hrsgrp, 1, 2) if !missing(wkt_mj_acthrs)
assert hrsgrp == 1 if wkt_mj_acthrs < 35
assert hrsgrp == 2 if wkt_mj_acthrs >= 35 & !missing(wkt_mj_acthrs)


* ---------------------------------------------------------------------
* TASK 7 (Challenge)  Which region has the highest share?
*   The mean of a 0/1 variable is a share. Use bysort and summarize to
*   find the region with the highest share of employees whose employer
*   pays social contributions (records, unweighted).
*   Write the region here:  * Region: ______  Share: ____
*   No CHECK line: compare your answer with your neighbour's.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* ---------------------------------------------------------------------
* Close the diary (keep this as the last line)
log close
