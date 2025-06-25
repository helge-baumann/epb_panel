library(ggplot2)

dat_long %>% 
  mutate(Welle = as_factor(Welle)) %>% 
  group_by(Welle) %>% 
  filter(hh_inc_aeq_gen >= 0 & gewicht >= 0) %>% 
  mutate(w_i = hh_inc_aeq_gen*gewicht) %>% 
  summarise(net_aeq = sum(w_i)/sum(gewicht)) %>% 
  ggplot(aes(x=Welle, y=net_aeq, label=round(net_aeq))) +
  geom_col() + geom_label() + labs(y="Nettoäquivalenzeinkommen")

dat_long %>% 
  filter(az_mp_mai23 >= 0 & gewicht >= 0) %>% 
  mutate(Welle = as_factor(Welle)) %>% 
  select(ID, Welle, az_mp_mai23) %>% 
  pivot_wider(id_cols=ID, names_from=Welle, values_from=az_mp_mai23) %>% 
  mutate(abw = `12`-`10`) %>% 
  
  ggplot(aes(x=`10`, y=`12`, color = abw)) +
           geom_point()

dat_long %>% 
  filter(az_mp_mai23 >= 0 & gewicht >= 0) %>% 
  mutate(Welle = as_factor(Welle)) %>% 
  select(ID, Welle, az_mp_mai23) %>% 
  pivot_wider(id_cols=ID, names_from=Welle, values_from=az_mp_mai23) %>% 
  mutate(Abweichung = `12`-`10`) %>% 
  filter(!is.na(Abweichung)) %>% 
  group_by(Abweichung) %>% 
  summarise(n = n()) %>% 
  mutate(`%` = round(n/sum(n)*100)) %>% 
  
  ggplot(aes(x=Abweichung, y=`%`)) +
  geom_col() + xlim(c(-10,10))

dat_long %>% filter(Welle == 13) %>% mutate(isco = case_when(isco08 == -8 ~ 0, isco08 == -101 ~ 1, isco08 < -101 ~ 2, isco08 >= 0 ~ 3, isco08 %in% -10:-12 ~ isco08)) %>% group_by(isco) %>%  count() %>% 
  write.csv2("output/check_isco.csv", fileEncoding="CP1252")
  
