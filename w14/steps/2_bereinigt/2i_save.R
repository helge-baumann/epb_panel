# Name der Datei (softwareunabhängig)

id1 <- dat_long$ID[dat_long$Welle == 1 
                   & dat_long$teilnahme_welle == 1
]
id5 <- dat_long$ID[
  dat_long$Welle == 5 
  & dat_long$teilnahme_welle == 1 
  & !(dat_long$ID %in% id1)
]
id13 <- dat_long$ID[
  dat_long$Welle == 13 &  
    dat_long$teilnahme_welle == 1 & 
    !(dat_long$ID %in% c(id1, id5)) 
]

dat_long <- 
  dat_long %>% 
  mutate(
    Stichprobe = 
      labelled_spss(
        case_when(
          ID %in% id1 ~ 1,
          ID %in% id5 ~ 2,
          ID %in% id13 ~ 3
        ),
        labels = setNames(
          1:3, 
          c(
            "Basisstichprobe Welle 1 (2020)",
            "Neue Teilnehmer Welle 5 (Selbstständige)", 
            "Neue Teilnehmer Welle 13 (Auffrischung)"
          )
        ), 
        label = "Stichprobe (Zeitpunkt der erstmaligen Teilnahme)"
      )
  )


dat_long <- dat_long %>% rename(teilnahme = teilnahme_welle)

name_datei <- paste0("output/data/bereinigt/epb_1-", w,"_long_bereinigt_", v)

write_sav(dat_long, paste0(name_datei, ".sav"))
write_dta(dat_long, paste0(name_datei, ".dta"))
save(dat_long, file = paste0(name_datei, ".rds"))

dat_wide <-
  dat_long %>% 
  pivot_wider(
    id_cols=ID, 
    names_from=Welle, 
    names_prefix="_", 
    values_from = setdiff(names(dat_long), c("ID", "Welle"))
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
save(dat_wide, file = paste0(name_datei, ".rds"))

save(Doku, file=paste0("output/", Sys.Date(), "_Doku.RData"))

