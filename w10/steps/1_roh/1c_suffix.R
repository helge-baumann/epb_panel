for(i in seq_along(datenbasis)) {
  
  # Reihenfolge; ID an den Anfang
  datenbasis[[i]] <- datenbasis[[i]] %>% select(ID, everything())
  
  # Suffix (Welle) für alles außer ID
  names(datenbasis[[i]]) <- 
    c("ID", paste0(names(datenbasis[[i]])[2:ncol(datenbasis[[i]])], "__", i))
  
}

