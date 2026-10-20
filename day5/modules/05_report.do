* =====================================================================
* 05_report.do  —  module 5: the Word mini-release (Day 5)
* ---------------------------------------------------------------------
* Course     : NBS Seychelles Stata training, Day 5 (20 Nov 2026)
* Author     : Endri Raco
* Version    : Stata 17 or newer (written with version 17)
* Inputs     : $root/output/estimates_${quarter}.xlsx, $root/output/model_${quarter}.xlsx,
*              $root/output/margins_${quarter}.png, $root/output/infl_${quarter}.png
* Outputs    : $root/output/release_${quarter}.docx
* Packages   : none
* Called by  : master.do. Every number is read from the files above:
*              none is typed.
* =====================================================================
version 17
putdocx clear
putdocx begin
putdocx paragraph, style(Title)
putdocx text ("Labour Force Survey $quarter: key figures")
putdocx paragraph
putdocx text ("National Bureau of Statistics, Seychelles. Produced on `c(current_date)'.")

* The national figures.
import excel using "$root/output/estimates_${quarter}.xlsx", sheet("National") firstrow clear
putdocx paragraph, style(Heading1)
putdocx text ("Unemployment and participation")
putdocx paragraph
putdocx text ("The unemployment rate was `: display %3.1f Rate[1]' per cent ")
putdocx text ("(95% interval `: display %3.1f Lower[1]' to `: display %3.1f Upper[1]'). ")
putdocx text ("Among young people aged 15 to $youth_max it was `: display %3.1f Rate[2]' per cent. ")
putdocx text ("The labour force participation rate was `: display %3.1f Rate[3]' per cent.")

* The regional table: one Word row per Excel row.
import excel using "$root/output/estimates_${quarter}.xlsx", sheet("Regions") firstrow clear
putdocx paragraph, style(Heading1)
putdocx text ("Unemployment rate by region, per cent")
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

* The model and the price series.
import excel using "$root/output/model_${quarter}.xlsx", sheet("Margins") firstrow clear
putdocx paragraph, style(Heading1)
putdocx text ("Who is more likely to be unemployed?")
putdocx paragraph
putdocx text ("Holding sex and region fixed, the predicted unemployment rate is ")
putdocx text ("`: display %3.1f Rate[1]' per cent at ages 15-24 and `: display %3.1f Rate[2]' per cent at 25-34.")
putdocx paragraph
putdocx image "$root/output/margins_${quarter}.png"
import excel using "$root/output/model_${quarter}.xlsx", sheet("CPI") firstrow clear
putdocx paragraph, style(Heading1)
putdocx text ("Prices")
putdocx paragraph
putdocx text ("Year-on-year inflation in `=Month[1]' was `: display %3.2f Inflation[1]' per cent.")
putdocx paragraph
putdocx image "$root/output/infl_${quarter}.png"

putdocx save "$root/output/release_${quarter}.docx", replace
