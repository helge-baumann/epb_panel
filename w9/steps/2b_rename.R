# rename according to table
# alle Datensätze namen und Namen entsprechend Vorgabe umwandeln
for(b in names(dat)[2:length(names(dat))]) {
  
  col <- as.numeric(str_extract(b, "[:digit:]$"))
  
  if(!(str_remove(b, "__[:digit:]") %in% na.omit(namen_panel[,col]))) {
    
    dat[[b]] <- NULL
    
  }
  
}

for (i in 1:nrow(namen_panel)) {
    for (j in seq_along(datenbasis)) {
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
