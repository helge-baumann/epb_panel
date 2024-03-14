# Paneldatensatz erzeugen
# Derzeit Welle 1-9
# 28.11.2022

# Präambel----
if(!"pacman" %in% installed.packages()[,1]) install.packages("pacman")
library(pacman)
p_load(haven, dplyr, tidyr, stringr, purrr, openxlsx, labelled)

Doku <- list()

map(dir("functions", full.names=T), source)
dir.create("steps", showWarnings=F)
map(dir("steps", full.names=T), source)

# sessionInfo()
dir.create("session_info", showWarnings=F)
writeLines(
  capture.output(sessionInfo()),
  con=paste0("./session_info/", Sys.Date(), "_session_info.txt")
)
