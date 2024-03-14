# hier reine Kontrolle

Doku$abweichungen <- 
  map(seq_along(datenbasis), function(x) {
  
  praxis <- names(datenbasis[[x]])
  theorie <- na.omit(namen_panel[[x]])
  y <- list()
  y$`Datensatz, aber nicht in Liste` <- praxis[!(praxis %in% theorie)]
  y$`Liste, aber nicht im Datensatz` <- theorie[!(theorie %in% praxis)]
  
  return(y)
  
})

# Auffälligkeiten W9:
  # Personen HH noch komisch codiert (1=0); AZ auch. (auch in Welle 7)
  # "ka"-Variablen liegen noch vor. 
  # krz_anteil heißt krz_anteil_pro und krz_anteil ist jetzt wieder so eine allg. Angabe
  # w9_home_persp heißt w9_home_persp_anz
  # azv_std heißt azv_std_zahl
  # ztr_w_beg und ztr_w_end haben _stunde als Suffix  
  # epauschale_n heißt epauschale_n_personen
  # es gibt eine epauschale_verw_mp_ka
  # Gewichtungsfaktoren fehlen noch.
  # Haushaltsgröße noch überprüfen
  
  
    

