# Alle Wellen einlesen
# Acxhtung: Welle 6 und 7 schon mit Suffixen versehen

path_basis <- paste0(
  "C:/Users/Helge-Emmler/Hans-Böckler-Stiftung/O WSI DZ - EP_BFG - EP_BFG/",
  "Erwerbspersonenbefragung/Datensätze/Welle "
  )

datenbasis <- 
  map(1:9, function(x) {
    
    path_temp <- 
      ifelse(
        any(str_detect(dir(paste0(path_basis, x)), "ktuelle")),
        paste0(path_basis, x, "/Aktuelle Version/"), 
        paste0(path_basis, x, "/")
        )
  datei <- list.files(path_temp)[str_detect(list.files(path_temp), "sav$")]
  dat <- read_sav(paste0(path_temp, datei), user_na=T) # nutzerdefinierte missings
  names(dat) <- str_remove_all(names(dat), "__[:digit:]$")
  return(dat)

})

rm(path_basis)



namen_panel <- 
  read.xlsx("info/2022-11-28_Erwerbspersonenbefragung_Relabel.xlsx", 
            startRow=2, colNames=T) 

namen_panel <- namen_panel[, c(seq(1,19,2), 20)]
names(namen_panel) <- c(paste0("n", 1:9), "newname", "newlabel")


