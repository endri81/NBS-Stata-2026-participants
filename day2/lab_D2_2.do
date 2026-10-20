* =====================================================================
* lab_D2_2.do  —  Lab 2: The tables pack
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 2 (17 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_teach.dta
* Outputs    : output/tables_pack.xlsx, output/tables_pack.docx,
*              output/lab2_fig1.png, output/lab2_fig2.png,
*              output/lab2_region1.png ... lab2_region7.png,
*              logs/lab_D2_2.log
* Packages   : none
* Location   : C:/NBS_Stata/day2/lab_D2_2.do (from this morning's download)
* ---------------------------------------------------------------------
* THE SITUATION
*   The labour statistics section wants a first sample pack for the
*   Q1 2026 LFS: three tables in one Excel file (one sheet each), two
*   charts, and a Word note with a table and a chart. Every number
*   must come from this do-file, so the pack can be rebuilt in one run.
*
* HOW THIS LAB WORKS
*   - Each task is written in the comments. Type your code on the
*     empty line(s) under  >>> YOUR CODE.
*   - Run the whole file with Ctrl + D after each task.
*   - Each task ends with a CHECK line, already written for you.
*     If the check is silent, your answer is correct.
*     If you see red text under a CHECK line, fix that task.
*   - Do not change the CHECK lines.
*   - Close Excel and Word before every run: Stata cannot write to an
*     open file.
*
* A CORRECT LAB: the whole file runs from top to bottom with no red
*   text, ends with "end of do-file", and the files above exist.
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings, the diary and the data
*   Write the five top lines of every course do-file (the diary is
*   logs/lab_D2_2.log), then open data/lfs_teach.dta.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
assert c(N) == 5888


* ---------------------------------------------------------------------
* TASK 2 (Core)  Table 1: persons by region and labour force status
*   Make the table with table, then export it to
*   output/tables_pack.xlsx, sheet T1. Use the options
*   sheet("T1") replace  so each run starts a fresh file.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
import excel using "output/tables_pack.xlsx", describe
assert r(N_worksheet) == 1


* ---------------------------------------------------------------------
* TASK 3 (Core)  Table 2: status within each region, one decimal
*   Same table with row percentages and nformat(%5.1f).
*   Export it to the same file, sheet T2. This time use
*   sheet("T2") modify  so sheet T1 is kept.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
import excel using "output/tables_pack.xlsx", describe
assert r(N_worksheet) == 2


* ---------------------------------------------------------------------
* TASK 4 (Core)  Table 3: usual hours by region and sex
*   Rows region, columns ilo_sex; in each cell the mean and the
*   count of ilo_job1_how_usual. Export to sheet T3 (modify).
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
import excel using "output/tables_pack.xlsx", describe
assert r(N_worksheet) == 3


* ---------------------------------------------------------------------
* TASK 5 (Core)  Two charts
*   Chart 1: horizontal bars of the share employed (the mean of
*   employed) by region, with a title, ytitle("Share employed") and
*   the source note. Export as output/lab2_fig1.png.
*   Chart 2: a histogram of ilo_age for working-age persons only
*   (if !missing(employed)), with the source note.
*   Export as output/lab2_fig2.png.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct)
confirm file "output/lab2_fig1.png"
confirm file "output/lab2_fig2.png"


* ---------------------------------------------------------------------
* TASK 6 (Core)  The Word note
*   Build output/tables_pack.docx with putdocx: a title paragraph,
*   one sentence saying the figures are unweighted sample counts,
*   Table 1 (run the table command again just before putdocx collect),
*   and Chart 1.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
confirm file "output/tables_pack.docx"


* ---------------------------------------------------------------------
* TASK 7 (Extension)  One chart per region
*   Loop over the regions (levelsof, then foreach). For each region,
*   draw the share employed by district, with ytitle("Share employed"),
*   and export it as output/lab2_region`r'.png.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 7 (silent = correct)
foreach r in 1 2 3 4 5 6 7 {
    confirm file "output/lab2_region`r'.png"
}


* ---------------------------------------------------------------------
* TASK 8 (Challenge)  One sheet per region
*   Loop over the regions again. For each region, make a table of
*   ilo_sex by ilo_lfs19 for that region only, and export it to
*   output/tables_pack.xlsx in its own sheet: Region1 ... Region7.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 8 (silent = correct)
import excel using "output/tables_pack.xlsx", describe
assert r(N_worksheet) == 10


* ---------------------------------------------------------------------
* Close the diary (keep this as the last line)
log close
