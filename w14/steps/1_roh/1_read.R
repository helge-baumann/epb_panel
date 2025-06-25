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

datenbasis[[13]]$isco08[datenbasis[[13]]$isco08 < 0 & !is.na(datenbasis[[13]]$isco08) & datenbasis[[13]]$isco08 > -99] <-
  datenbasis[[13]]$isco08[datenbasis[[13]]$isco08 < 0 & !is.na(datenbasis[[13]]$isco08) & datenbasis[[13]]$isco08 > -99] - 100

attributes(datenbasis[[13]]$isco08)$labels[
  attributes(datenbasis[[13]]$isco08)$labels < 0 & attributes(datenbasis[[13]]$isco08)$labels > -99
  ] <- attributes(datenbasis[[13]]$isco08)$labels[
    attributes(datenbasis[[13]]$isco08)$labels < 0 & attributes(datenbasis[[13]]$isco08)$labels > -99
  ] - 100

rm(path_basis)

# Abgleich aller Variablennamen
namen_panel <- 
  read.xlsx(
    dir( "../../Abgleich aller Variablen/aktuell/", full.names=T),
    startRow=2, colNames=T
    ) 

namen_panel <- namen_panel[, c(seq(1,w*2+1,2), w*2+2)]
names(namen_panel) <- c(paste0("n", 1:w), "newname", "newlabel")

# return names and labs welle 14
 # for(i in 14) {
 #  names_labs <- map(datenbasis[[i]], function(x) attributes(x)$label)
 #  write.csv2(enframe(unlist(names_labs)), paste0("./info/names_labs_w", i, ".csv"), 
 #             fileEncoding = "CP1252", row.names=F)
 # }



