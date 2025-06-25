dir.create("output/data/suf", showWarnings=F)

write_sav(SUF, "output/data/suf/epb_1-10_long_suf_v1-0.sav")
write_dta(SUF, "output/data/suf/epb_1-10_long_suf_v1-0.dta")

dat_wide <-
  SUF %>% 
  pivot_wider(
    id_cols=ID, 
    names_from=Welle, 
    names_prefix="_", 
    values_from=alter:oecd_weight_gen_kat
  ) 

dat_wide <-
  dat_wide %>% 
  select(which(map_int(dat_wide, function(x) sum(x >= -8)) != 0))

write_sav(dat_wide, "output/data/suf/epb_1-10_wide_suf_v1-0.sav")
write_dta(dat_wide, "output/data/suf/epb_1-10_wide_suf_v1-0.dta")

save(Doku, file=paste0("output/", Sys.Date(), "_Doku.RData"))
