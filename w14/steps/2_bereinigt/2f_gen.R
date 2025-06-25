# Variablen generieren

# Personen im Haushalt
# Annahmen:
# Wenn Missing bei Ü17: 1; wenn 0 bei Ü17: ebenfalls 1 (diskussionswürdig).
# Wenn Missing bei U18: 0
Doku$generate <- NULL

dat_long <-
  dat_long %>%
  mutate(teilnahme_welle = if_else(is.na(geschlecht), 0, 1))

# Stichprobe


Doku$generate$ue17 <- "0 bei ü17 auf 1 gesetzt (alle volljährig)"

dat_long <-
  dat_long %>%
  # Überführung Individualeinkommen auf HHeinkommen bei Haushaltsgröße = 1 denkbar
  mutate(
    hhgr_ue17_gen =
      case_when(
        Welle %in% c(1, 3:4) & !is.na(alter) & phh_mp_ue18 == -8 ~ -8,
        Welle %in% c(1, 3:4) & !is.na(alter) & is.na(phh_mp_ue18) ~ 1,
        Welle %in% c(1, 3:4) & !is.na(alter) & phh_mp_ue18 >= 0 ~ phh_mp_ue18,
        Welle %in% c(5, 7:w) & !is.na(alter) & w5_phh_mp_ue17 == -8 ~ -8,
        Welle %in% c(5, 7:w) & !is.na(alter) & is.na(w5_phh_mp_ue17) ~ 1,
        Welle %in% c(5, 7:w) & !is.na(alter) & w5_phh_mp_ue17 > 0 ~ w5_phh_mp_ue17,
        Welle %in% c(5, 7:w) & !is.na(alter) & w5_phh_mp_ue17 == 0 ~ 1
      ),
    hhgr_ue13u18_gen =
      case_when(
        Welle %in% c(1, 3:4) & !is.na(alter) & phh_mp_ue13u18 == -8 ~ -8,
        Welle %in% c(1, 3:4) & !is.na(alter) & is.na(phh_mp_ue13u18) ~ 0,
        Welle %in% c(1, 3:4) & !is.na(alter) & phh_mp_ue13u18 >= 0 ~ phh_mp_ue13u18,
        Welle %in% c(5, 7:13) & !is.na(alter) & w5_phh_mp_ue13u18 == -8 ~ -8,
        Welle %in% c(5, 7:13) & !is.na(alter) & is.na(w5_phh_mp_ue13u18) ~ 0,
        Welle %in% c(5, 7:13) & !is.na(alter) & w5_phh_mp_ue13u18 >= 0 ~ w5_phh_mp_ue13u18
      ),
    hhgr_u14_gen =
      case_when(
        Welle %in% c(1, 3:4) & !is.na(alter) & phh_mp_u14 == -8 ~ -8,
        Welle %in% c(1, 3:4) & !is.na(alter) & (is.na(phh_mp_u14)) ~ 0,
        Welle %in% c(1, 3:4) & !is.na(alter) & phh_mp_u14 >= 0 ~ phh_mp_u14,
        Welle %in% c(5, 7:13) & !is.na(alter) & w5_phh_mp_u14 == -8 ~ -8,
        Welle %in% c(5, 7:13) & !is.na(alter) & is.na(w5_phh_mp_u14) ~ 0,
        Welle %in% c(5, 7:13) & !is.na(alter) & w5_phh_mp_u14 >= 0 ~ w5_phh_mp_u14
      ),
    hhgr_n_gen =
      case_when(
        hhgr_ue17_gen >= 0 & hhgr_ue13u18_gen >= 0 & hhgr_u14_gen >= 0 ~
          hhgr_ue17_gen + hhgr_ue13u18_gen + hhgr_u14_gen,
        hhgr_ue17_gen < 0 | hhgr_ue13u18_gen < 0 | hhgr_u14_gen < 0 ~ -8
      )
  )

# Schleife zur Überführung (vorläufig nicht notwendig)
# for(i in 2:10) {

# for(j in i:2) {
# dat_long <-
# dat_long %>%
# group_by(ID) %>%
# mutate(
#  hhgr_ue17_gen = if_else(Welle == i & !is.na(alter) & is.na(hhgr_ue17_gen),  hhgr_ue17_gen[j-1], hhgr_ue17_gen),
#  hhgr_ue13u18_gen = if_else(Welle == i & !is.na(alter) & is.na(hhgr_ue13u18_gen), hhgr_ue13u18_gen[j-1], hhgr_ue13u18_gen),
#  hhgr_u14_gen = if_else(Welle == i & !is.na(alter) & is.na(hhgr_u14_gen), hhgr_u14_gen[j-1], hhgr_u14_gen)
#  )
# print(c(i, j))
# }
# }

# Nettoäquivalenzeinkommen
dat_long <-
  dat_long %>%
  mutate(
    oecd_weight_gen =
      case_when(
        hhgr_ue17_gen >= 0 & hhgr_ue13u18_gen >= 0 & hhgr_u14_gen >= 0 ~
          1 + (hhgr_ue17_gen + hhgr_ue13u18_gen - 1) * 0.5 + hhgr_u14_gen * 0.3,
        hhgr_ue17_gen < 0 | hhgr_ue13u18_gen < 0 | hhgr_u14_gen < 0 ~ -8
      ),
    # Klassenmittelwerte (Achtung: Welle 1 kein Individualeinkommen; deshalb keine Missing-Übertragung)
    hh_inc_gen =
      case_when(
        hh_income == -8 | w2_hh_income == -8 |
          w3_hh_income == -8 | w13_hh_income == -8 ~ -8,
        hh_income == 1 | w2_hh_income == 1 | w3_hh_income == 1 | w13_hh_income == 1 ~ 400,
        hh_income == 2 | w2_hh_income == 2 | w3_hh_income == 2 | w13_hh_income == 2 ~ 700,
        hh_income == 3 | w2_hh_income == 3 | w3_hh_income == 3 | w13_hh_income == 3 ~ 1100,
        hh_income == 4 | w2_hh_income == 4 | w3_hh_income == 4 | w13_hh_income == 4 ~ 1400,
        hh_income == 5 | w2_hh_income == 5 | w3_hh_income == 5 | w13_hh_income == 5 ~ 1600,
        hh_income == 6 | w2_hh_income == 6 | w3_hh_income == 6 | w13_hh_income == 6 ~ 1850,
        hh_income == 7 | w2_hh_income == 7 | w3_hh_income == 7 | w13_hh_income == 7 ~ 2300,
        hh_income == 8 | w2_hh_income == 8 | w3_hh_income == 8 | w13_hh_income == 8 ~ 2900,
        hh_income == 9 | w2_hh_income == 9 | w3_hh_income %in% 9:10 | w13_hh_income %in% 9:10 ~ 3850,
        hh_income == 10 | w2_hh_income %in% 10:11 | w3_hh_income %in% 11:12 | w13_hh_income %in% 11:14 ~ 5500 # wesentliche Änderung
      ), # Klassengrenzen
    hh_inc_vor_gen =
      case_when(
        hh_income_vor == -8 ~ -8,
        hh_income_vor == 1 ~ 400,
        hh_income_vor == 2 ~ 700,
        hh_income_vor == 3 ~ 1100,
        hh_income_vor == 4 ~ 1400,
        hh_income_vor == 5 ~ 1600,
        hh_income_vor == 6 ~ 1850,
        hh_income_vor == 7 ~ 2300,
        hh_income_vor == 8 ~ 2900,
        hh_income_vor %in% 9:10 ~ 3850,
        hh_income_vor %in% 11:12 ~ 5500
      ),
    hh_inc_aeq_gen = if_else(hh_inc_gen > 0 & oecd_weight_gen > 0, hh_inc_gen / oecd_weight_gen, -8),
    hh_inc_vor_aeq_gen = if_else(hh_inc_vor_gen > 0 & oecd_weight_gen > 0, hh_inc_vor_gen / oecd_weight_gen, -8),
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
        hh_inc_vor_aeq_gen < 0 ~ hh_inc_vor_aeq_gen,
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
        einfl_hhinc %in% c(-7, 4) & einfl_iinc == -7 ~ -7
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

# Vignetten
vignetten <-
  read.xlsx(
    "info/Vignetten-Universum_2023-11-21.xlsx",
    cols = 2:12
  ) %>%
  tibble() %>%
  unique() %>%
  mutate(
    v_index = 1:192
  ) %>%
  unite(volltext, Text1:Text6, remove = F) %>%
  select(seq(1, 13, by = 2)) %>%
  mutate(across(where(is.character), ~ str_trim(.)))


dat_long <-
  left_join(dat_long, vignetten, by = join_by(w12_c_0006 == v_index))

dat_long <-
  left_join(dat_long, vignetten, by = join_by(w12_c_0007 == v_index), suffix = c("1", "2"))

dat_long <-
  dat_long %>%
  rename(
    vgn_kinder1 = Kinder1,
    vgn_geschlecht1 = Geschlecht1,
    vgn_arbeitszeit1 = Arbeitszeit1,
    vgn_anteilhomeoffice1 = Anteil.Homeoffice1,
    vgn_regelung1 = Regelung1,
    vgn_volltext1 = volltext1,
    vgn_kinder2 = Kinder2,
    vgn_geschlecht2 = Geschlecht2,
    vgn_arbeitszeit2 = Arbeitszeit2,
    vgn_anteilhomeoffice2 = Anteil.Homeoffice2,
    vgn_regelung2 = Regelung2,
    vgn_volltext2 = volltext2
  )

# Servicevariablen
dat_long <-
  dat_long %>%
  mutate(
    altgrup_gen =
      labelled_spss(
        case_when(
          alter < 25 & alter >= 0 ~ 1,
          alter >= 25 & alter < 35 ~ 2,
          alter >= 35 & alter < 45 ~ 3,
          alter >= 45 & alter < 55 ~ 4,
          alter >= 55 & alter < 65 ~ 5,
          alter >= 65 ~ 6
        ),
        labels = setNames(
          1:6,
          c(
            "(1) 16 bis 24 Jahre",
            "(2) 25 bis 34 Jahre",
            "(3) 35 bis 44 Jahre",
            "(4) 45 bis 54 Jahre",
            "(5) 55 bis 64 Jahre",
            "(6) 65 Jahre und älter"
          )
        ),
        label = "Alter gruppiert, generiert"
      )
  )

dat_long <-
  dat_long %>%
  mutate(
    ostwest_gen =
      labelled_spss(
        case_when(
          bland %in% 11:16 ~ 1, 
          bland %in% 1:10 ~ 2
        ),
        labels = setNames(1:2, c("Ost (inkl. Berlin)", "West")),
        label = "Region (Ost / West), generiert"
      ), 
    ostwest_berlin_gen =
      labelled_spss(
        case_when(
          bland %in% 12:16 ~ 1, 
          bland %in% 1:10 ~ 2,
          bland %in% 11 ~ 3
          
        ),
        labels = setNames(1:3, c("Ost (inkl. Berlin)", "West", "Berlin")),
        label = "Region (Ost / West / Berlin), generiert"
      )
  )



# Attribute

dat_long$teilnahme_welle <-
  labelled_spss(
    dat_long$teilnahme_welle,
    labels = setNames(c(0, 1), c("Person hat nicht teilgenommen", "Person hat teilgenommen")),
    label = "Teilnahme an Befragungswelle, generiert"
  )

dat_long$hhgr_ue17_gen <-
  labelled_spss(
    dat_long$hhgr_ue17_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Anzahl Personen ab 18 (bis einschl. W5: über 18) Jahren, generiert"
  )



dat_long$hhgr_ue13u18_gen <-
  labelled_spss(
    dat_long$hhgr_ue13u18_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Anzahl Personen ab 14 und unter 18 (W1: über 14 und unter 18) Jahren, generiert"
  )

dat_long$hhgr_u14_gen <-
  labelled_spss(
    dat_long$hhgr_u14_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Anzahl Personen unter 14 (W1: bis 14) Jahren, generiert"
  )

dat_long$hhgr_n_gen <-
  labelled_spss(
    dat_long$hhgr_n_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Haushaltsgröße, generiert"
  )

dat_long$oecd_weight_gen <-
  labelled_spss(
    dat_long$oecd_weight_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "OECD-Äquivalenzgewicht, generiert"
  )

dat_long$hh_inc_gen <-
  labelled_spss(
    dat_long$hh_inc_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Haushaltseinkommen klassiert, generiert"
  )

dat_long$hh_inc_vor_gen <-
  labelled_spss(
    dat_long$hh_inc_vor_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Haushaltseinkommen vor Corona klassiert, generiert"
  )

dat_long$hh_inc_aeq_gen <-
  labelled_spss(
    dat_long$hh_inc_aeq_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Nettohaushaltsäquivalenzeinkommen, generiert"
  )

dat_long$hh_inc_vor_aeq_gen <-
  labelled_spss(
    dat_long$hh_inc_vor_aeq_gen,
    labels = setNames(-8, "keine Angabe"),
    label = "Nettohaushaltsäquivalenzeinkommen vor Corona, generiert"
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
          "3.000 Euro und mehr"
        )
      ),
    label = "Haushaltsnettoäquivalenzeinkommen (klassiert), generiert"
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
          "3.000 Euro und mehr"
        )
      ),
    label = "Haushaltsnettoäquivalenzeinkommen vor Corona (klassiert), generiert"
  )


# Attribute
dat_long$evsa_gen <-
  labelled_spss(
    dat_long$evsa_gen,
    labels = setNames(c(-7, 0, 1), c("Weiß nicht", "Nein", "Ja")),
    label = "Einkommensverlust durch Corona-Krise, Selbstauskunft, generiert"
  )

dat_long$evsa_cum_gen <-
  labelled_spss(
    dat_long$evsa_cum_gen,
    labels = setNames(c(-7), c("Weiß nicht")),
    label = "Häufigkeit Angabe Einkommensverlust durch Corona-Krise, Selbstauskunft, generiert"
  )

dat_long$evvn_gen <-
  labelled_spss(
    dat_long$evvn_gen,
    labels = setNames(c(-8, 0, 1), c("keine Angabe zum Einkommen", "Nein", "Ja")),
    label = "Einkommensverlust durch Corona-Krise, Vergleich mit Vorkrisenniveau, generiert"
  )

dat_long$evw1_gen <-
  labelled_spss(
    dat_long$evw1_gen,
    labels = setNames(c(-8, 0, 1), c("keine Angabe zum Einkommen", "Nein", "Ja")),
    label = "Einkommensverlust gegenüber Welle 1, generiert"
  )


dat_long$vgn_kinder1 <-
  chr_to_lspss(dat_long$vgn_kinder1, label = "Vignette 1: Anzahl der Kinder")

dat_long$vgn_geschlecht1 <-
  chr_to_lspss(dat_long$vgn_geschlecht1, label = "Vignette 1: Geschlecht")

dat_long$vgn_arbeitszeit1 <-
  chr_to_lspss(dat_long$vgn_arbeitszeit1, label = "Vignette 1: Arbeitszeit")

dat_long$vgn_anteilhomeoffice1 <-
  chr_to_lspss(dat_long$vgn_anteilhomeoffice1, label = "Vignette 1: Anteil Homeoffice")

dat_long$vgn_regelung1 <-
  chr_to_lspss(dat_long$vgn_regelung1, label = "Vignette 1: Regelung")

dat_long$vgn_volltext1 <- labelled_spss(dat_long$vgn_volltext1, label = "Vignette 1: Volltext (ohne Name)")


dat_long$vgn_kinder2 <-
  chr_to_lspss(dat_long$vgn_kinder2, label = "Vignette 2: Anzahl der Kinder")

dat_long$vgn_geschlecht2 <-
  chr_to_lspss(dat_long$vgn_geschlecht2, label = "Vignette 2: Geschlecht")

dat_long$vgn_arbeitszeit2 <-
  chr_to_lspss(dat_long$vgn_arbeitszeit2, label = "Vignette 2: Arbeitszeit")

dat_long$vgn_anteilhomeoffice2 <-
  chr_to_lspss(dat_long$vgn_anteilhomeoffice2, label = "Vignette 2: Anteil Homeoffice")

dat_long$vgn_regelung2 <-
  chr_to_lspss(dat_long$vgn_regelung2, label = "Vignette 2: Regelung")

dat_long$vgn_volltext2 <- labelled_spss(dat_long$vgn_volltext2, label = "Vignette 2: Volltext (ohne Name)")

# Oesch aus ISCO
load("input/all_schemas.rda")

# write.csv2(
#   all_schemas$isco08_to_oesch16, "output/isco08_to_oesch16.csv", fileEncoding = "CP1252"
#   )

# left_join
dat_long <-
  dat_long %>%
  mutate(isco_join = as.character(isco08)) %>%
  left_join(
    all_schemas$isco08_to_oesch16,
    by = c("isco_join" = "ISCO08")
  ) %>%
  mutate(
    oesch16_gen =
      haven::labelled_spss(
        case_when(
          isco08 < 0 ~ -8,
          isco08 >= 0 & w4_taetigk %in% 1:3 ~ as.numeric(`OESCH16-employee`),
          isco08 >= 0 & w4_taetigk %in% 4:6 & solo == 1 ~ as.numeric(`OESCH16-selfemp(0)`),
          isco08 >= 0 & w4_taetigk %in% 4:6 & solo == 2 & w5_bg %in% 1:2 ~ as.numeric(`OESCH16-selfemp(1-9)`),
          isco08 >= 0 & w4_taetigk %in% 4:6 & solo == 2 & w5_bg %in% 3:7 ~ as.numeric(`OESCH16-selfemp(10+)`)
        ),
        labels = setNames(
          c(-8, 1:16),
          c(
            "keine Zuordnung möglich",
            "Large employers",
            "Self-employed professionals",
            "Small business owners with employees",
            "Small business owners without employees",
            "Technical experts",
            "Technicians",
            "Skilled manual",
            "Low-skilled manual",
            "Higher-grade managers and administrators",
            "Lower-grade managers and administrators",
            "Skilled clerks",
            "Unskilled clerks",
            "Socio-cultural professionals",
            "Socio-cultural semi-professionals",
            "Skilled service",
            "Low-skilled service"
          )
        ),
        label = "Oesch (16er-Klassifikation)"
      ),
    oesch08_gen =
      haven::labelled_spss(
        case_when(
          oesch16_gen == -8 ~ -8,
          oesch16_gen %in% 1:2 ~ 1,
          oesch16_gen %in% 3:4 ~ 2,
          oesch16_gen %in% 5:6 ~ 3,
          oesch16_gen %in% 7:8 ~ 4,
          oesch16_gen %in% 9:10 ~ 5,
          oesch16_gen %in% 11:12 ~ 6,
          oesch16_gen %in% 13:14 ~ 7,
          oesch16_gen %in% 15:16 ~ 8
        ),
        labels =
          setNames(
            c(-8, 1:8),
            c(
              "keine Zuordnung möglich",
              "Self-employed professionals and large employers",
              "Small business owners",
              "Technical (semi-)professionals",
              "Production workers",
              "(Associate) managers",
              "Clerks",
              "Socio-cultural (semi-)professionals",
              "Service workers"
            )
          ),
        label = "Oesch (8er-Klassifikation)"
      ),
    oesch05_gen =
      haven::labelled_spss(
        case_when(
          oesch16_gen == -8 ~ -8,
          oesch16_gen %in% c(1, 2, 5, 9, 13) ~ 1,
          oesch16_gen %in% c(6, 10, 14) ~ 2,
          oesch16_gen %in% c(3, 4) ~ 3,
          oesch16_gen %in% c(7, 11, 15) ~ 4,
          oesch16_gen %in% c(8, 12, 16) ~ 5
        ),
        setNames(
          c(-8, 1:5),
          c(
            "keine Zuordnung möglich",
            "Higher-grade service class",
            "Lower-grade service class",
            "Small business owners",
            "Skilled workers",
            "Unskilled workers"
          )
        ),
        label = "Oesch (5er-Klassifikation)"
      )
  ) %>% 
  select(-contains("OES", ignore.case=F)) %>% 
  select(-isco_join)





# ISCO-Übertrag (und Oesch)

# dat_long <-
#   dat_long %>%
#   arrange(ID, Welle) %>%
#   group_by(ID) %>%
#   mutate(
#     isco08_uebertrag_gen =
#       case_when(
#         Welle == 13 ~ isco08,
#         Welle != 13 & teilnahme_welle == 1 ~ isco08[13]
#       ),
#     oesch16_uebertrag_gen =
#       case_when(
#         Welle == 13 ~ oesch16_gen,
#         Welle != 13 & teilnahme_welle == 1 ~ oesch16_gen[13]
#       ),
#     oesch08_uebertrag_gen =
#       case_when(
#         Welle == 13 ~ oesch08_gen,
#         Welle != 13 & teilnahme_welle == 1 ~ oesch08_gen[13]
#       ),
#     oesch05_uebertrag_gen =
#       case_when(
#         Welle == 13 ~ oesch05_gen,
#         Welle != 13 & teilnahme_welle == 1 ~ oesch05_gen[13]
#       )
#     
#   ) %>%
#   ungroup()

# Übertrag BUndesland, Einkommen und Ostwest

dat_long <- 
  dat_long %>%
  arrange(ID, Welle) %>%  # Wichtig: Sortierung nach ID und Welle
  mutate(
    bland_uebertrag = ifelse(bland < 0, NA, bland),
    ostwest_uebertrag = ifelse(ostwest_gen < 0, NA, ostwest_gen),
    ostwest_berlin_uebertrag = ifelse(ostwest_berlin_gen < 0, NA, ostwest_berlin_gen),
    hh_inc_aeq_uebertrag = ifelse(hh_inc_aeq_gen < 0, NA, hh_inc_aeq_gen),
    hh_inc_kat_uebertrag = ifelse(hh_inc_aeq_kat < 0, NA, hh_inc_aeq_kat),
    isco08_uebertrag = ifelse(isco08 < 0, NA, isco08),
    oesch05_uebertrag = ifelse(oesch05_gen < 0, NA, oesch05_gen),
    oesch08_uebertrag = ifelse(oesch08_gen < 0, NA, oesch08_gen),
    oesch16_uebertrag = ifelse(oesch16_gen < 0, NA, oesch16_gen)
    ) %>%  # ungültige Werte auf NA setzen
  group_by(ID) %>%
  fill(
    bland_uebertrag, ostwest_uebertrag, ostwest_berlin_uebertrag, 
    hh_inc_aeq_uebertrag, hh_inc_kat_uebertrag, 
    isco08_uebertrag, oesch05_uebertrag, oesch08_uebertrag, oesch16_uebertrag,
    .direction = "downup") %>%  # LOCF: nach unten auffüllen
  ungroup() %>% 
  mutate(across(ends_with("_uebertrag"), ~ ifelse(teilnahme_welle == 1, ., NA))) 



#Doku$generate <- names(dat_long)[(which(str_detect(names(dat_long), "migr_4")) + 1):length(names(dat_long))]

# for(b in names(dat_long)) {

# if(!class(dat_long[[b]])[1] %in% c("character", "Date")) class(dat[[b]]) <- c("haven_labelled", "vctrs_vctr", "double")

# }
