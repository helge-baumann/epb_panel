dat <- 
  datenbasis %>% 
  reduce(full_join, by="ID")

kontrolle <- 
  dat %>% 
  mutate(check = 
           case_when(
             S6__5 == w4_taetigk__11 ~ "(1) W5 und W11 identisch",
             S6__5 != w4_taetigk__11 ~ "(2) W5 und W11 ungleich",
             is.na(S6__5) & !is.na(w4_taetigk__11) ~ "(3) keine Teilnahme W5, Teilnahme W11",
             !is.na(S6__5) & is.na(w4_taetigk__11) ~ "(4) Teilnahme W5, keine Teilnahme W11",
             is.na(S6__5) & is.na(w4_taetigk__11) ~ "(5) keine Teilnahme W5, keine Teilnahme W11",
           )
         ) %>% 
  select(ID, S6__5, w4_taetigk__11, check) %>% 
  arrange(desc(check)) 

kontrolle %>%
  group_by(check) %>% 
  summarise(N = n()) %>% 
  mutate(p = round(N/sum(N)*100)) %>% 
  write.csv2("output/abgleich_w5_11.csv", row.names=F, fileEncoding = "CP1252")

# kontrolle %>% 
 #  write.csv2("output/abgleich_w5_11.csv", row.names=F, fileEncoding = "CP1252")

