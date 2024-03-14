#################################
# Paneldatensatz erzeugen
# Derzeit Welle 1-10
# Helge Emmler
# 21.08.2023
#################################

# Präambel----
if(!"pacman" %in% installed.packages()[,1]) install.packages("pacman")
library(pacman)
p_load(haven, dplyr, tidyr, stringr, purrr, openxlsx, labelled, tibble, DT,
       sjlabelled)

Doku <- list()

map(dir("functions", full.names=T), source)
dir.create("steps", showWarnings=F)

# für Doku: Steps nur durchlaufen lassen, wenn Daten neu generiert werden sollen. 
map(dir("steps", full.names=T, recursive=T), source)

# Hier Schritte für Doku (Anweisung für .Rnw)

# Doku per Text
writeLines(
  capture.output(Doku),
  con=paste0("./doku/txt/", Sys.Date(), "_doku.txt")
)

# sessionInfo()
dir.create("session_info", showWarnings=F)
writeLines(
  capture.output(sessionInfo()),
  con=paste0("./session_info/", Sys.Date(), "_session_info.txt")
)
