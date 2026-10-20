* =====================================================================
* practice_D5.do  —  practice sets, Day 5 (20 Nov 2026)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta, lfs_svy.dta, lfs_raw.dta, the Day 5 modules and master.do outputs
* Outputs    : logs/practice_D5.log
* Packages   : none
* ---------------------------------------------------------------------
* HOW THIS FILE WORKS
*   - One block per part of the day. Each block opens its own data,
*     so you can do the parts in any order, at any time.
*   - Type your code under  >>> YOUR CODE, then run the part.
*   - CHECK lines are written for you. Where a CHECK says
*     nbscheck P3.1 ____ , replace ____ with your number.
*   - Silent CHECK = correct. Red text = look again. The file keeps
*     going, so the other answers are still checked.
*   - Core first, then Extension, then Challenge.
* =====================================================================

* ---------------------------------------------------------------------
* SETUP (do not change). nbscheck compares the number you type with
* the answer: silent = correct, red text = look again. It never stops
* the file, so one wrong answer does not hide the others.
* Try each exercise BEFORE you read the answer list below.
* ---------------------------------------------------------------------
version 17
clear all
cd "C:/NBS_Stata"
capture program drop nbscheck
program nbscheck
    version 17
    args id mine
    capture confirm number `mine'
    if _rc {
        display as error "CHECK `id': type your number after nbscheck `id'"
        exit
    }
    local a P1.1 720 0 P1.2 373 0 P1.3 92 0 P1.4 5895 0 P1.5 8 0 P2.1 765 0 P2.2 68.9 0.05 P2.3 620 0 P2.4 65.57 0.005 P2.5 72.9 0.05 P3.1 5888 0 P3.2 361 0 P3.3 104 0 P3.4 12.78 0.005 P3.5 601 0 P4.1 4.53 0.005 P4.3 693 0 P4.4 1.28 0.005 P4.5 0.93 0.005 P5.1 67.8 0.05 P5.5 8.28 0.005 P6.1 3.31 0.005 P6.2 3.17 0.005 P6.3 0.83 0.005 P6.4 1261 0 P7.1 17 0 P7.2 0 0 P7.3 9 0 P7.4 602 0 P7.5 5 0
    local pos : list posof "`id'" in a
    if `pos' == 0 {
        display as error "CHECK `id': unknown exercise"
        exit
    }
    local ans : word `=`pos'+1' of `a'
    local tol : word `=`pos'+2' of `a'
    if abs(`mine' - `ans') > `tol' {
        display as error "CHECK `id': not yet. Look at the output again."
    }
end

capture log close
log using "logs/practice_D5.log", replace text


* #####################################################################
* PART 1  Macros (lfs_teach.dta)
* #####################################################################
* Setup (do not change)
global root "C:/NBS_Stata"
use "$root/data/lfs_teach.dta", clear

* ---------------------------------------------------------------------
* P1.1 (Core)
*   Store 15 in a local lo and 24 in a local hi. Count the
*   persons aged lo to hi with inrange(). Type the number.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.1 (silent = correct)
nbscheck P1.1 ____

* ---------------------------------------------------------------------
* P1.2 (Core)
*   A local wk = 48. Count the employed (ilo_lfs19 == 1) whose
*   usual hours are above wk. Type the number.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.2 (silent = correct)
nbscheck P1.2 ____

* ---------------------------------------------------------------------
* P1.3 (Core)
*   How many variables does the file in memory have?
*   Use c(k).
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.3 (silent = correct)
nbscheck P1.3 ____

* ---------------------------------------------------------------------
* P1.4 (Extension)
*   Open data/lfs_raw.dta with a path built from the global
*   root. Type its number of observations (c(N)).
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.4 (silent = correct)
nbscheck P1.4 ____

* ---------------------------------------------------------------------
* P1.5 (Challenge)
*   local a 2+2 holds text, not a number. What does
*   display `a' * 3 show? Work it out first, then run it.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.5 (silent = correct)
nbscheck P1.5 ____


* #####################################################################
* PART 2  Loops (lfs_svy.dta, four flags)
* #####################################################################
* Setup (do not change)
global root "C:/NBS_Stata"
use "$root/data/lfs_svy.dta", clear
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}

* ---------------------------------------------------------------------
* P2.1 (Core)
*   A forvalues loop over the 7 regions that counts the labour
*   force in each. Type the count for EastSouth (4).
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.1 (silent = correct)
nbscheck P2.1 ____

* ---------------------------------------------------------------------
* P2.2 (Core)
*   Design-based participation rate (lf, subpop wap and the
*   region) in a loop. Type Praslin & La Digue (6), percent,
*   one decimal.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.2 (silent = correct)
nbscheck P2.2 ____

* ---------------------------------------------------------------------
* P2.3 (Core)
*   foreach over the numbers 15 25 35 55: count the employed
*   aged that and over. Type the count for 55.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.3 (silent = correct)
nbscheck P2.3 ____

* ---------------------------------------------------------------------
* P2.4 (Extension)
*   foreach over the variables lf unemp emp: the design-based
*   mean of each in the working-age population (subpop wap).
*   Type the share employed, percent, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.4 (silent = correct)
nbscheck P2.4 ____

* ---------------------------------------------------------------------
* P2.5 (Challenge)
*   Participation by region and sex, a loop inside a loop.
*   Type the rate for women (2) in West (5), percent, one
*   decimal.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.5 (silent = correct)
nbscheck P2.5 ____


* #####################################################################
* PART 3  Modules (the three settings are set)
* #####################################################################
* Setup (do not change)
global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24

* ---------------------------------------------------------------------
* P3.1 (Core)
*   Run module 01 with do. How many persons are in the file
*   it leaves in memory? (c(N))
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.1 (silent = correct)
nbscheck P3.1 ____

* ---------------------------------------------------------------------
* P3.2 (Core)
*   Run module 02. How many young people are in the labour
*   force (lf_youth == 1)?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.2 (silent = correct)
nbscheck P3.2 ____

* ---------------------------------------------------------------------
* P3.3 (Core)
*   Without saving anything: in the file module 02 left in
*   memory, count the labour force aged 15 to 19.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.3 (silent = correct)
nbscheck P3.3 ____

* ---------------------------------------------------------------------
* P3.4 (Extension)
*   Run module 03, then import its National sheet. Type the
*   youth unemployment rate, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.4 (silent = correct)
nbscheck P3.4 ____

* ---------------------------------------------------------------------
* P3.5 (Challenge)
*   Set the quarter to 2025Q4 and run module 03 under capture.
*   Type the return code. Then set the quarter back to 2026Q1.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.5 (silent = correct)
nbscheck P3.5 ____


* #####################################################################
* PART 4  The master do-file (run master.do or Lab 1 first)
* #####################################################################
* Setup (do not change)
global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24

* ---------------------------------------------------------------------
* P4.1 (Core)
*   Import the Regions sheet of output/estimates_2026Q1.xlsx.
*   Type the rate of Central 1, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.1 (silent = correct)
nbscheck P4.1 ____

* ---------------------------------------------------------------------
* P4.2 (Core)
*   Confirm that four products of master.do exist: the two
*   Excel files, the margins chart and the release.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.2 (silent = correct)
capture noisily confirm file "$root/output/estimates_${quarter}.xlsx"
capture noisily confirm file "$root/output/model_${quarter}.xlsx"
capture noisily confirm file "$root/output/margins_${quarter}.png"
capture noisily confirm file "$root/output/release_${quarter}.docx"

* ---------------------------------------------------------------------
* P4.3 (Core)
*   capture mkdir the output folder, which exists. Keep the
*   return code in a local and type it.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.3 (silent = correct)
nbscheck P4.3 ____

* ---------------------------------------------------------------------
* P4.4 (Extension)
*   Import the Margins sheet of output/model_2026Q1.xlsx.
*   Type the predicted rate for 55+, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.4 (silent = correct)
nbscheck P4.4 ____

* ---------------------------------------------------------------------
* P4.5 (Challenge)
*   Import the CPI sheet of the same file. Type the inflation
*   figure, two decimals, and assert the month is August 2026.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.5 (silent = correct)
nbscheck P4.5 ____


* #####################################################################
* PART 5  The release (National sheet in memory; close Word)
* #####################################################################
* Setup (do not change)
global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24
import excel using "$root/output/estimates_${quarter}.xlsx", sheet("National") firstrow clear

* ---------------------------------------------------------------------
* P5.1 (Core)
*   Display the participation rate as text with one decimal
*   (the : display function, format %3.1f). Type it.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.1 (silent = correct)
nbscheck P5.1 ____

* ---------------------------------------------------------------------
* P5.2 (Core)
*   A Word file output/p5_d5.docx: a title with $quarter and
*   one sentence giving the national unemployment rate.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.2 (silent = correct)
capture noisily confirm file "$root/output/p5_d5.docx"

* ---------------------------------------------------------------------
* P5.3 (Core)
*   A Word file output/p5_table.docx with a 4 x 2 table: a
*   header row, then one row per indicator, rate with one
*   decimal.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.3 (silent = correct)
capture noisily confirm file "$root/output/p5_table.docx"

* ---------------------------------------------------------------------
* P5.4 (Extension)
*   A Word file output/p5_chart.docx: the inflation chart
*   (output/infl_2026Q1.png) and one sentence with the month
*   and the rate, read from the CPI sheet.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.4 (silent = correct)
capture noisily confirm file "$root/output/p5_chart.docx"

* ---------------------------------------------------------------------
* P5.5 (Challenge)
*   Without changing any file: the design-based youth
*   unemployment rate for ages 15 to 29 (proportion), percent,
*   two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.5 (silent = correct)
nbscheck P5.5 ____


* #####################################################################
* PART 6  Refactoring (lfs_raw.dta, duplicates dropped)
* #####################################################################
* Setup (do not change)
global root "C:/NBS_Stata"
use "$root/data/lfs_raw.dta", clear
quietly duplicates drop

* ---------------------------------------------------------------------
* P6.1 (Core)
*   Drop persons under 15 and build lf and un as the legacy
*   file does, one line each. Type the weighted unemployment
*   rate (summarize with aweight = weights_dis), percent, two
*   decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.1 (silent = correct)
nbscheck P6.1 ____

* ---------------------------------------------------------------------
* P6.2 (Core)
*   The same rate for women (dem_sex == 2), two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.2 (silent = correct)
nbscheck P6.2 ____

* ---------------------------------------------------------------------
* P6.3 (Core)
*   The same rate for Praslin & La Digue (region_q == 6), two
*   decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.3 (silent = correct)
nbscheck P6.3 ____

* ---------------------------------------------------------------------
* P6.4 (Extension)
*   How many persons did drop if ilo_age < 15 remove? Reopen
*   the raw file, drop the duplicates, and count.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.4 (silent = correct)
nbscheck P6.4 ____

* ---------------------------------------------------------------------
* P6.5 (Challenge)
*   The legacy file builds lf in two lines (gen ... if, then
*   replace). Build it that way and in one line (lf2), and
*   assert that the two agree.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.5 (silent = correct)
* (your own assert above is the check)


* #####################################################################
* PART 7  Discipline (lfs_2026Q1_svy.dta)
* #####################################################################
* Setup (do not change)
global root "C:/NBS_Stata"
use "$root/data/lfs_2026Q1_svy.dta", clear

* ---------------------------------------------------------------------
* P7.1 (Core)
*   Which version does this file run under? Type c(version).
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.1 (silent = correct)
nbscheck P7.1 ____

* ---------------------------------------------------------------------
* P7.2 (Core)
*   datasignature set, reset; then capture datasignature
*   confirm. Keep _rc in a local and type it.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.2 (silent = correct)
nbscheck P7.2 ____

* ---------------------------------------------------------------------
* P7.3 (Core)
*   Change ilo_age in row 1, then capture datasignature
*   confirm again. Type the return code.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.3 (silent = correct)
nbscheck P7.3 ____

* ---------------------------------------------------------------------
* P7.4 (Extension)
*   Open data/lfs_raw.dta and save it without replace, under
*   capture. Type the return code. (Nothing is overwritten.)
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.4 (silent = correct)
nbscheck P7.4 ____

* ---------------------------------------------------------------------
* P7.5 (Challenge)
*   How many do-files are in day5/modules? Put the list in a
*   local with the dir function, then count its words.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.5 (silent = correct)
nbscheck P7.5 ____


log close
* end of practice_D5.do
