library(glue)
library(rvest)

load_clean_chinafile <- function() {
  chinafile <- read_html(glue("https://web.archive.org/web/20230911200451/",
    "https://jessicachinafile.github.io/index_TA_table.html")) |> 
    html_element(css = "#filter") |>
    html_table() |>
    select(starts_with("Organization")) |>
    rename(
      org_name_en = `Organization Name (English)`,
      org_name_zh = `Organization Name (Chinese)`,
      org_country = `Organization Origin`
    ) |>
    group_by(org_name_en, org_country) %>% 
    slice(1)
  
  return(chinafile)
}
