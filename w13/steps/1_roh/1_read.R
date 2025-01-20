# Alle Wellen einlesen
# Achtung: Welle 6 und 7 schon mit Suffixen versehen

path_basis <- paste0(
  "C:/Users/Helge-Emmler/Hans-Böckler-Stiftung/O WSI DZ - EP_BFG - EP_BFG/",
  "Erwerbspersonenbefragung/Datensätze/Welle "
  )

datenbasis <- 
  map(1:w, function(x) {
    
    path_temp <- 
      ifelse(
        any(str_detect(dir(paste0(path_basis, x)), "ktuelle")),
        paste0(path_basis, x, "/Aktuelle Version/"), 
        paste0(path_basis, x, "/")
        )
    
  datei <- list.files(path_temp)[str_detect(list.files(path_temp), "sav$")]
  dat <- read_sav(paste0(path_temp, datei), user_na=T) # nutzerdefinierte miss.
  names(dat) <- str_remove_all(names(dat), "__[:digit:]$") # 6 und 7
  return(dat)

})

rm(path_basis)

# Abgleich aller Variablennamen
namen_panel <- 
  read.xlsx(
    dir( "../../Abgleich aller Variablen/aktuell/", full.names=T),
    startRow=2, colNames=T
    ) 

namen_panel <- namen_panel[, c(seq(1,w*2+1,2), w*2+2)]
names(namen_panel) <- c(paste0("n", 1:w), "newname", "newlabel")

# return names and labs welle 11+12
# for(i in 13) {
#  names_labs <- map(datenbasis[[i]], function(x) attributes(x)$label)
#  write.csv2(enframe(unlist(names_labs)), paste0("./info/names_labs_w", i, ".csv"), 
#             fileEncoding = "CP1252", row.names=F)
# }



