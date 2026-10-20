* =====================================================================
* practice_D2.do  —  practice sets, Day 2 (17 Nov 2026)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_feb.dta, lfs_mar.dta, lfs_person.dta, lfs_hh.dta,
*              lfs_coding.dta, district_lookup.dta, lfs_district_month.dta,
*              cpi_divisions_wide.dta, lfs_teach.dta
* Outputs    : logs/practice_D2.log, files in output/
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
    local a P1.1 4024 0 P1.4 0 0 P1.5 156 0 P2.2 3012 0 P2.3 63 0 P2.5 3 0 P3.1 5 0 P3.4 51.0 0.05 P3.5 2832 0 P4.1 2245 0 P4.2 57.9 0.05 P4.3 39 0 P4.4 43.8 0.05 P4.5 .743 0.0005 P5.1 41.3 0.05 P5.2 8 0 P5.4 1 0 P5.5 13 0 P6.2 24 0 P7.2 38.4 0.05 P7.5 .634 0.0005 P8.3 31.2 0.05 P8.5 742 0
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
log using "logs/practice_D2.log", replace text


* #####################################################################
* PART 1  Stacking months
* #####################################################################
* Setup (do not change)
use "data/lfs_feb.dta", clear

* ---------------------------------------------------------------------
* P1.1 (Core)
*   Append March below February. How many persons?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.1 (silent = correct)
nbscheck P1.1 ____

* ---------------------------------------------------------------------
* P1.2 (Core)
*   Start again from February and append March with
*   generate(file). Tabulate file.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.2 (silent = correct)
capture noisily quietly count if file == 1
capture noisily assert r(N) == 1942

* ---------------------------------------------------------------------
* P1.3 (Core)
*   Write one assert: the result has 4,024 rows.
*   Your assert is the check.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.3 (silent = correct)
* (your own assert above is the check)

* ---------------------------------------------------------------------
* P1.4 (Extension)
*   Cross-tabulate file and int_month. How many rows sit
*   in a file that is not their own month? Type it.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.4 (silent = correct)
nbscheck P1.4 ____

* ---------------------------------------------------------------------
* P1.5 (Challenge)
*   Open February again: duplicates report unique_hhd.
*   How many persons live alone in their household?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P1.5 (silent = correct)
nbscheck P1.5 ____


* #####################################################################
* PART 2  Joining files by their key
* #####################################################################
* Setup (do not change)
use "data/lfs_person.dta", clear

* ---------------------------------------------------------------------
* P2.1 (Core)
*   Merge the household file onto the persons, bringing only
*   weight dis_weight weights_dis. Then drop _merge.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.1 (silent = correct)
capture noisily confirm variable weights_dis
capture noisily confirm new variable region_q

* ---------------------------------------------------------------------
* P2.2 (Core)
*   Join the coding file (1:1 on unique_ind) and tabulate
*   _merge. Type the number matched.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.2 (silent = correct)
nbscheck P2.2 ____

* ---------------------------------------------------------------------
* P2.3 (Core)
*   Start again from the persons joined with lfs_hh, join
*   the district lookup (key district_code) and tabulate
*   island by ilo_lfs19. Type the employed on La Digue.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.3 (silent = correct)
nbscheck P2.3 ____

* ---------------------------------------------------------------------
* P2.4 (Extension)
*   Join the coding file again and prove with assert that
*   every matched person is employed.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.4 (silent = correct)
* (your own assert above is the check)

* ---------------------------------------------------------------------
* P2.5 (Challenge)
*   Drop the first household of a copy of lfs_hh.dta, save
*   it as output/hh_minus1.dta, merge it onto the persons.
*   How many persons no longer match?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P2.5 (silent = correct)
nbscheck P2.5 ____


* #####################################################################
* PART 3  Long and wide
* #####################################################################
* Setup (do not change)
use "data/lfs_district_month.dta", clear

* ---------------------------------------------------------------------
* P3.1 (Core)
*   Make the file wide (one row per district). How many
*   districts had no February interview?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.1 (silent = correct)
nbscheck P3.1 ____

* ---------------------------------------------------------------------
* P3.2 (Core)
*   total: the persons of the quarter in each district,
*   with egen rowtotal().
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.2 (silent = correct)
capture noisily assert total == cond(missing(persons1), 0, persons1) + ///
    cond(missing(persons2), 0, persons2) + cond(missing(persons3), 0, persons3)

* ---------------------------------------------------------------------
* P3.3 (Core)
*   Assert that the 26 totals add up to 5,888 (egen total()
*   of total, then assert). Your assert is the check.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.3 (silent = correct)
* (your own assert above is the check)

* ---------------------------------------------------------------------
* P3.4 (Extension)
*   march: the percentage of each district's persons
*   interviewed in March, shown with one decimal.
*   Type the value for English River.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.4 (silent = correct)
nbscheck P3.4 ____

* ---------------------------------------------------------------------
* P3.5 (Challenge)
*   Open cpi_divisions_wide.dta, turn it long (one row per
*   month and division) and count the rows.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P3.5 (silent = correct)
nbscheck P3.5 ____


* #####################################################################
* PART 4  Release tables
* #####################################################################
* Setup (do not change)
use "data/lfs_teach.dta", clear

* ---------------------------------------------------------------------
* P4.1 (Core)
*   Count persons by marital status (dem_mrt), showing the
*   missing. Type the number of Single persons.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.1 (silent = correct)
nbscheck P4.1 ____

* ---------------------------------------------------------------------
* P4.2 (Core)
*   Share of women and men in each age group: row %, one
*   decimal, with table. Type the % of women aged 55+.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.2 (silent = correct)
nbscheck P4.2 ____

* ---------------------------------------------------------------------
* P4.3 (Core)
*   Median usual hours by age group (tabstat).
*   Type the median of the 55+.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.3 (silent = correct)
nbscheck P4.3 ____

* ---------------------------------------------------------------------
* P4.4 (Extension)
*   Mean and count of usual hours by region and age group,
*   mean with one decimal. Type the mean of Perseverance 55+.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.4 (silent = correct)
nbscheck P4.4 ____

* ---------------------------------------------------------------------
* P4.5 (Challenge)
*   Which district has the highest share employed among
*   working-age persons? Type that share, 3 decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P4.5 (silent = correct)
nbscheck P4.5 ____


* #####################################################################
* PART 5  From persons to groups
* #####################################################################
* Setup (do not change)
use "data/lfs_teach.dta", clear

* ---------------------------------------------------------------------
* P5.1 (Core)
*   One row per region: mean usual hours and the number of
*   answers (keep the persons: preserve ... restore).
*   Type the mean of 7- Perseverance, one decimal.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.1 (silent = correct)
nbscheck P5.1 ____

* ---------------------------------------------------------------------
* P5.2 (Core)
*   contract ilo_sex ilo_lfs19 (inside preserve ... restore).
*   How many rows?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.2 (silent = correct)
nbscheck P5.2 ____

* ---------------------------------------------------------------------
* P5.3 (Core)
*   mage: the mean age of the person's region, on every row.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.3 (silent = correct)
capture noisily quietly summarize mage if region == 2
capture noisily assert abs(r(mean) - 38.37344) < 1e-4

* ---------------------------------------------------------------------
* P5.4 (Extension)
*   Rank the regions by share employed, highest = 1.
*   Type the region code ranked 1.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.4 (silent = correct)
nbscheck P5.4 ____

* ---------------------------------------------------------------------
* P5.5 (Challenge)
*   How many districts have more than 200 persons aged 15
*   and over (persons with a value of employed)?
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P5.5 (silent = correct)
nbscheck P5.5 ____


* #####################################################################
* PART 6  Charts
* #####################################################################
* Setup (do not change)
use "data/lfs_teach.dta", clear

* ---------------------------------------------------------------------
* P6.1 (Core)
*   Horizontal bars of the mean age by region, with a title
*   and the source line.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.1 (silent = correct)
capture noisily confirm file "output/p6_age.png"

* ---------------------------------------------------------------------
* P6.2 (Core)
*   Histogram of usual weekly hours as counts, bars 5 hours
*   wide. Type the number of bins Stata reports.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.2 (silent = correct)
nbscheck P6.2 ____

* ---------------------------------------------------------------------
* P6.3 (Core)
*   Export the two charts as output/p6_age.png and
*   output/p6_hours.png (graph export under each chart).
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.3 (silent = correct)
capture noisily confirm file "output/p6_hours.png"

* ---------------------------------------------------------------------
* P6.4 (Extension)
*   Sort the age bars from oldest to youngest region.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.4 (silent = correct)
* (look at the chart or the output: nothing to type)

* ---------------------------------------------------------------------
* P6.5 (Challenge)
*   Scatter of mean usual hours against share employed, one
*   point per district, with district names.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P6.5 (silent = correct)
* (look at the chart or the output: nothing to type)


* #####################################################################
* PART 7  No more copy and paste (close Excel and Word first)
* #####################################################################
* Setup (do not change)
use "data/lfs_teach.dta", clear

* ---------------------------------------------------------------------
* P7.1 (Core)
*   Sex by labour force status as a table, exported to
*   output/p7_sex.xlsx.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.1 (silent = correct)
capture noisily confirm file "output/p7_sex.xlsx"

* ---------------------------------------------------------------------
* P7.2 (Core)
*   The mean usual hours of women into B2 of sheet Women in
*   output/p7_pack.xlsx. Type that mean, one decimal.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.2 (silent = correct)
nbscheck P7.2 ____

* ---------------------------------------------------------------------
* P7.3 (Core)
*   A Word file output/p7_sex.docx with a title line and the
*   same table.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.3 (silent = correct)
capture noisily confirm file "output/p7_sex.docx"

* ---------------------------------------------------------------------
* P7.4 (Extension)
*   Rebuild the Word file with the hours histogram of
*   Part 6 (output/p6_hours.png) under the table.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.4 (silent = correct)
* (look at the chart or the output: nothing to type)

* ---------------------------------------------------------------------
* P7.5 (Challenge)
*   Share employed for men in B3 and for women in B4 of the
*   Women sheet, computed by Stata. Type the women's
*   share, 3 decimals.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P7.5 (silent = correct)
nbscheck P7.5 ____


* #####################################################################
* PART 8  Write it once (run each exercise as one block)
* #####################################################################
* Setup (do not change)
use "data/lfs_teach.dta", clear

* ---------------------------------------------------------------------
* P8.1 (Core)
*   A local src holding "NBS, LFS Q1 2026 (sample)"; show
*   it with display.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P8.1 (silent = correct)
capture noisily assert "`src'" == "NBS, LFS Q1 2026 (sample)"

* ---------------------------------------------------------------------
* P8.2 (Core)
*   One loop: tabulate, missing for ilo_sex, ilo_lfs19 and
*   region.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P8.2 (silent = correct)
* (look at the chart or the output: nothing to type)

* ---------------------------------------------------------------------
* P8.3 (Core)
*   Loop over the regions: the mean age of each with
*   summarize. Type the lowest regional mean age, 1 decimal.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P8.3 (silent = correct)
nbscheck P8.3 ____

* ---------------------------------------------------------------------
* P8.4 (Extension)
*   Loop over the regions: one hours histogram per region,
*   exported as output/p8_region1.png ... p8_region7.png.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P8.4 (silent = correct)
capture noisily confirm file "output/p8_region7.png"

* ---------------------------------------------------------------------
* P8.5 (Challenge)
*   Loop over the regions: write each region's number of
*   employed into column B of output/p8_pack.xlsx, row =
*   region code. Type the number in B4.
* ---------------------------------------------------------------------
* >>> YOUR CODE



* CHECK P8.5 (silent = correct)
nbscheck P8.5 ____


log close
* end of practice_D2.do
