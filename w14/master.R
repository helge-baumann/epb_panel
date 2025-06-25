#################################
# Paneldatensatz erzeugen
# Hier Welle 1-14; 2-0
# Helge Emmler
# 08.05.2025 (nach Nachwahlerhebung)
#################################

# SUF noch nicht erzeugt. 

# Präambel----
if(!"pacman" %in% installed.packages()[,1]) install.packages("pacman")
library(pacman)
p_load(haven, dplyr, tidyr, stringr, purrr, openxlsx, labelled, tibble, DT,
       sjlabelled)

Doku <- list()
# um welche Welle handelt es sich (Maximum)
w <- 14

# Um welche Version handelt es sich?
v <- "v2-0"

map(dir("functions", full.names=T), source)
dir.create("steps", showWarnings=F)

# für Doku: Steps nur durchlaufen lassen, wenn Daten neu generiert werden sollen. 
files <- dir("steps", full.names=T, recursive=T)
files <- files[str_detect(files, "/1|/2_")][1:16]
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
