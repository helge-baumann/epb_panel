# Kurzanalyse Vignetten

dat_long %>% 
  filter(Welle == 12 & gewicht_alle >= 0) %>% 
  pivot_longer(c(vgn_kinder1:vgn_regelung1, w12_c_0015), names_to = "name", values_to = "value") %>% 
  filter(!is.na(value)) %>% 
  pivot_longer(cols=c(vgnfollow_eng1, vgnfollow_prd1, vgnfollow_epf1, vgnfollow_tpl1), names_to = "name2", values_to = "value2") %>% 
  group_by(name, value, name2) %>% 
  filter(value2 >= 0) %>% 
  summarise(m = mean(value2*gewicht_alle, na.rm=T)) %>% 
  pivot_wider(id_cols=c(name, value), names_from=name2, values_from=m) %>% 
  write.csv2("output/test_vignetten.csv", fileEncoding = "CP1252")
  
dat_long %>% 
  filter(Welle == 12 & gewicht_alle >= 0 & !is.na(vgn_volltext1) & !is.na(vgnfollow_epf1)) %>% 
  group_by(vgn_volltext1) %>% 
  summarise(m = mean(vgnfollow_epf1*gewicht_alle, na.rm=T)) %>% 
  arrange(desc(m)) %>% 

  write.csv2("output/test_volltext1.csv", fileEncoding = "CP1252")

dat_long %>% 
  filter(Welle == 12 & gewicht_alle >= 0 & !is.na(vgn_volltext2) & !is.na(vgnfollow_epf2)) %>% 
  group_by(vgn_volltext2) %>% 
  summarise(m = mean(vgnfollow_epf2*gewicht_alle, na.rm=T)) %>% 
  arrange(desc(m)) %>% 
  write.csv2("output/test_volltext2.csv", fileEncoding = "CP1252")

# Random Forest / Decision Tree

p_load(rpart)

follows <- names(dat_long)[str_detect(names(dat_long), "vgnfollow")]

T <- list()

for(b in follows) {
  i <- str_extract(b, "[:digit:]")
  treedata <- dat_long %>% 
    select(
      paste0("w12_c_001", 4+as.numeric(i)), 
      paste0("vgn_kinder", i, "t"):paste0("vgn_regelung", i, "t"), 
      all_of(b)) %>% 
    filter(get(b) >= 0) %>% 
    mutate(x := as.integer(get(b))) %>% 
    mutate(across(is.double, ~haven::as_factor(., levels="values"))) %>% 
    select(-all_of(b))
  
  T[[b]] <- rpart(x ~ ., data = treedata,  control=rpart.control(cp=0.005))
  pdf(file=paste0("output/", b, ".pdf"))
  rpart.plot(T[[b]], roundint = 0)
  dev.off()
}

#rpart.plot(T[[follows[1]]], roundint = 0)
 

