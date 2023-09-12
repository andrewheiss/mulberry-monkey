# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)

# General options
options(
  tidyverse.quiet = TRUE,
  dplyr.summarise.inform = FALSE
)

set.seed(642535)  # From random.org

# Set target options:
tar_option_set(
  packages = c("tidyverse"),
  format = "rds"
)

# here::here() returns an absolute path, which then gets stored in tar_meta and
# becomes computer-specific (i.e. /Users/andrew/Research/blah/thing.Rmd).
# There's no way to get a relative path directly out of here::here(), but
# fs::path_rel() works fine with it (see
# https://github.com/r-lib/here/issues/36#issuecomment-530894167)
here_rel <- function(...) {fs::path_rel(here::here(...))}


# Load all the scripts in the R/ folder that contain the functions to be used in
# the pipeline
tar_source()

# Pipeline ---------------------------------------------------------------------
list(
  ## Process and clean data ----
  tar_target(chinafile_clean, load_clean_chinafile()),
  
  ## Render the README ----
  tar_quarto(readme, here_rel("README.qmd"))
)
