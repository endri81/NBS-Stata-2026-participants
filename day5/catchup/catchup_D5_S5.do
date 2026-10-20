* =====================================================================
* catchup_D5_S5.do  —  Day 5 catch-up: end of Part 5, The release
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : the outputs of master.do (rebuilt if missing)
* Outputs    : logs/day5.log, output/my_release_2026Q1.docx
* Packages   : none
* USE        : close Word and Excel, open this file, press Ctrl + D. Your Stata is
*              now where the room is at the end of Part 5.
* =====================================================================

version 17
clear all
cd "C:/NBS_Stata"
capture log close
log using "logs/day5.log", replace text

global root "C:/NBS_Stata"
global quarter "2026Q1"
global youth_max 24
* Part 5 reads what master.do wrote: rebuild it if it is missing.
capture confirm file "$root/output/estimates_${quarter}.xlsx"
if _rc {
    log close
    do "day5/catchup/catchup_D5_S4.do"
    log using "logs/day5.log", append text
}
* ---- Part 5: The release
* Task 30: three ways to show one rate
import excel using "$root/output/estimates_${quarter}.xlsx", sheet("National") firstrow clear
display "`=Rate[1]'"
display "[`: display %3.1f Rate[1]']"
display "[`: display %4.1f Rate[1]']"
* Task 31: title and date
putdocx clear
putdocx begin
putdocx paragraph, style(Title)
putdocx text ("Labour Force Survey $quarter: key figures")
putdocx paragraph
putdocx text ("Produced on `c(current_date)'.")
* Task 32: the sentence
putdocx paragraph
putdocx text ("The unemployment rate was `: display %3.1f Rate[1]' per cent ")
putdocx text ("(95% interval `: display %3.1f Lower[1]' to `: display %3.1f Upper[1]').")
* Task 33: the regional table, one row per region
import excel using "$root/output/estimates_${quarter}.xlsx", sheet("Regions") firstrow clear
putdocx table reg = (8, 4)
putdocx table reg(1, 1) = ("Region")
putdocx table reg(1, 2) = ("Rate")
putdocx table reg(1, 3) = ("Lower")
putdocx table reg(1, 4) = ("Upper")
forvalues i = 1/7 {
    local row = `i' + 1
    putdocx table reg(`row', 1) = (Region[`i'])
    putdocx table reg(`row', 2) = (Rate[`i']), nformat(%3.1f)
    putdocx table reg(`row', 3) = (Lower[`i']), nformat(%3.1f)
    putdocx table reg(`row', 4) = (Upper[`i']), nformat(%3.1f)
}
* Task 34: the chart, then save
putdocx paragraph
putdocx image "$root/output/margins_${quarter}.png"
putdocx save "$root/output/my_release_${quarter}.docx", replace
* Tasks 35-37 run master.do, change youth_max to 29, run, change it back.

log close
