# ID erzeugen
datenbasis[[1]] <- datenbasis[[1]] %>% mutate(lfdn_W1 = lfdn) %>% select(-lfdn)

# generate ID
for(i in seq_along(datenbasis)) {
  
  # Ab Welle 9 gemeinsame ID W1-W5; splitten, damit ID W5 vorliegt.
  if("lfdn_W1_W5" %in% names(datenbasis[[i]])) {
    datenbasis[[i]] <- datenbasis[[i]] %>% 
      mutate(
        lfdn_W5 = if_else(lfdn_W1_W5 >= 500000, lfdn_W1_W5-500000, NA_real_),
        lfdn_W1 =  if_else(lfdn_W1_W5 < 500000, lfdn_W1_W5-100000, NA_real_)  ,
        Aufstockung = if_else(aufstockung == 2, NA_real_, 1)) %>% 
      select(-aufstockung)
    
  }
  
  if("lfdn_W5" %in% names(datenbasis[[i]])) {
   
    datenbasis[[i]] <- 
      datenbasis[[i]] %>%
      mutate(
        ID = 
          if_else(
            is.na(lfdn_W1), 
            paste0(lfdn_W5 + 500000), 
            paste0(lfdn_W1 + 100000)
            ),
        Stichprobe = if_else(is.na(Aufstockung), 1, 2)
        ) %>%
      set_variable_labels(
        ID = "Unveränderliche Personen-ID",
        Stichprobe = "Quelle der Stichprobe"
      ) %>%
      add_value_labels(Stichprobe = c(`Basis` = 1, Aufstockung = 2))
    
  } else {
    
    datenbasis[[i]] <- 
      datenbasis[[i]] %>%
      mutate(ID = paste0(lfdn_W1 + 100000), Stichprobe = 1) %>%
      set_variable_labels(
        ID = "Unveränderliche Personen-ID",
        Stichprobe = "Quelle der Stichprobe"
      ) %>%
      add_value_labels(Stichprobe = c(`Basis` = 1, Aufstockung = 2))
    
  }
  
}
