dat <-
  datenbasis %>% 
  reduce(full_join, by="ID")

