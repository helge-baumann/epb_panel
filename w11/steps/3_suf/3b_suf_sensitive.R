SUF <-  dat_long

# sensible Items
sen <-  
 SUF %>% 
  summarise(
    across(everything(), 
           ~if_else(
             sum(.>=-8, na.rm=T) >= 1,
             sum(.==-8, na.rm=T)/sum(.>=-8, na.rm=T)*100,
             NA_real_
           )
    )
  ) %>% 
  mutate(across(everything(), ~if_else(. < 5, NA_real_, .))) %>% 
  discard(., ~all(is.na(.))) #42

# vergröbern oder löschen?
map_chr(names(sen), function(x) attributes(SUF[[x]])$label)
for(b in names(sen)) print(attributes(SUF[[b]])$label)

# grundsätzlich löschen
# welche mit "angabe"?

names(sen)[str_detect(names(sen), "angabe")]

Doku$sensitive <- NULL

for(b in names(sen)[!str_detect(names(sen), "_kat$|^ev")]) {
  
  SUF[[b]] <- NULL
  Doku$sensitive <- c(Doku$sensitive, b)
  
  if(str_detect(b, "_angabe$")) {
    
    short <- str_remove(b, "angabe$")
    namen <- names(SUF)[str_detect(names(SUF), paste0("^", short))]
    
    for(d in namen) {
      SUF[[d]] <- NULL
      Doku$sensitive <- c(Doku$sensitive, d)
    }
    
  }
}
      

