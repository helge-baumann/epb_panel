# Alle Wellen einlesen
# Achtung: Welle 6 und 7 schon mit Suffixen versehen

path_basis <- paste0(
  "C:/Users/Helge-Emmler/Hans-Böckler-Stiftung/O WSI DZ - EP_BFG - EP_BFG/",
  "Erwerbspersonenbefragung/Datensätze/Welle "
  )

datenbasis <- 
  map(1:10, function(x) {
    
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
  read.xlsx("info/2023-08-03_Erwerbspersonenbefragung_Abgleich-Variablen.xlsx", 
            startRow=2, colNames=T) 

namen_panel <- namen_panel[, c(seq(1,21,2), 22)]
names(namen_panel) <- c(paste0("n", 1:10), "newname", "newlabel")

# return names and labs welle 10
# names_labs <- map(datenbasis[[10]], function(x) attributes(x)$label)
# write.csv2(enframe(unlist(names_labs)), "./info/names_labs_w10.csv")


