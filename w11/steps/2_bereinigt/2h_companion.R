
companion <- 
  namen_panel %>% 
  select(newname, newlabel, 
         everything()) %>% 
  rename("Name" = 1, "Label" = 2)
names(companion)[3:ncol(companion)] <- paste0("W", 1:10)

companion$`Siehe auch` <- NA

for(b in companion$Name) {
 
  # ähnlich erhoben?
  aehnlich_a <- which(
    (str_detect(companion$Name, paste0("^w[:digit:]\\_", b, "$")) |
      str_detect(companion$Name, paste0(str_remove(b, "^w[:digit:]{1,2}\\_"), "$"))) &
      companion$Name != b)

  if(length(aehnlich_a) > 0)
  companion$`Siehe auch`[which(companion$Name == b)] <- 
    paste0(companion$Name[aehnlich_a], collapse=", ")
   
}

for(b in names(dat_long)[!names(dat_long) %in% companion$Name]) {
  
  companion <-
    rbind(companion,
          c(b, attributes(dat_long[[b]])$label, rep("", 10), "generiert/zugespielt"))
  
}
  
  

saveWidget(datatable(companion), "output/companion.html")
  