# rename according to table
# alle Datensätze namen und Namen entsprechend Vorgabe umwandeln

# Überträge (nicht in Liste) löschen
Doku$uebertraege_deleted <- NULL

for(b in names(dat)[2:length(names(dat))]) {
  
  col <- as.numeric(str_extract(b, "[:digit:]{1,2}$"))
  
  if(!(str_remove(b, "__[:digit:]{1,2}") %in% na.omit(namen_panel[,col])) & 
     !str_detect(b, "Stichprobe")) {
    
    dat[[b]] <- NULL
    Doku$uebertraege_deleted <- c(Doku$uebertraege_deleted, b)
    
  }
  
}

# Renaming

for (i in 1:nrow(namen_panel)) {
    for (j in seq_along(datenbasis)) {
      if("NA__5" %in% names(dat)) print(c(i,j))
      if (paste0(namen_panel[i, j], "__", j) %in% names(dat)) {
        
        newname <- paste0(namen_panel[i, "newname"], "__", j) 
        
        dat <- dat %>% rename({{ newname }} := paste0(namen_panel[i, j], "__", j))
        attributes(dat[[newname]])$label <- namen_panel[i, "newlabel"]
      }
    }

  }

Doku$namen_abgleich <-
  namen_panel %>%
  select(starts_with("n")) %>%
  replace(., is.na(.), "") %>%
  as_tibble()
