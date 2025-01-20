# Name der Datei (softwareunabhängig)
name_datei <- paste0("output/data/bereinigt/epb_1-", w,"_long_bereinigt_", v)

write_sav(dat_long, paste0(name_datei, ".sav"))
write_dta(dat_long, paste0(name_datei, ".dta"))

dat_wide <-
  dat_long %>% 
  pivot_wider(
    id_cols=ID, 
    names_from=Welle, 
    names_prefix="_", 
    values_from=erwt:altgrup_gen
    ) 

dat_wide <-
  dat_wide %>% 
  select(
    which(
      map_int(
        dat_wide, 
        function(x) {
          if(
            all(class(x) != "character")) { 
            sum(x >= -8) 
            } else { 
              sum(!is.na(x)) 
            }  
          }
        ) != 0)
    )

name_datei <- paste0("output/data/bereinigt/epb_1-", w,"_wide_bereinigt_", v)

write_sav(dat_wide, paste0(name_datei, ".sav"))
write_dta(dat_wide, paste0(name_datei, ".dta"))

save(Doku, file=paste0("output/", Sys.Date(), "_Doku.RData"))
