* =====================================================================
* practice_D1.do  —  practice sets, Day 1 (16 Nov 2026)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_raw.dta, data/district_lookup.csv
* Outputs    : logs/practice_D1.log
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
    local a P3.1 1261 0 P3.2 7 0 P3.3 38.2 0.05 P3.4 372 0 P3.5 23 0 P4.2 40 0
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
log using "logs/practice_D1.log", replace text


* #####################################################################
* PART 3  Look before you count (lfs_raw.dta, as at the end of Part 3)
* #####################################################################
* Setup (do not change)
use "data/lfs_raw.dta", clear

* ---------------------------------------------------------------------
* P3.1 (Core)
*   How many records have ilo_lfs19 missing? Use count if.
*   Type the number after nbscheck P3.1.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.1 (silent = correct)
nbscheck P3.1 ____

* ---------------------------------------------------------------------
* P3.2 (Core)
*   List unique_ind ilo_age dem_mrt for records 101 to 105.
*   Type the age of record 103.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.2 (silent = correct)
nbscheck P3.2 ____

* ---------------------------------------------------------------------
* P3.3 (Core)
*   Mean age of men and of women, with bysort.
*   Type the mean age of women, one decimal.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.3 (silent = correct)
nbscheck P3.3 ____

* ---------------------------------------------------------------------
* P3.4 (Extension)
*   How many employed persons work more than 48 actual
*   hours (wkt_mj_acthrs)? Watch the don't-know code 997:
*   it is not 997 hours.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.4 (silent = correct)
nbscheck P3.4 ____

* ---------------------------------------------------------------------
* P3.5 (Challenge)
*   Import data/district_lookup.csv and count the
*   districts on Mahé (type the é: "Mahe" finds none).
*   (This replaces the data in memory: last exercise.)
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.5 (silent = correct)
nbscheck P3.5 ____


* #####################################################################
* PART 4  Missing and don't-know codes (lfs_raw.dta, as at the end of Part 4)
* #####################################################################
* Setup (do not change)
use "data/lfs_raw.dta", clear
quietly mvdecode dem_mrt dem_edl, mv(97=.a \ 99=.b)
quietly mvdecode mie_socpro, mv(97=.a)

* ---------------------------------------------------------------------
* P4.1 (Core)
*   Read the label of mie_pvaclv with codebook, then turn
*   its don't-know code into .a with mvdecode.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.1 (silent = correct)
capture noisily quietly count if mie_pvaclv == .a
capture noisily assert r(N) == 21

* ---------------------------------------------------------------------
* P4.2 (Core)
*   misstable summarize for mie_*. Which variable has the
*   most .a? Type how many .a it has.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.2 (silent = correct)
nbscheck P4.2 ____

* ---------------------------------------------------------------------
* P4.3 (Core)
*   Write one assert: ilo_age is never above 85.
*   Your assert is the check: silent means it holds.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.3 (silent = correct)
* (your own assert above is the check)

* ---------------------------------------------------------------------
* P4.4 (Extension)
*   Find the don't-know code of usual hours
*   (wkt_mj_ushrs_rep) and turn it into .a.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.4 (silent = correct)
capture noisily quietly count if wkt_mj_ushrs_rep == .a
capture noisily assert r(N) == 20

* ---------------------------------------------------------------------
* P4.5 (Challenge)
*   Write one assert that checks: anyone with a labour
*   force status is at least 15.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.5 (silent = correct)
* (your own assert above is the check)


* #####################################################################
* PART 6  New variables (lfs_raw.dta, as at the end of Part 6)
* #####################################################################
* Setup (do not change)
use "data/lfs_raw.dta", clear
quietly {
    mvdecode dem_mrt dem_edl, mv(97=.a \ 99=.b)
    mvdecode mie_socpro, mv(97=.a)
    rename region_q region
    rename district_q district
    generate employed = (ilo_lfs19 == 1) if !missing(ilo_lfs19)
    mvdecode wkt_mj_acthrs, mv(997=.a)
}

* ---------------------------------------------------------------------
* P6.1 (Core)
*   Create female (1 woman, 0 man) and tabulate it.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.1 (silent = correct)
capture noisily assert female == (ilo_sex == 2)

* ---------------------------------------------------------------------
* P6.2 (Core)
*   Create youth: 1 for ages 15-24, 0 for 25 and over,
*   missing under 15. Tabulate it with the missing.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.2 (silent = correct)
capture noisily quietly count if youth == 1
capture noisily assert r(N) == 721
capture noisily assert missing(youth) if ilo_age < 15

* ---------------------------------------------------------------------
* P6.3 (Core)
*   kids: the number of children under 15 in each
*   household, on every row.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.3 (silent = correct)
capture noisily quietly summarize kids
capture noisily assert r(max) == 5 & r(N) == 5895

* ---------------------------------------------------------------------
* P6.4 (Extension)
*   age10: ilo_age in 10-year groups starting at 15
*   (15-24, 25-34, ... 75+), missing under 15, labelled.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.4 (silent = correct)
capture noisily quietly count if age10 == 7
capture noisily assert r(N) == 230

* ---------------------------------------------------------------------
* P6.5 (Challenge)
*   shemp: the share of household members with a labour
*   force status who are employed, on every row
*   (two egen lines, then one generate).
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.5 (silent = correct)
capture noisily quietly summarize shemp
capture noisily assert abs(r(mean) - .6708577) < 1e-6


log close
* end of practice_D1.do
