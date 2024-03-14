# Longformat

for(b in names(dat)) {
  # Ohne Attribute werden Labels etc. später verworfen. 
  if(!class(dat[[b]])[1] %in% c("character", "Date")) class(dat[[b]]) <- 
      c("haven_labelled", "vctrs_vctr", "double")
}

# Fehlende Labels
for(b in names(dat)) {
  if(length(attributes(dat[[b]])$labels) == 0) {
    attributes(dat[[b]])$labels <- NULL
    print(b)
  }
}

# Longformat
dat_long <- 
  dat %>% 
  pivot_longer(cols = -ID, names_to = c('.value', 'Welle'), names_sep="__")

dat_long$Welle <- as.numeric(dat_long$Welle)

# nachrichtlich: Label der Sonntagsfrage aus Welle 5 nachreichen.

attributes(dat_long$sonntagsfrage)$labels <- 
  c(attributes(dat_long$sonntagsfrage)$labels, c(7,9,10))
names(attributes(dat_long$sonntagsfrage)$labels) <- 
  c(
    names(attributes(dat_long$sonntagsfrage)$labels)[1:19], 
    c("NPD", "ÖDP", "Familie")
    )

# Label für Welle und Datum
attributes(dat_long$Welle)$label <- "Befragungswelle" 
attributes(dat_long$intervtag)$label <- "Datum des Interviews" 