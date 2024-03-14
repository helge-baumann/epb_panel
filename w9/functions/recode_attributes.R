rec_attr <- function(x, namen, werte, ausnahme_wert) {
  
num <- 1

  for(b in namen) {
    
    wert <- attributes(x)$labels[
      str_detect(tolower(names(attributes(x)$labels)), tolower(b))
      ]
    if(isTRUE(wert != ausnahme_wert)) {
      attributes(x)$na_range <- NULL
    x[x == wert] <- werte[num]
    attributes(x)$labels[attributes(x)$labels == wert] <- werte[num]
    
    }
    num <- num+1
    
  }

  return(x)
  
}

