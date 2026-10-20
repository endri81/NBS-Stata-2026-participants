* =====================================================================
* practice_D4.do  —  practice sets, Day 4 (19 Nov 2026)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_svy.dta, data/cpi_divisions_long.dta
* Outputs    : logs/practice_D4.log
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
    local a P1.1 32.47 0.005 P1.2 -2.01 0.005 P1.3 0.0373 5e-05 P1.4 -0.0237 5e-05 P1.5 0.0000 5e-05 P2.1 -2.914 0.0005 P2.2 0.0166 5e-05 P2.3 0.670 0.0005 P2.4 1.615 0.0005 P2.5 25 0 P3.1 0.0000 5e-05 P3.2 0.435 0.0005 P3.3 -3.031 0.0005 P3.4 0.020 0.0005 P3.5 24 0 P4.1 -1.128 0.0005 P4.2 0.0225 5e-05 P4.3 0.0336 5e-05 P4.4 0.090 0.0005 P4.5 0.0976 5e-05 P5.2 -2.901 0.0005 P6.1 -0.22 0.005 P6.2 0.52 0.005 P6.3 0.30 0.005 P6.4 42 0 P6.5 1.48 0.005 P7.1 2.49 0.005 P7.2 6 0 P7.3 23.33 0.005 P7.4 4 0
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
log using "logs/practice_D4.log", replace text


* #####################################################################
* PART 1  Tests (lfs_svy.dta, four flags)
* #####################################################################
* Setup (do not change)
use "data/lfs_svy.dta", clear
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}

* ---------------------------------------------------------------------
* P1.1 (Core)
*   ci means of age for the unemployed. Type the upper limit,
*   two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.1 (silent = correct)
nbscheck P1.1 ____

* ---------------------------------------------------------------------
* P1.2 (Core)
*   ttest of usual hours, public against private sector
*   (ilo_job1_ins_sector), employed. Type the gap public minus
*   private, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.2 (silent = correct)
nbscheck P1.2 ____

* ---------------------------------------------------------------------
* P1.3 (Core)
*   Design-based participation by sex (subpop wap), then the
*   gap men minus women with lincom. Type it, four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.3 (silent = correct)
nbscheck P1.3 ____

* ---------------------------------------------------------------------
* P1.4 (Extension)
*   Design-based unemployment rate, Praslin & La Digue (6)
*   minus North (1). Type the gap, four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.4 (silent = correct)
nbscheck P1.4 ____

* ---------------------------------------------------------------------
* P1.5 (Challenge)
*   One test line: are the four age-group unemployment rates
*   all equal? Type the p-value, four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.5 (silent = correct)
nbscheck P1.5 ____


* #####################################################################
* PART 2  Regression (lfs_svy.dta, four flags)
* #####################################################################
* Setup (do not change)
use "data/lfs_svy.dta", clear
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}

* ---------------------------------------------------------------------
* P2.1 (Core)
*   Regress usual hours on sex only (employed). Type the
*   coefficient for women, three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.1 (silent = correct)
nbscheck P2.1 ____

* ---------------------------------------------------------------------
* P2.2 (Core)
*   Add age group. Type R-squared, four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.2 (silent = correct)
nbscheck P2.2 ____

* ---------------------------------------------------------------------
* P2.3 (Core)
*   Sex, age group and region with Central 2 (3) as the base.
*   Type the coefficient for North, three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.3 (silent = correct)
nbscheck P2.3 ____

* ---------------------------------------------------------------------
* P2.4 (Extension)
*   Sex, age group, region, education (base 3) and the
*   institutional sector. Type the coefficient for private,
*   three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.4 (silent = correct)
nbscheck P2.4 ____

* ---------------------------------------------------------------------
* P2.5 (Challenge)
*   After sex, age group, region and education (base 3):
*   how many employed persons have a residual above 40?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.5 (silent = correct)
nbscheck P2.5 ____


* #####################################################################
* PART 3  Diagnostics (lfs_svy.dta, four flags)
* #####################################################################
* Setup (do not change)
use "data/lfs_svy.dta", clear
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}

* ---------------------------------------------------------------------
* P3.1 (Core)
*   Hours on sex and age group (employed), then estat
*   hettest. Type the p-value, four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.1 (silent = correct)
nbscheck P3.1 ____

* ---------------------------------------------------------------------
* P3.2 (Core)
*   Same model with vce(cluster psu). Type the SE for women,
*   three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.2 (silent = correct)
nbscheck P3.2 ____

* ---------------------------------------------------------------------
* P3.3 (Core)
*   Same model with svy, subpop(emp). Type the coefficient
*   for women, three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.3 (silent = correct)
nbscheck P3.3 ____

* ---------------------------------------------------------------------
* P3.4 (Extension)
*   Merge Less than basic (1) into Basic (2) as edu4 with
*   recode, refit sex, age group, region and ib3.edu4, and
*   type the largest leverage, three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.4 (silent = correct)
nbscheck P3.4 ____

* ---------------------------------------------------------------------
* P3.5 (Challenge)
*   How many employed persons report more than 80 usual
*   hours?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.5 (silent = correct)
nbscheck P3.5 ____


* #####################################################################
* PART 4  Logit (lfs_svy.dta, four flags)
* #####################################################################
* Setup (do not change)
use "data/lfs_svy.dta", clear
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}

* ---------------------------------------------------------------------
* P4.1 (Core)
*   Logit of unemp on region only (labour force). Type the
*   coefficient for Praslin & La Digue (6), three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.1 (silent = correct)
nbscheck P4.1 ____

* ---------------------------------------------------------------------
* P4.2 (Core)
*   margins i.region: type the predicted rate for
*   Perseverance (7), four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.2 (silent = correct)
nbscheck P4.2 ____

* ---------------------------------------------------------------------
* P4.3 (Core)
*   Design-based logit on sex, age group and region; margins
*   by sex. Type the predicted rate for women, four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.3 (silent = correct)
nbscheck P4.3 ____

* ---------------------------------------------------------------------
* P4.4 (Extension)
*   Same model with the option or. Type the odds ratio for
*   55+, three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.4 (silent = correct)
nbscheck P4.4 ____

* ---------------------------------------------------------------------
* P4.5 (Challenge)
*   Design-based logit on sex, age (c.ilo_age) and region.
*   Predicted rate at age 20, four decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.5 (silent = correct)
nbscheck P4.5 ____


* #####################################################################
* PART 5  Presenting (lfs_svy.dta, four flags; close Word and Excel)
* #####################################################################
* Setup (do not change)
use "data/lfs_svy.dta", clear
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}

* ---------------------------------------------------------------------
* P5.1 (Core)
*   Store the hours model with sex only as h1 and with age
*   group added as h2 (employed).
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.1 (silent = correct)
capture noisily quietly estimates restore h2
capture noisily assert e(N) == 2999

* ---------------------------------------------------------------------
* P5.2 (Core)
*   etable of h1 and h2. Type the coefficient for women in h2,
*   three decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.2 (silent = correct)
nbscheck P5.2 ____

* ---------------------------------------------------------------------
* P5.3 (Core)
*   Export the table to output/p5_hours.xlsx.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.3 (silent = correct)
capture noisily confirm file "output/p5_hours.xlsx"

* ---------------------------------------------------------------------
* P5.4 (Extension)
*   A Word note output/p5_note.docx with a title and one
*   sentence.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.4 (silent = correct)
capture noisily confirm file "output/p5_note.docx"

* ---------------------------------------------------------------------
* P5.5 (Challenge)
*   Add the design-based marginsplot by age group of Part 4
*   to a note output/p5_note2.docx.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.5 (silent = correct)
capture noisily confirm file "output/p5_note2.docx"


* #####################################################################
* PART 6  The CPI series (all items, tsset, yoy and mom built)
* #####################################################################
* Setup (do not change)
use "data/cpi_divisions_long.dta", clear
quietly {
    keep if division == 0
    tsset month, monthly
    generate yoy = 100 * (cpi / L12.cpi - 1)
    generate mom = 100 * (cpi / L.cpi - 1)
}

* ---------------------------------------------------------------------
* P6.1 (Core)
*   Year-on-year inflation for December 2025, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.1 (silent = correct)
nbscheck P6.1 ____

* ---------------------------------------------------------------------
* P6.2 (Core)
*   Month-on-month inflation for July 2026, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.2 (silent = correct)
nbscheck P6.2 ____

* ---------------------------------------------------------------------
* P6.3 (Core)
*   Average year-on-year inflation over the 12 months of
*   2025, two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.3 (silent = correct)
nbscheck P6.3 ____

* ---------------------------------------------------------------------
* P6.4 (Extension)
*   How many months had negative year-on-year inflation?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.4 (silent = correct)
nbscheck P6.4 ____

* ---------------------------------------------------------------------
* P6.5 (Challenge)
*   Inflation over 24 months to August 2026 (L24.), two
*   decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.5 (silent = correct)
nbscheck P6.5 ____


* #####################################################################
* PART 7  The CPI panel (xtset, yoy built)
* #####################################################################
* Setup (do not change)
use "data/cpi_divisions_long.dta", clear
quietly {
    xtset division month, monthly
    generate yoy = 100 * (cpi / L12.cpi - 1)
}

* ---------------------------------------------------------------------
* P7.1 (Core)
*   Year-on-year inflation of Education (10) in August 2026,
*   two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.1 (silent = correct)
nbscheck P7.1 ____

* ---------------------------------------------------------------------
* P7.2 (Core)
*   Which division had the lowest inflation in August 2026?
*   Type its code.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.2 (silent = correct)
nbscheck P7.2 ____

* ---------------------------------------------------------------------
* P7.3 (Core)
*   Health (6): the highest year-on-year inflation since 2008,
*   two decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.3 (silent = correct)
nbscheck P7.3 ____

* ---------------------------------------------------------------------
* P7.4 (Extension)
*   How many of the twelve divisions had negative inflation
*   in August 2026?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.4 (silent = correct)
nbscheck P7.4 ____

* ---------------------------------------------------------------------
* P7.5 (Challenge)
*   Chart transport (7) and all items (0) together since
*   2020 with xtline, overlay.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.5 (silent = correct)
* (look at the chart or the output: nothing to type)


log close
* end of practice_D4.do
