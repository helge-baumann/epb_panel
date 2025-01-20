# Hier reine Kontrolle

Doku$abweichungen <- 
  map(seq_along(datenbasis), function(x) {
  
  praxis <- names(datenbasis[[x]])
  theorie <- na.omit(namen_panel[[x]])
  y <- list()
  y$`Datensatz, aber nicht in Liste` <- praxis[!(praxis %in% theorie)]
  y$`Liste, aber nicht im Datensatz` <- theorie[!(theorie %in% praxis)]
  
  return(y)
  
})

Doku$abweichungen


  
  
    

