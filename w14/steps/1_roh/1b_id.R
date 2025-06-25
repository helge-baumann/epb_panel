# ID erzeugen
datenbasis[[1]] <- datenbasis[[1]] %>% mutate(lfdn_W1 = lfdn) %>% select(-lfdn)
datenbasis[[5]] <- datenbasis[[5]] %>%  rename(aufstockung = Aufstockung)
datenbasis[[7]] <- datenbasis[[7]] %>%  rename(aufstockung = Aufstockung)
datenbasis[[8]] <- datenbasis[[8]] %>%  rename(aufstockung = Aufstockung)
datenbasis[[11]] <- datenbasis[[11]] %>%  rename(aufstockung = Aufstockung)
datenbasis[[12]] <- datenbasis[[12]] %>%  rename(aufstockung = Aufstockung,
                                                 lfdn_W1_W5 = LFDN_W1_W5)

# Aufstockung muss angepasst werden
datenbasis[[13]] <- datenbasis[[13]] %>%  
  mutate(aufstockung = if_else(Aufstockung == 1, 2, NA))

datenbasis[[14]] <- datenbasis[[14]] %>%  
  mutate(aufstockung = if_else(Aufstockung == 1, 2, NA))

# Prüfung
datenbasis[[7]] %>%  
  filter(lfdn_W7 == 47) %>%  
  select(1:5, starts_with("Faktor"), aufstockung, starts_with("lfdn"))

# generate ID
for(i in seq_along(datenbasis)) {
  
  # Ab Welle 9 gemeinsame ID W1-W5; splitten, damit ID W5 vorliegt.
  if("lfdn_W1_W5" %in% names(datenbasis[[i]])) {
    datenbasis[[i]] <- datenbasis[[i]] %>% 
      mutate(
        lfdn_W5 = if_else(lfdn_W1_W5 >= 500000, lfdn_W1_W5-500000, NA_real_),
        lfdn_W1 =  if_else(lfdn_W1_W5 < 500000, lfdn_W1_W5-100000, NA_real_)
        )
  }
  
  # jetzt ID bilden
  # Wellen 5 und 7 aufwärts
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
        Stichprobe = case_when(
          aufstockung == 1 ~ 3,
          aufstockung == 2 | is.na(aufstockung) ~ 2
          ),
        Stichprobe = Stichprobe -1
        ) 
        
    
  } 
  
  # Wellen 1-4 und Welle 6
  if("lfdn_W1" %in% names(datenbasis[[i]]) &
     !("lfdn_W5" %in% names(datenbasis[[i]]))) {
    
    datenbasis[[i]] <- 
      datenbasis[[i]] %>%
      mutate(ID = paste0(lfdn_W1 + 100000), Stichprobe = 1) 
    
  }
  
  # ab Welle 13
  if(i >= 13) {
    
    if(i == 13) datenbasis[[i]]$EPB_ID <- datenbasis[[i]]$lfdn_W1_W5_W13
    
    datenbasis[[i]] <- 
      datenbasis[[i]] %>%
      mutate(
        Stichprobe = as.numeric(Aufstockung+1), 
        Stichprobe = if_else(Stichprobe == 4, 3, Stichprobe),
        ID = as.character(EPB_ID)
      ) %>% 
      select(-Aufstockung)
    
  }
  
  datenbasis[[i]] <- 
    datenbasis[[i]] %>%
    set_variable_labels(
      ID = "Unveränderliche Personen-ID",
      Stichprobe = "Quelle der Stichprobe"
    ) %>%
    add_value_labels(
      Stichprobe = c(
        `Basis` = 1, 
        `Aufstockung Welle 5 (Selbstständige)` = 2,
        `Auffrischung Welle 13` = 3
        #,
        # nicht sinnvoll (Auffrischung = Auffrischung):
        #`Auffrischung Welle 13 (Rentner*innen)` = 4 
      )
    )
  
}

# Prüfung
datenbasis[[7]] %>%  
  filter(lfdn_W7 == 47) %>%  
  select(1:5, starts_with("Faktor"), aufstockung, starts_with("lfdn"))

