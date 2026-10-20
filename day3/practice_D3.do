* =====================================================================
* practice_D3.do  —  practice sets, Day 3 (18 Nov 2026)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta
* Outputs    : logs/practice_D3.log, files in output/
* Packages   : none
* ---------------------------------------------------------------------
* HOW THIS FILE WORKS
*   - One block per part of the day. Each block opens its own data,
*     so you can do the parts in any order, at any time.
*   - Type your code under  >>> YOUR CODE, then run the part.
*   - Where a CHECK says  nbscheck P1.1 ____ , replace ____ with your
*     number. Silent CHECK = correct. Red text = look again.
*   - Core first, then Extension, then Challenge. Close Excel for Part 8.
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
    local a P1.1 53122 1 P1.2 5709 1 P1.3 52.4 0.05 P1.4 302.7 0.05 P1.5 5 0 P2.1 146 0 P2.2 9 0 P2.4 10 0 P3.1 26 0 P3.2 5 0 P3.4 2999 0 P3.5 1 0 P4.1 37.06 0.005 P4.2 49035 1 P4.3 1793 1 P4.4 65.6 0.05 P4.5 2.10 0.005 P5.1 66.1 0.05 P5.2 5.3 0.05 P5.3 12.8 0.05 P5.4 11.7 0.05 P5.5 56.5 0.05 P6.1 53.5 0.05 P6.2 5.6 0.05 P6.3 3.9 0.05 P6.4 17.7 0.05 P6.5 12229 1 P7.1 30.5 0.05 P7.2 5.3 0.05 P7.3 178 0 P7.4 .0038 0.00005 P7.5 1.6 0.05 P8.1 9 0 P8.2 .0144 0.00005 P8.5 76.1 0.05
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
log using "logs/practice_D3.log", replace text

* ##################### PART 1  Weights #####################
use "data/lfs_teach.dta", clear
* P1.1 (Core) Weighted count of men and women with [iweight = wgt_final].
*   Type the weighted number of women, rounded.
* >>> YOUR CODE

nbscheck P1.1 ____
* P1.2 (Core) Sum of the weights by region with tabstat.
*   Type the sum for Perseverance, rounded.
* >>> YOUR CODE

nbscheck P1.2 ____
* P1.3 (Core) Weighted share of women in percent, one decimal.
* >>> YOUR CODE

nbscheck P1.3 ____
* P1.4 (Extension) The largest single weight in the file, one decimal.
* >>> YOUR CODE

nbscheck P1.4 ____
* P1.5 (Challenge) How many persons have a weight above 100? List their
*   district, PSU and household.
* >>> YOUR CODE

nbscheck P1.5 ____

* ##################### PART 2  The design #####################
use "data/lfs_teach.dta", clear
* P2.1 (Core) How many PSUs are in the file? Tag the first row of
*   each PSU with egen tag(), then count the tags.
* >>> YOUR CODE

nbscheck P2.1 ____
* P2.2 (Core) The largest number of PSUs in one district.
* >>> YOUR CODE

nbscheck P2.2 ____
* P2.3 (Core) Prove wgt_final = wgt_base * wgt_adj with one assert.
*   Your assert is the check.
* >>> YOUR CODE

* CHECK: your own assert is the check
* P2.4 (Extension) Median number of households per PSU.
* >>> YOUR CODE

nbscheck P2.4 ____
* P2.5 (Challenge) Prove with one line that every household lies in one
*   PSU only.
* >>> YOUR CODE

* CHECK: your own assert is the check

* ##################### PART 3  Declaring the design #####################
use "data/lfs_teach.dta", clear
* P3.1 (Core) Declare the design and run svydescribe. Type the number
*   of strata.
* >>> YOUR CODE

nbscheck P3.1 ____
* P3.2 (Core) The smallest number of observations in a PSU.
* >>> YOUR CODE

nbscheck P3.2 ____
* P3.3 (Core) Save the declared file as output/p3_svy.dta, open it
*   again and show the design with svyset.
* >>> YOUR CODE

capture noisily quietly svyset
capture noisily assert "`r(su1)'" == "psu"
* P3.4 (Extension) svydescribe ilo_job1_how_usual: how many persons have
*   complete data?
* >>> YOUR CODE

nbscheck P3.4 ____
* P3.5 (Challenge) Declare the design without strata and run svydescribe.
*   How many strata does Stata see? Then restore the
*   correct declaration.
* >>> YOUR CODE

nbscheck P3.5 ____

* ##################### PART 4  Estimates (design and four flags ready) #####################
use "data/lfs_teach.dta", clear
svyset psu [pweight = wgt_final], strata(district)
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}
* P4.1 (Core) Design-based mean age, two decimals.
* >>> YOUR CODE

nbscheck P4.1 ____
* P4.2 (Core) Number of employed persons: type the lower bound of the
*   95% interval, rounded.
* >>> YOUR CODE

nbscheck P4.2 ____
* P4.3 (Core) Number of unemployed persons, rounded.
* >>> YOUR CODE

nbscheck P4.3 ____
* P4.4 (Extension) Employment-to-population ratio in percent, one decimal.
* >>> YOUR CODE

nbscheck P4.4 ____
* P4.5 (Challenge) Design effect of the participation rate, two decimals.
* >>> YOUR CODE

nbscheck P4.5 ____

* ##################### PART 5  Subpopulations #####################
use "data/lfs_teach.dta", clear
svyset psu [pweight = wgt_final], strata(district)
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}
* P5.1 (Core) Participation rate of women in percent, one decimal.
* >>> YOUR CODE

nbscheck P5.1 ____
* P5.2 (Core) The highest regional unemployment rate, percent,
*   one decimal.
* >>> YOUR CODE

nbscheck P5.2 ____
* P5.3 (Core) Youth (15-24) unemployment rate, percent, one decimal.
* >>> YOUR CODE

nbscheck P5.3 ____
* P5.4 (Extension) Unemployment rate of young women, percent, one decimal.
* >>> YOUR CODE

nbscheck P5.4 ____
* P5.5 (Challenge) Employment-to-population ratio by region: the lowest,
*   percent, one decimal.
* >>> YOUR CODE

nbscheck P5.5 ____

* ##################### PART 6  Survey tables #####################
use "data/lfs_teach.dta", clear
svyset psu [pweight = wgt_final], strata(district)
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}
* P6.1 (Core) Weighted percentage of women among the 15+, one decimal.
* >>> YOUR CODE

nbscheck P6.1 ____
* P6.2 (Core) Percentage of the population in Perseverance, one
*   decimal.
* >>> YOUR CODE

nbscheck P6.2 ____
* P6.3 (Core) Weighted row percentages of status by region: the
*   unemployed percentage in West.
* >>> YOUR CODE

nbscheck P6.3 ____
* P6.4 (Extension) Column percentages: the share of the unemployed who live
*   in North, one decimal.
* >>> YOUR CODE

nbscheck P6.4 ____
* P6.5 (Challenge) Weighted count of people in Central 2, rounded.
* >>> YOUR CODE

nbscheck P6.5 ____

* ##################### PART 7  Precision #####################
use "data/lfs_teach.dta", clear
svyset psu [pweight = wgt_final], strata(district)
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}
* P7.1 (Core) CV of the unemployment rate in Central 2, one decimal.
* >>> YOUR CODE

nbscheck P7.1 ____
* P7.2 (Core) CV of the participation rate in West, one decimal.
* >>> YOUR CODE

nbscheck P7.2 ____
* P7.3 (Core) Interviews behind the Perseverance unemployment rate
*   (estat size after the regional rates).
* >>> YOUR CODE

nbscheck P7.3 ____
* P7.4 (Extension) SE of the national unemployment rate without strata,
*   four decimals. Restore the design afterwards.
* >>> YOUR CODE

nbscheck P7.4 ____
* P7.5 (Challenge) Time-related underemployment among the employed:
*   build tru = (ilo_joball_tru == 1); rate in percent,
*   one decimal.
* >>> YOUR CODE

nbscheck P7.5 ____

* ##################### PART 8  The estimates table (close Excel first) #####################
use "data/lfs_teach.dta", clear
svyset psu [pweight = wgt_final], strata(district)
quietly {
    generate wap = (ilo_age >= 15)
    generate lf = (ilo_lfs19 == 1 | ilo_lfs19 == 2)
    generate unemp = (ilo_lfs19 == 2)
    generate emp = (ilo_lfs19 == 1)
}
* P8.1 (Core) After the regional unemployment rates, list r(table).
*   How many rows does it have?
* >>> YOUR CODE

nbscheck P8.1 ____
* P8.2 (Core) Copy and transpose it into T. Type the SE of West,
*   four decimals.
* >>> YOUR CODE

nbscheck P8.2 ____
* P8.3 (Core) Write T to output/p8_estimates.xlsx, with names.
* >>> YOUR CODE

capture noisily confirm file "output/p8_estimates.xlsx"
* P8.4 (Extension) Keep rate, SE, lower and upper only, in matrix R.
* >>> YOUR CODE

capture noisily assert colsof(R) == 4
* P8.5 (Challenge) Participation by region in percent (rate, lower, upper)
*   with region names. Type North's upper bound.
* >>> YOUR CODE

nbscheck P8.5 ____

log close
* end of practice_D3.do
