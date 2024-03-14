# 3d_suf_unique

anonym <-  
  map_lgl(
    SUF, function(x) {
      return(any(table(x[x >= 0], SUF$Welle[x >= 0])  %in% 1:2))
    }
  )
length(anonym[anonym == T])

dean <- anonym[anonym == T]
dean_kat <-  dean[map_lgl(names(dean), function(x) all(na.omit(SUF[[x]]) %in% 
                                                         attributes(SUF[[x]])$labels))]
dean_num <-  dean[!(names(dean) %in% names(dean_kat))]

Doku$anonym <- list()
#Doku$anonym$stay <- dean_num
Doku$anonym$grob <- names(dean_kat)

for(b in names(dean_kat)) {
  
  SUF[[paste0(b, "_kat")]] <- SUF[[b]]
  
  werte <- table(SUF$Welle, SUF[[paste0(b, "_kat")]])
  werte_3 <- as.numeric(colnames(werte)[unique(which(werte < 3 & werte > 0 , arr.ind=T)[,2])])
  werte_3 <- werte_3[werte_3 >= 0]
  werte <- as.numeric(colnames(werte))
  
  for(i in werte_3) {
    next_right <- werte[werte > i][1]
    if(next_right %in% attributes(SUF[[paste0(b, "_kat")]])$labels) {
      SUF[[paste0(b, "_kat")]][SUF[[paste0(b, "_kat")]] == i] <- next_right 
      names(attributes(SUF[[paste0(b, "_kat")]])$labels)[
        attributes(SUF[[paste0(b, "_kat")]])$labels == next_right
      ] <- 
        paste0(
          "[", 
          names(attributes(SUF[[paste0(b, "_kat")]])$labels)[
            attributes(SUF[[paste0(b, "_kat")]])$labels == i
          ], 
          " oder ",
          names(attributes(SUF[[paste0(b, "_kat")]])$labels)[
            attributes(SUF[[paste0(b, "_kat")]])$labels == next_right
          ], 
          "]"
        )
    } else {
      next_left <- werte[werte < i][length(werte[werte < i])]
      if(next_left %in% attributes(SUF[[paste0(b, "_kat")]])$labels & next_left >= 0) {
        SUF[[paste0(b, "_kat")]][SUF[[paste0(b, "_kat")]] == i] <- next_left
        names(attributes(SUF[[paste0(b, "_kat")]])$labels)[
          attributes(SUF[[paste0(b, "_kat")]])$labels == next_left
        ] <- 
          paste0(
            "[", 
            names(attributes(SUF[[paste0(b, "_kat")]])$labels)[
              attributes(SUF[[paste0(b, "_kat")]])$labels == next_left
            ], 
            " oder ",
            names(attributes(SUF[[paste0(b, "_kat")]])$labels)[
              attributes(SUF[[paste0(b, "_kat")]])$labels == i
            ], 
            "]"
          )
      }}
    SUF[[paste0(b, "_kat")]] <- remove_labels(SUF[[paste0(b, "_kat")]], 
                                                   labels=names(attributes(SUF[[paste0(b, "_kat")]])$labels)[
                                                     attributes(SUF[[paste0(b, "_kat")]])$labels == i
                                                   ]
    )
  }
  
  SUF[[b]] <- NULL
  print(b)
  
}

# Vergröberungen numerischer Variablen
Doku$anonym$vergroebert_anzahl <- names(dean_num)[str_detect(names(dean_num), "phh|_n$|hhgr|oecd")]
Doku$anonym$stay <- names(dean_num)[!str_detect(names(dean_num), "phh|_n$|hhgr|oecd")]

for(b in Doku$anonym$vergroebert_anzahl) {
  
  SUF[[paste0(b, "_kat")]] <- SUF[[b]]
  
  wellen <- table(SUF[[paste0(b, "_kat")]], SUF$Welle)
  wellen <- colSums(wellen[row.names(wellen) >= 0, ])
  wellen <-  sum(wellen > 0)
  
  cuts <- table(SUF[[paste0(b, "_kat")]][SUF[[paste0(b, "_kat")]] >= 0])
  cuts <- cuts[cuts > wellen*3]
  
  werte <- as.numeric(names(cuts))
  if(!(min(SUF[[paste0(b, "_kat")]][SUF[[paste0(b, "_kat")]] >= 0]) %in% werte))
  werte[1] <- min(SUF[[paste0(b, "_kat")]][SUF[[paste0(b, "_kat")]] >= 0])
  
  # zähler
  num <- 0
  # einzusetzende Werte (!= i)
  num2 <- 0
  
  for(i in werte) {
    
    num <- num+1
    if(i != 0) num2 <- num2+1
    
    if(
      sum(SUF[[b]] == i, na.rm=T) > wellen*3 & 
      sum(SUF[[b]] > i & SUF[[b]] < werte[num+1], na.rm=T) == 0 &
      i != max(werte)
      ) {
      # ggf. 1 als 0 etc.; vermeidbar?
      SUF[[paste0(b, "_kat")]][SUF[[b]] >= i & SUF[[b]] < werte[num+1]] <- num2
      attributes(SUF[[paste0(b, "_kat")]])$labels <-
        setNames(
          c(attributes(SUF[[paste0(b, "_kat")]])$labels, num2),
          c(names(attributes(SUF[[paste0(b, "_kat")]])$labels), as.character(i)
          ))
    } else {
    if(i < max(werte)) {
    SUF[[paste0(b, "_kat")]][SUF[[b]] >= i & SUF[[b]] < werte[num+1]] <- num2
    attributes(SUF[[paste0(b, "_kat")]])$labels <-
      setNames(
        c(attributes(SUF[[paste0(b, "_kat")]])$labels, num2),
        c(names(attributes(SUF[[paste0(b, "_kat")]])$labels), paste0(i, " bis unter ", werte[num+1])
        ))
    } else {
      SUF[[paste0(b, "_kat")]][SUF[[b]] >= i] <- num2
      attributes(SUF[[paste0(b, "_kat")]])$labels <-
        setNames(
          c(attributes(SUF[[paste0(b, "_kat")]])$labels, num2),
          c(names(attributes(SUF[[paste0(b, "_kat")]])$labels), paste0(i, " und mehr")
          ))
    }
    }
    
  }

  SUF[[b]] <- NULL
  print(b)
  
}
