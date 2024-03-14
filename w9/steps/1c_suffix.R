for(i in seq_along(datenbasis)) {
  
  datenbasis[[i]] <- datenbasis[[i]] %>% select(ID, everything())
  names(datenbasis[[i]]) <- 
    c("ID", 
      paste0(names(datenbasis[[i]])[2:ncol(datenbasis[[i]])], "__", i)
      )
  
}

