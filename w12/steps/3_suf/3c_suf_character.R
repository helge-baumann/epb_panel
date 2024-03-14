# Typen: 
# offene Angaben - löschen; date: löschen. 
chr <- map_lgl(SUF, function(x) class(x)[1] == "character")
Doku$suf$chr <- chr[chr==T & names(chr) != "ID"]

# löschen
SUF <- SUF %>% select(-all_of(names(Doku$suf$chr)))



