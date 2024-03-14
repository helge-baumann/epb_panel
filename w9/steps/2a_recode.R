dat <-  
  
  map_dfr(dat, function(x) {
    
    rec_attr(x, namen=c("weiß nicht", "keine angabe"), werte=c(-7, -8), ausnahme_wert=2)
    
  }
    
)
