# Bereinigung von Fehlern
# Man könnte noch die Übeerträge von W1 auf W2 löschen
  # (erkennbar an dem Wertelabel "kein Zuspiel aus Welle 1 möglich", Code 88)

Doku$bereinigungen <- NULL

# Arbeitszeiten
for(b in names(dat)) {
  
  Doku$bereinigungen$arbeitszeiten <- NULL
  
  if(length(attributes(dat[[b]])[["labels"]]) > 0) {
    # Arbeitszeiten
  if(max(attributes(dat[[b]])$labels) == 169) {
    attributes(dat[[b]])$labels <- attributes(dat[[b]])$labels[attributes(dat[[b]])$labels < 0] 
    Doku$bereinigungen$arbeitszeiten <- c(Doku$bereinigungen$arbeitszeiten, b)
  }
    
    Doku$bereinigungen$personen_hh <- NULL
    # Personen im Haushalt
    if(any(names(attributes(dat[[b]])$labels) == "0")) {
      dat[[b]][dat[[b]] >= 0 & !is.na(dat[[b]])] <- dat[[b]][dat[[b]] >= 0 & !is.na(dat[[b]])] - 1
      attributes(dat[[b]])$labels <- attributes(dat[[b]])$labels[attributes(dat[[b]])$labels < 0] 
      Doku$bereinigungen$personen_hh <- c(Doku$bereinigungen$personen_hh, b)
    }
    
    Doku$bereinigungen$alter <- "Wertelabel der Variable [alter] entfernt"
    if(str_detect(b, "alter")) {
      attributes(dat[[b]])$labels <- attributes(dat[[b]])$labels[attributes(dat[[b]])$labels < 0] 
    }
    
    if(str_detect(b, "sonntagsfrage")) {
      
      dat[[b]][!is.na(dat[[b]]) & dat[[b]] == 95] <- -4
      dat[[b]][!is.na(dat[[b]]) & dat[[b]] == 96] <- -5
      dat[[b]][!is.na(dat[[b]]) & dat[[b]] == 97] <- -6
      
    }
    
    # Fehler bei Zuordnung trifft zu / trifft nicht zu Welle 10
  
    Doku$bereinigungen$tnz <- NULL
    
    if(str_detect(b, "bbild_mp")) {
      if(str_detect(b, "__9")) {
        dat[[b]][!is.na(dat[[b]]) & dat[[b]] == 2] <- 0
        dat[[b]][!is.na(dat[[b]]) & dat[[b]] >= 0] <- dat[[b]][!is.na(dat[[b]]) & dat[[b]] >= 0] + 1
        Doku$bereinigungen$tnz <- c(Doku$bereinigungen$tnz, b)
      }
      if(any(attributes(dat[[b]])$labels == 0)) {
        
      dat[[b]][!is.na(dat[[b]]) & dat[[b]] == 0] <- 2
      Doku$bereinigungen$tnz <- c(Doku$bereinigungen$tnz, b)
      }
      
  }
  }
}


 
