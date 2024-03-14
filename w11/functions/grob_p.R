# min = Minimale Zellenbesetzung, low = geringster Wert, der gruppiert werden soll
# step = Mindestgruppenbreite, r = Rundungsziffern

grob_p <- function(x, min = 3, low = 0, step = 0.1, r = 0) {
  
  null <- sum(x == low) >= min
  
  if (null) {
    attributes(x)$labels <-
      setNames(
        c(attributes(x)$labels, low),
        c(names(attributes(x)$labels), paste0("Genau ", low, " %"))
      )
  }
  
    start <- low
    end <- low
    # Nummerierung der Labels (könnte auch mit Klassenmittelwerten sein; Problem:)
    num <- 0

    while (end < max(x, na.rm = T) & end < 100 & !near(end, max(x, na.rm = T))) {
      if((end+step) > max(x, na.rm=T)) {
        end <- as.numeric(max(x, na.rm=T))
        } else {
          end <- round(as.numeric(sort(x[x >= (end + step)])[1]), digits=r)
        }
     
      if (end >= 100) end <- 100
      
      if (null) {
      if ((sum(x > start & (x <= end | near(x, end))) >= min) | end >= max(x, na.rm = T)) {
        num <- num+1
        x[x > start & x <= end] <- num
        attributes(x)$labels <-
          setNames(
            c(attributes(x)$labels, num),
            c(names(attributes(x)$labels), paste0("Mehr als ", round(start, digits = r), " bis ", round(end, digits = r), " %"))
          )
        start <- end
      }
      } 
      if(!null & start == low) {
        if ((sum(x >= start & x <= end) >= min) | end >= max(x, na.rm = T)) {
          x[x > start & x <= end] <- num
          attributes(x)$labels <-
            setNames(
              c(attributes(x)$labels, 0),
              c(names(attributes(x)$labels), paste0(round(start, digits = r), " bis ", round(end, digits = r), " %"))
            )
          start <- end
        }
      }
      if (!null & start >  low) {
        if ((sum(x > start & (x <= end | near(x, end))) >= min) | end >= max(x, na.rm = T)) {
          num <- num+1
          x[x > start & x <= end] <- num
          attributes(x)$labels <-
            setNames(
              c(attributes(x)$labels, num),
              c(names(attributes(x)$labels), paste0("Mehr als ", round(start, digits = r), " bis ", round(end, digits = r), " %"))
            )
          start <- end
        }
      } 
        
      }

      print(end)
    
    # cut bei 100%
      if(!near(as.numeric(max(x, na.rm=T)), 100)) {
    while (end < max(x, na.rm = T) & end >= 100) {
      
      end <- as.numeric(sort(x[x > (end + step)])[1])

      if ((sum(x > start & x <= end) >= min) | end >= max(x, na.rm = T)) {
        num <- num+1
        x[x > start & x <= end] <- num
        attributes(x)$labels <-
          setNames(
            c(attributes(x)$labels, num),
            c(names(attributes(x)$labels), paste0("Mehr als ", round(start, digits = r), " bis ", round(end, digits = r), " %"))
          )
        start <- end
      }
      

      print(end)
    }
    }

    while (sum(x == max(x, na.rm = T)) <= min) {
      x[x == max(x)] <- max(x[x< max(x, na.rm=T)], na.rm = T) 
      attributes(x)$labels <- attributes(x)$labels[-length(attributes(x)$labels)]
    }

    if (!str_detect(names(attributes(x)$labels[length(attributes(x)$labels)]), "bis 100")) {
      attributes(x)$labels <-
        setNames(
          attributes(x)$labels,
          c(
            names(attributes(x)$labels[-length(attributes(x)$labels)]),
            str_remove(names(attributes(x)$labels[length(attributes(x)$labels)]), " bis [:digit:]*")
          )
        )
    }
  

  return(x)
}
