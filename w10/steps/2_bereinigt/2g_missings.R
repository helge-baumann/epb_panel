# Scientific Use Files Erwerbspersonenbefragung

# Fehler mindestens bei w2_branche - alle auf -10

# Was für NAs haben wir?
# dat_long <- dat_long

# Frage in Welle nicht gestellt (-12)
# Nicht an Welle teilgenommen (-11)
# Filterführung (-10)



# Wellenfragen
missings_welle <- 
  dat_long %>% 
  group_by(Welle) %>% 
  summarise(
    teilnahme = sum(teilnahme_welle == 1),
    across(-c(ID, intervtag, teilnahme) & !where(is.character), ~sum(is.na(.)))
  )

for(b in names(dat_long)) {
  if(b %in% names(missings_welle)) {
    for(i in 1:max(dat_long$Welle)) {
      if(missings_welle[i, b] >= nrow(dat_long)/max(dat_long$Welle)) {
        dat_long[, b][is.na(dat_long[, b]) & dat_long$Welle == i] <- -12
      }
    }
    print(b)
  }
}

bu <- dat_long 

#######################################
#attribute verloren??
##########################
# Person in Welle
dat_long <- 
  dat_long %>%  
  mutate(
    across(-c(ID, Welle, intervtag, teilnahme_welle) & !where(is.character), 
           ~case_when(
             teilnahme_welle == 1 | . == -12 ~ ., 
             teilnahme_welle == 0 & is.na(.) ~ -11))
  )



# Rest: Filter
dat_long <-
  dat_long %>% 
  mutate(
    across(-c(ID, Welle, intervtag) & !where(is.character), 
           ~case_when(
             !is.na(.) ~ ., 
             is.na(.) ~ -10))
  )

# Attributes
for(b in names(dat_long)) {
  
  if(length(attributes(dat_long[[b]])$labels) > 0) {
    if(any(dat_long[[b]] == -12)) {
      attributes(dat_long[[b]])$labels <- setNames(
        c(-12,attributes(dat_long[[b]])$labels), 
        c("Frage wurde in Welle nicht gestellt", names(attributes(dat_long[[b]])$labels))
      )
    }
    
    if(any(dat_long[[b]] == -11)) {
      attributes(dat_long[[b]])$labels <- setNames(
        c(-11,attributes(dat_long[[b]])$labels), 
        c("Person hat an Welle nicht teilgenommen", names(attributes(dat_long[[b]])$labels))
      )
    }
    
    if(any(dat_long[[b]] == -10)) {
      attributes(dat_long[[b]])$labels <- setNames(
        c(-10,attributes(dat_long[[b]])$labels), 
        c("Missing durch Filterführung (oder keine Angabe)", names(attributes(dat_long[[b]])$labels))
      )
    }
  }
}
