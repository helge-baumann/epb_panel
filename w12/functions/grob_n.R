# min = Minimale Zellenbesetzung, low = geringster Wert, der gruppiert werden soll
# step = Mindestgruppenbreite, r = Rundungsziffern

grob_n <- function(x, min = 3, low = 0, step = 1, r = 0) {
  
  end <- low
  start <- low
  if(sum(x == low) >= min) {
    
    num <- num+1
    attributes(x)$labels <-
      setNames(
        c(attributes(x)$labels, low),
        c(names(attributes(x)$labels), low)
      )
    end <- low+1
    start <- end
  }
  
  # Nummerierung der Labels (könnte auch mit Klassenmittelwerten sein)
  num <- 0
  
  while (end < max(x, na.rm = T)) {
    
    
    end <- as.numeric(sort(x[x >= (end + step)])[1])
    
    if(sum(x == start) >= min & start < max(x, na.rm=T)) {
      
      num <- num+1
      attributes(x)$labels <-
        setNames(
          c(attributes(x)$labels, num), 
          c(names(attributes(x)$labels), start)
        )
      start <- end
     
      
    } else {
      if ((sum(x >= start & x <= end) >= min) | end >= max(x, na.rm = T)) {
        num <- num+1
        x[x >= start & x <= end] <- num
        attributes(x)$labels <-
          setNames(
            c(attributes(x)$labels, num),
            c(names(attributes(x)$labels), paste0(start, " bis ", end)
          ))
        start <- end
      }
    } 
   
  }
  
  print(end)
  
  
  while (sum(x == max(x, na.rm = T)) <= min) {
    x[x == max(x)] <- max(x[x< max(x, na.rm=T)], na.rm = T) 
    attributes(x)$labels <- attributes(x)$labels[-length(attributes(x)$labels)]
  }
  
  if (str_detect(names(attributes(x)$labels[length(attributes(x)$labels)]), "bis")) {
    attributes(x)$labels <-
      setNames(
        attributes(x)$labels,
        c(
          names(attributes(x)$labels[-length(attributes(x)$labels)]),
          paste0(str_remove(names(attributes(x)$labels[length(attributes(x)$labels)]), " bis [:digit:]*"), " und mehr")
        )
      )
  }
  
  
  return(x)
}
