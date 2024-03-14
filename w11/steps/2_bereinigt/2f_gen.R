# Variablen generieren

# Personen im Haushalt
  # Annahmen: 
    # Wenn Missing bei Ü17: 1; wenn 0 bei Ü17: ebenfalls 1 (diskussionswürdig).
    # Wenn Missing bei U18: 0
    
dat_long <- 
  dat_long %>% 
  mutate(teilnahme_welle = if_else(is.na(geschlecht), 0, 1))

Doku$generate$ue17 <- "0 bei ü17 auf 1 gesetzt (alle volljährig)"

dat_long <- 
  dat_long %>% 
  # Überführung Individualeinkommen auf HHeinkommen bei Haushaltsgröße = 1 denkbar
  mutate(
    hhgr_ue17_gen = 
      case_when(
        Welle %in% c(1,3:4) & !is.na(alter) & phh_mp_ue18 == -8 ~ -8, 
        Welle %in% c(1,3:4) & !is.na(alter) & is.na(phh_mp_ue18) ~ 1,
        Welle %in% c(1,3:4) & !is.na(alter) & phh_mp_ue18 >= 0 ~ phh_mp_ue18,
        Welle %in% c(5,7:10) & !is.na(alter) & w5_phh_mp_ue17 == -8 ~ -8,
        Welle %in% c(5,7:10) & !is.na(alter) & is.na(w5_phh_mp_ue17) ~ 1,
        Welle %in% c(5,7:10) & !is.na(alter) & w5_phh_mp_ue17 > 0 ~ w5_phh_mp_ue17,
        Welle %in% c(5,7:10) & !is.na(alter) & w5_phh_mp_ue17 == 0 ~ 1
      ),
    hhgr_ue13u18_gen = 
      case_when(
        Welle %in% c(1,3:4) & !is.na(alter) & phh_mp_ue13u18 == -8 ~ -8,
        Welle %in% c(1,3:4) & !is.na(alter) & is.na(phh_mp_ue13u18) ~ 0,
        Welle %in% c(1,3:4) & !is.na(alter) & phh_mp_ue13u18 >= 0 ~ phh_mp_ue13u18,
        Welle %in% c(5,7:10) & !is.na(alter) & w5_phh_mp_ue13u18 == -8 ~ -8,
        Welle %in% c(5,7:10) & !is.na(alter) & is.na(w5_phh_mp_ue13u18) ~ 0,
        Welle %in% c(5,7:10) & !is.na(alter) & w5_phh_mp_ue13u18 >= 0 ~ w5_phh_mp_ue13u18
      ),
    hhgr_u14_gen = 
      case_when(
        Welle %in% c(1,3:4) & !is.na(alter) & phh_mp_u14 == -8 ~ -8,
        Welle %in% c(1,3:4) & !is.na(alter) & (is.na(phh_mp_u14)) ~ 0,
        Welle %in% c(1,3:4) & !is.na(alter) & phh_mp_u14 >= 0 ~ phh_mp_u14,
        Welle %in% c(5,7:10) & !is.na(alter) & w5_phh_mp_u14 == -8 ~ -8,
        Welle %in% c(5,7:10) & !is.na(alter) & is.na(w5_phh_mp_u14) ~ 0,
        Welle %in% c(5,7:10) & !is.na(alter) & w5_phh_mp_u14 >= 0 ~ w5_phh_mp_u14
      ),
    hhgr_n_gen = 
      case_when(
        hhgr_ue17_gen >= 0 & hhgr_ue13u18_gen >= 0 & hhgr_u14_gen >= 0 ~
        hhgr_ue17_gen+hhgr_ue13u18_gen+hhgr_u14_gen,
        hhgr_ue17_gen < 0 | hhgr_ue13u18_gen < 0 | hhgr_u14_gen < 0 ~ -8
      ) 
  )

# Schleife zur Überführung (vorläufig nicht notwendig)
#for(i in 2:10) {
  
  #for(j in i:2) {
#dat_long <- 
 # dat_long %>% 
  #group_by(ID) %>% 
 # mutate(
  #  hhgr_ue17_gen = if_else(Welle == i & !is.na(alter) & is.na(hhgr_ue17_gen),  hhgr_ue17_gen[j-1], hhgr_ue17_gen),
  #  hhgr_ue13u18_gen = if_else(Welle == i & !is.na(alter) & is.na(hhgr_ue13u18_gen), hhgr_ue13u18_gen[j-1], hhgr_ue13u18_gen),
  #  hhgr_u14_gen = if_else(Welle == i & !is.na(alter) & is.na(hhgr_u14_gen), hhgr_u14_gen[j-1], hhgr_u14_gen)
  #  )
#print(c(i, j))
 # }
#}

# Nettoäquivalenzeinkommen
dat_long <- 
  dat_long %>% 
  mutate(
    oecd_weight_gen = 
      case_when(
        hhgr_ue17_gen >= 0 & hhgr_ue13u18_gen >= 0 & hhgr_u14_gen >= 0 ~
          1+(hhgr_ue17_gen+hhgr_ue13u18_gen-1)*0.5+hhgr_u14_gen*0.3,
        hhgr_ue17_gen < 0 | hhgr_ue13u18_gen < 0 | hhgr_u14_gen < 0 ~ -8
      ),
# Klassenmittelwerte (Achtung: Welle 1 kein Individualeinkommen; deshalb keine Missing-Übertragung)
hh_inc_gen = 
  case_when(
    hh_income == -8 | w2_hh_income == -8  | w3_hh_income == -8 ~ -8,
  hh_income == 1 | w2_hh_income == 1  | w3_hh_income == 1 ~ 400,
  hh_income == 2 | w2_hh_income == 2  | w3_hh_income == 2 ~ 700,
  hh_income == 3 | w2_hh_income == 3  | w3_hh_income == 3 ~ 1100,
  hh_income == 4 | w2_hh_income == 4  | w3_hh_income == 4 ~ 1400,
  hh_income == 5 | w2_hh_income == 5  | w3_hh_income == 5 ~ 1600,
  hh_income == 6 | w2_hh_income == 6  | w3_hh_income == 6 ~ 1850,
  hh_income == 7 | w2_hh_income == 7  | w3_hh_income == 7 ~ 2300,
  hh_income == 8 | w2_hh_income == 8  | w3_hh_income == 8 ~ 2900,
  hh_income == 9 | w2_hh_income  == 9 | w3_hh_income %in% 9:10 ~ 3850,
  hh_income == 10 | w2_hh_income %in% 10:11 | w3_hh_income %in% 11:12 ~ 5500 # wesentliche Änderung
), # Klassengrenzen
hh_inc_vor_gen = 
  case_when(
    hh_income_vor == -8  ~ -8,
    hh_income_vor == 1  ~ 400,
    hh_income_vor == 2  ~ 700,
    hh_income_vor == 3  ~ 1100,
    hh_income_vor == 4  ~ 1400,
    hh_income_vor == 5  ~ 1600,
    hh_income_vor == 6  ~ 1850,
    hh_income_vor == 7  ~ 2300,
    hh_income_vor == 8 ~ 2900,
    hh_income_vor %in% 9:10  ~ 3850,
    hh_income_vor %in% 11:12 ~ 5500
  ),
hh_inc_aeq_gen = if_else(hh_inc_gen > 0 & oecd_weight_gen > 0, hh_inc_gen/oecd_weight_gen, hh_inc_gen),
hh_inc_vor_aeq_gen = if_else(hh_inc_vor_gen > 0 & oecd_weight_gen > 0, hh_inc_vor_gen/oecd_weight_gen, hh_inc_vor_gen),
)

dat_long <- 
  dat_long %>% 
  mutate(
    hh_inc_aeq_kat = 
      case_when(
        hh_inc_aeq_gen < 0 ~ hh_inc_aeq_gen,
        hh_inc_aeq_gen >= 0 & hh_inc_aeq_gen < 1500 ~ 1,
        hh_inc_aeq_gen >= 1500 & hh_inc_aeq_gen < 2000 ~ 2,
        hh_inc_aeq_gen >= 2000 & hh_inc_aeq_gen <= 2500 ~ 3,
        hh_inc_aeq_gen >= 2500 & hh_inc_aeq_gen <= 3000 ~ 4,
        hh_inc_aeq_gen > 3000 ~ 5
      ),
    hh_inc_vor_aeq_kat = 
      case_when(
        hh_inc_vor_aeq_gen < 0 ~ hh_inc_vor_aeq_gen ,
        hh_inc_vor_aeq_gen >= 0 & hh_inc_vor_aeq_gen < 1500 ~ 1,
        hh_inc_vor_aeq_gen >= 1500 & hh_inc_vor_aeq_gen < 2000 ~ 2,
        hh_inc_vor_aeq_gen >= 2000 & hh_inc_vor_aeq_gen < 2500 ~ 3,
        hh_inc_vor_aeq_gen >= 2500 & hh_inc_vor_aeq_gen < 3000 ~ 4,
        hh_inc_vor_aeq_gen >= 3000 ~ 5
      )
  ) 

# Einkommensverlust (Selbstauskunft)
dat_long <- 
  dat_long %>% 
  mutate(
    evsa_gen = 
      case_when(
        einfl_iinc %in% 1 | einfl_hhinc == 1 ~ 1,
        (einfl_hhinc %in% c(-7, 4) & einfl_iinc %in% 2:3) | 
          (einfl_iinc != 1 & einfl_hhinc %in% 2:3) ~ 0,
        einfl_hhinc %in% c(-7, 4) & einfl_iinc == -7   ~ -7
      )
  )

# Einkommensverlust (Selbstauskunft) kumulativ
dat_long <- 
  dat_long %>% 
  arrange(ID, Welle) %>% 
  mutate(hilf = if_else(is.na(evsa_gen) | evsa_gen == -7, 0, evsa_gen)) %>% 
  group_by(ID) %>% 
  mutate(evsa_cum_gen = cumsum(hilf)) %>% 
  ungroup() %>% 
  mutate(evsa_cum_gen = if_else(is.na(evsa_gen), evsa_gen, evsa_cum_gen)) %>% 
  select(-hilf) 

# Einkommensverlust gegenüber Vorkrisenniveau und Welle 1
dat_long <-
  dat_long %>% 
  group_by(ID) %>% 
  mutate(
    ew_vor = if_else(teilnahme_welle == 1, hh_inc_vor_aeq_gen[5], NA_real_), 
    ew1 = if_else(teilnahme_welle == 1, hh_inc_aeq_gen[1], NA_real_)
    ) %>% 
  ungroup() %>%  
  mutate(
    evvn_gen = case_when(
      ew_vor >= 0 & hh_inc_aeq_gen >= 0 & ew_vor > hh_inc_aeq_gen ~ 1,
      ew_vor >= 0 & hh_inc_aeq_gen >= 0 & ew_vor <= hh_inc_aeq_gen ~ 0,
      ew_vor == -8 | hh_inc_aeq_gen == -8 ~ -8
    ),
    evw1_gen = case_when(
      ew1 >= 0 & hh_inc_aeq_gen >= 0 & ew1 > hh_inc_aeq_gen ~ 1,
      ew1 >= 0 & hh_inc_aeq_gen >= 0 & ew1 <= hh_inc_aeq_gen ~ 0,
      ew1 == -8 | hh_inc_aeq_gen == -8 ~ -8
    )
  ) %>% 
  select(-c("ew_vor", "ew1"))

# Attribute

dat_long$teilnahme_welle <-
  labelled_spss(
    dat_long$teilnahme_welle, 
    labels = setNames(c(0,1),  c("Person hat teilgenommen", "Person hat nicht teilgenommen")), 
    label="Teilnahme an Befragungswelle, generiert"
  )

dat_long$hhgr_ue17_gen <-
  labelled_spss(
    dat_long$hhgr_ue17_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Anzahl Personen ab 18 (bis einschl. W5: über 18) Jahren, generiert"
  )



dat_long$hhgr_ue13u18_gen <-
  labelled_spss(
    dat_long$hhgr_ue13u18_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Anzahl Personen ab 14 und unter 18 (W1: über 14 und unter 18) Jahren, generiert"
  )

dat_long$hhgr_u14_gen <-
  labelled_spss(
    dat_long$hhgr_u14_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Anzahl Personen unter 14 (W1: bis 14) Jahren, generiert"
  )

dat_long$hhgr_n_gen <-
  labelled_spss(
    dat_long$hhgr_n_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Haushaltsgröße, generiert"
  )

dat_long$oecd_weight_gen <-
  labelled_spss(
    dat_long$oecd_weight_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="OECD-Äquivalenzgewicht, generiert"
  )

dat_long$hh_inc_gen <-
  labelled_spss(
    dat_long$hh_inc_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Haushaltseinkommen klassiert, generiert"
  )

dat_long$hh_inc_vor_gen <-
  labelled_spss(
    dat_long$hh_inc_vor_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Haushaltseinkommen vor Corona klassiert, generiert"
  )

dat_long$hh_inc_aeq_gen <-
  labelled_spss(
    dat_long$hh_inc_aeq_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Nettohaushaltsäquivalenzeinkommen, generiert"
  )

dat_long$hh_inc_vor_aeq_gen <-
  labelled_spss(
    dat_long$hh_inc_vor_aeq_gen, 
    labels = setNames(-8,  "keine Angabe"), 
    label="Nettohaushaltsäquivalenzeinkommen vor Corona, generiert"
  )

# Klassierte Einkommen
dat_long$hh_inc_aeq_kat <-
  labelled_spss(
    dat_long$hh_inc_aeq_kat, 
    labels = 
      setNames(
        c(-8, 1:5), 
        c(
          "keine Angabe",
          "unter 1.500 Euro", 
          "1.500 bis unter 2.000 Euro",
          "2.000 bis unter 2.500 Euro",
          "2.500 bis unter 3.000 Euro",
          "3.000 Euro und mehr")
      ), 
    label="Haushaltsnettoäquivalenzeinkommen (klassiert), generiert"
  )

dat_long$hh_inc_vor_aeq_kat <-
  labelled_spss(
    dat_long$hh_inc_vor_aeq_kat, 
    labels = 
      setNames(
        c(-8, 1:5), 
        c(
          "keine Angabe",
          "unter 1.500 Euro", 
          "1.500 bis unter 2.000 Euro",
          "2.000 bis unter 2.500 Euro",
          "2.500 bis unter 3.000 Euro",
          "3.000 Euro und mehr")
      ), 
    label="Haushaltsnettoäquivalenzeinkommen vor Corona (klassiert), generiert"
  )

# Attribute
dat_long$evsa_gen <-
  labelled_spss(
    dat_long$evsa_gen, 
    labels = setNames(c(-7, 0, 1),  c("Weiß nicht", "Nein", "Ja")), 
    label="Einkommensverlust durch Corona-Krise, Selbstauskunft, generiert"
  )

dat_long$evsa_cum_gen <-
  labelled_spss(
    dat_long$evsa_cum_gen, 
    labels = setNames(c(-7),  c("Weiß nicht")),
    label="Häufigkeit Angabe Einkommensverlust durch Corona-Krise, Selbstauskunft, generiert"
  )

dat_long$evvn_gen <-
  labelled_spss(
    dat_long$evvn_gen, 
    labels = setNames(c(-8, 0, 1),  c("keine Angabe zum Einkommen", "Nein", "Ja")), 
    label="Einkommensverlust durch Corona-Krise, Vergleich mit Vorkrisenniveau, generiert"
  )

dat_long$evw1_gen <-
  labelled_spss(
    dat_long$evw1_gen, 
    labels = setNames(c(-8, 0, 1),  c("keine Angabe zum Einkommen", "Nein", "Ja")), 
    label="Einkommensverlust gegenüber Welle 1, generiert"
  )

Doku$generate <- names(dat_long)[(which(str_detect(names(dat_long), "migr_4"))+1):length(names(dat_long))]

#for(b in names(dat_long)) {
  
  #if(!class(dat_long[[b]])[1] %in% c("character", "Date")) class(dat[[b]]) <- c("haven_labelled", "vctrs_vctr", "double")
  
#}

