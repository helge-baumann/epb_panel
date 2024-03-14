# Longformat

for(b in names(dat)) {
  
  if(!class(dat[[b]])[1] %in% c("character", "Date")) class(dat[[b]]) <- c("haven_labelled", "vctrs_vctr", "double")
  
}

dat_long <- 
  dat %>% 
  pivot_longer(
    cols = -ID, 
    names_to = c('.value', 'Welle'), 
    names_sep="__"
  )

dat_long$Welle <- as.numeric(dat_long$Welle)