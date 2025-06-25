# "dat" stammt zu diesem Zeitpunkt aus dem File 1e_merge.R
dat <-  
  map_dfr(dat, function(x) {
    rec_attr(x, 
             namen=c("weiß nicht", "keine angabe"), 
             werte=c(-7, -8), 
             ausnahme_wert = 2)
  })

Doku$recode_missings <- "Weiß nicht auf -7, keine Angabe auf -8, 
außer wenn Wert 2."
