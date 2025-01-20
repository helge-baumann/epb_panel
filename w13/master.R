#################################
# Paneldatensatz erzeugen
# Hier Welle 1-13
# Helge Emmler
# 19.12.2024
#################################

# Achtung: 
# Zweitstimme und Sonntagsfrage inkonsistent! (Würde ungültig/nicht wählen) - fertig?
# Variable "stichprobe" inkonsistent (sollte vollständig sein)
# # ostwest' fehlt (zwei-drei Ausführungen)

# Stand 13.01.2025: 2e_long abgeschlossen. 



# Präambel----
if(!"pacman" %in% installed.packages()[,1]) install.packages("pacman")
library(pacman)
p_load(haven, dplyr, tidyr, stringr, purrr, openxlsx, labelled, tibble, DT,
       sjlabelled)

Doku <- list()
# um welche Welle handelt es sich (Maximum)
w <- 13

# Um welche Version handelt es sich?
v <- "v1-0"

map(dir("functions", full.names=T), source)
dir.create("steps", showWarnings=F)

# für Doku: Steps nur durchlaufen lassen, wenn Daten neu generiert werden sollen. 
files <- dir("steps", full.names=T, recursive=T)
files <- files[str_detect(files, "/1|/2_")]
map(files, source)

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
