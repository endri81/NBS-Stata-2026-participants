* =====================================================================
* lab_D4_2.do  —  Lab 2: The analytical note
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 4 (19 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : data/lfs_svy.dta, data/cpi_divisions_long.dta
* Outputs    : logs/lab_D4_2.log, output/D4_margins.png, output/D4_infl.png,
*              output/note_q1.docx, output/model_q1.docx
* Packages   : none
* Location   : C:/NBS_Stata/day4/lab_D4_2.do (from this morning's download)
* ---------------------------------------------------------------------
* THE SITUATION
*   The Minister's office wants two pages by tomorrow: who is more
*   likely to be unemployed, and where inflation stands. Every number
*   in the note must come from this do-file.
*
* HOW THIS LAB WORKS
*   - Each task is written in the comments. Type your code on the
*     empty line(s) under  >>> YOUR CODE.
*   - Close Word, then run the whole file with Ctrl + D after each task.
*   - Each task ends with a CHECK line, already written for you.
*     If the check is silent, your answer is correct.
*   - Do not change the CHECK lines.
*
* A CORRECT LAB: the whole file runs with no red text, ends with
*   "end of do-file", and output/note_q1.docx opens in Word.
* =====================================================================


* ---------------------------------------------------------------------
* TASK 1 (Core)  Settings, data, flags
*   The five top lines (diary logs/lab_D4_2.log), open lfs_svy.dta and
*   build the 0/1 flags lf and unemp.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 1 (silent = correct)
quietly count if lf == 1
assert r(N) == 3126


* ---------------------------------------------------------------------
* TASK 2 (Core)  The design-based model
*   A design-based logit of unemp on sex, age group and region, for the
*   labour force. Store it as m_svy.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 2 (silent = correct)
assert abs(_b[2.ilo_sex] - (-.1113344)) < 1e-5


* ---------------------------------------------------------------------
* TASK 3 (Core)  Predicted rates and the chart
*   Predicted unemployment rate by age group; copy r(table) into M at
*   once. Chart it with marginsplot (title, source note) and export it
*   to output/D4_margins.png.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 3 (silent = correct)
assert abs(M[1, 1] - .1242552) < 1e-5
confirm file "output/D4_margins.png"


* ---------------------------------------------------------------------
* TASK 4 (Core)  Inflation
*   Open cpi_divisions_long.dta, keep all items (division 0), declare
*   the monthly series, compute year-on-year inflation yoy, chart it and
*   export the chart to output/D4_infl.png. M stays in memory.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 4 (silent = correct)
assert abs(yoy[_N] - .928645) < 1e-5
confirm file "output/D4_infl.png"


* ---------------------------------------------------------------------
* TASK 5 (Core)  The note
*   putdocx: a title, one sentence with the youth rate (100 * M[1, 1],
*   one decimal), the margins chart, one sentence with the latest
*   inflation (yoy[_N], two decimals), the inflation chart. Save it as
*   output/note_q1.docx.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 5 (silent = correct)
confirm file "output/note_q1.docx"


* ---------------------------------------------------------------------
* TASK 6 (Extension)  The model table
*   Reopen lfs_svy.dta first: etable takes the labels from the data in
*   memory. Then export the stored model m_svy with etable to
*   output/model_q1.docx.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 6 (silent = correct)
confirm file "output/model_q1.docx"


* ---------------------------------------------------------------------
* TASK 7 (Challenge)  Which prices drive inflation?
*   Reopen cpi_divisions_long.dta as a panel, compute yoy inside each
*   division, keep August 2026 and the twelve divisions, and sort so
*   the highest inflation is in row 1.
* ---------------------------------------------------------------------
* >>> YOUR CODE


* CHECK Task 7 (silent = correct)
assert division[1] == 7

log close
