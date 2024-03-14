dir.create("output/data/bereinigt", showWarnings=F)

write_sav(dat_long, "output/data/bereinigt/epb_1-10_long_bereinigt_v1-2.sav")
write_dta(dat_long, "output/data/bereinigt/epb_1-10_long_bereinigt_v1-2.dta")

dat_wide <-
  dat_long %>% 
  pivot_wider(
    id_cols=ID, 
    names_from=Welle, 
    names_prefix="_", 
    values_from=erwt:evw1_gen
    ) 

dat_wide <-
  dat_wide %>% 
  select(which(map_int(dat_wide, function(x) sum(x >= -8)) != 0))

write_sav(dat_wide, "output/data/bereinigt/epb_1-10_wide_bereinigt_v1-2.sav")
write_dta(dat_wide, "output/data/bereinigt/epb_1-10_wide_bereinigt_v1-2.dta")

save(Doku, file=paste0("output/", Sys.Date(), "_Doku.RData"))
