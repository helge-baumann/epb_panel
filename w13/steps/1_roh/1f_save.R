# Ordner
dir.create("output/data", showWarnings = F)
map(
  c("roh", "bereinigt", "suf", "herausgabe"), 
  function(x) dir.create(paste0("output/data/", x), showWarnings = F)
  )

# Name der Datei (softwareunabhängig)
name_datei <- paste0("output/data/roh/epb_1-", w,"_wide_roh_", v)

write_sav(dat, paste(name_datei, ".sav"))
write_dta(dat, paste(name_datei, ".dta"))
