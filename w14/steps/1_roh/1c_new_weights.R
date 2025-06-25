# check ID (Welle)

#wb <- createWorkbook()

#for(i in 1:8) {
  
 # gew_temp <- 
   # read_sav(dir("../rueckgewichtung/entpackt/", full.names=T)[i]) %>% 
   # select(starts_with("lfdn"), starts_with("FaktorRueckgew"))
 
#if(i == 1) names(gew_temp)[1] <- "lfdn_W1"
  
# check doppelte IDS
#ids <- tibble(
#  daten = sort(datenbasis[[i]][[paste0("lfdn_W", i)]]), 
 # gewichte = sort(gew_temp[[paste0("lfdn_W", i)]])
 # ) %>% 
 # group_by(daten) %>% 
 # mutate(n = n())

#addWorksheet(wb, as.character(i))
#writeData(wb, as.character(i), ids)



#datenbasis[[i]] <- 
 # left_join(datenbasis[[i]], gew_temp)

#}

#saveWorkbook(wb, "output/check_ids_gewichte.xlsx", overwrite=T)

