# files <- dir("steps", full.names=T, recursive=T)
# files <- files[str_detect(files, "/1|/2_")][1:10]
# map(files, source)

# manueller Abgleich

Doku$manueller_abgleich <- "Bei ansonsten identischen Variablen wird das 
sinnvollere Labeling vergeben"

# Zunächst: Erst- und Zweitstimme Welle 6 und Welle 14
zweitstimme <- 
  data.frame(
    name = names(attributes(dat$zweitstimme__6)$labels), 
    value = attributes(dat$zweitstimme__6)$labels
  ) %>% 
  rbind(
    data.frame(
      name = names(attributes(dat$zweitstimme__14)$labels), 
      value = attributes(dat$zweitstimme__14)$labels)
) %>% 
  unique() 

zweitstimme$name <- str_replace_all(zweitstimme$name, c("DIE LINKE" = "Die Linke", "FREIE WÄHLER" = "Freie Wähler"))

zweitstimme <- zweitstimme %>%  unique() %>%  arrange(value)

labels_zweitstimme <- setNames(zweitstimme$value, zweitstimme$name)

attributes(dat$zweitstimme__6)$labels <- labels_zweitstimme
attributes(dat$zweitstimme__14)$labels <- labels_zweitstimme

for(i in 1:w) {
  
  if(paste0("erststimme__", i) %in% names(dat)) {
  dat[[paste0("erststimme__", i)]][dat[[paste0("erststimme__", i)]] == 96] <- -5
  dat[[paste0("zweitstimme__", i)]][dat[[paste0("zweitstimme__", i)]] == 96] <- -5
  
  attributes(dat[[paste0("erststimme__", i)]])$labels[
    attributes(dat[[paste0("erststimme__", i)]])$labels == 96
  ] <- -5
  
  attributes(dat[[paste0("zweitstimme__", i)]])$labels[
    attributes(dat[[paste0("zweitstimme__", i)]])$labels == 96
  ] <- -5
  }
}

# Erststimme 
erststimme <- 
  data.frame(
    name = names(attributes(dat$erststimme__6)$labels), 
    value = attributes(dat$erststimme__6)$labels
  ) %>% 
  rbind(
    data.frame(
      name = names(attributes(dat$erststimme__14)$labels), 
      value = attributes(dat$erststimme__14)$labels)
  ) %>% 
  unique() 

erststimme$name <- str_replace_all(erststimme$name, c("DIE LINKE" = "Die Linke", "FREIE WÄHLER" = "Freie Wähler"))
erststimme <- erststimme %>%  unique() %>%  arrange(value)

labels_erststimme <- setNames(erststimme$value, erststimme$name)

attributes(dat$erststimme__6)$labels <- labels_erststimme
attributes(dat$erststimme__14)$labels <- labels_erststimme

# "neue Funde" (W11 + W12)

# Sonntagsfrage: BSW auf Code 18
dat$sonntagsfrage__13[dat$sonntagsfrage__13 == 7] <- 18
# attributes(dat$sonntagsfrage__13)$labels[
#   names(
#     attributes(dat$sonntagsfrage__13)$labels) == "Bündnis Sahra Wagenknecht (BSW)"
#   ] <- 18

for(i in 1:13) { attributes(dat[[paste0("erwt__", i)]]) <- attributes(dat[[paste0("erwt__", 14)]]) }

attributes(dat$w3_i_income__3) <- attributes(dat$w3_i_income__12)
attributes(dat$w3_i_income__5) <- attributes(dat$w3_i_income__12)
attributes(dat$w3_i_income__7) <- attributes(dat$w3_i_income__12)
attributes(dat$w3_i_income__8) <- attributes(dat$w3_i_income__12)
attributes(dat$w3_i_income__9) <- attributes(dat$w3_i_income__12)
attributes(dat$w3_i_income__10) <- attributes(dat$w3_i_income__12)
attributes(dat$w3_i_income__11) <- attributes(dat$w3_i_income__12)

attributes(dat$w3_hh_income__3) <- attributes(dat$w3_hh_income__12)
attributes(dat$w3_hh_income__5) <- attributes(dat$w3_hh_income__12)
attributes(dat$w3_hh_income__7) <- attributes(dat$w3_hh_income__12)
attributes(dat$w3_hh_income__8) <- attributes(dat$w3_hh_income__12)
attributes(dat$w3_hh_income__9) <- attributes(dat$w3_hh_income__12)
attributes(dat$w3_hh_income__10) <- attributes(dat$w3_hh_income__12)
attributes(dat$w3_hh_income__11) <- attributes(dat$w3_hh_income__12)

attributes(dat$w4_taetigk__11) <- attributes(dat$w4_taetigk__4) 
attributes(dat$w4_taetigk__12) <- attributes(dat$w4_taetigk__4) 
attributes(dat$w4_taetigk__13) <- attributes(dat$w4_taetigk__4) 
attributes(dat$home_potenzial__12) <- attributes(dat$home_potenzial__4)
attributes(dat$home_potenzial__13) <- attributes(dat$home_potenzial__4)
attributes(dat$w8_aktvert_kb__11) <- attributes(dat$w8_aktvert_kb__8) # gendern
attributes(dat$w8_aktvert_kb__12) <- attributes(dat$w8_aktvert_kb__8) # gendern
attributes(dat$w8_aktvert_kb__13) <- attributes(dat$w8_aktvert_kb__8) # gendern
attributes(dat$az_mp_mai23__12) <- attributes(dat$az_mp_mai23__10) # codierung

attributes(dat$w8_home_akt__8) <- attributes(dat$w8_home_akt__13) # leerzeichen 
attributes(dat$w8_home_akt__9) <- attributes(dat$w8_home_akt__13) 
attributes(dat$w8_home_akt__10) <- attributes(dat$w8_home_akt__13) 
attributes(dat$w8_home_akt__12) <- attributes(dat$w8_home_akt__13) 

attributes(dat$gren__11) <- attributes(dat$gren__13) # Skala leicht verändert. 


# "neue Funde" (W10)----
# Wellen 1 bis 10 ("Keine Angabe" fehlt bei W1)
attributes(dat$bbild_mp_ausb__1) <- attributes(dat$bbild_mp_ausb__10) # kA
attributes(dat$bbild_mp_meist__1) <- attributes(dat$bbild_mp_meist__10)
attributes(dat$bbild_mp_fachs__1) <- attributes(dat$bbild_mp_fachs__10)
attributes(dat$bbild_mp_ba__1) <- attributes(dat$bbild_mp_ba__10)
attributes(dat$bbild_mp_ma__1) <- attributes(dat$bbild_mp_ma__10)
attributes(dat$bbild_mp_dr__1) <- attributes(dat$bbild_mp_dr__10)
attributes(dat$bbild_mp_sonst__1) <- attributes(dat$bbild_mp_sonst__10)

# Welle 1 und 2
attributes(dat$einfl_iinc__2) <- attributes(dat$einfl_iinc__1) # minimal
attributes(dat$erwstat_mp_sv__2) <- attributes(dat$erwstat_mp_sv__1) # tnz
attributes(dat$erwstat_mp_unbefr__2) <- attributes(dat$erwstat_mp_unbefr__1)
attributes(dat$erwstat_mp_leih__2) <- attributes(dat$erwstat_mp_leih__1)
attributes(dat$erwstat_mp_wv__2) <- attributes(dat$erwstat_mp_wv__1)
attributes(dat$erwstat_mp_mini__2) <- attributes(dat$erwstat_mp_mini__1)
attributes(dat$home_akt__2) <- attributes(dat$home_akt__1) # irrelevant

# Welle 1 bis 3
attributes(dat$home_akt__3) <- attributes(dat$home_akt__1) # irrelevant
attributes(dat$einfl_iinc__3) <- attributes(dat$einfl_iinc__1) # minimal
attributes(dat$bbild_mp_ausb__3) <- attributes(dat$bbild_mp_ausb__1) # case
attributes(dat$bbild_mp_meist__3) <- attributes(dat$bbild_mp_meist__1)
attributes(dat$bbild_mp_fachs__3) <- attributes(dat$bbild_mp_fachs__1)
attributes(dat$bbild_mp_ba__3) <- attributes(dat$bbild_mp_ba__1)
attributes(dat$bbild_mp_ma__3) <- attributes(dat$bbild_mp_ma__1)
attributes(dat$bbild_mp_dr__3) <- attributes(dat$bbild_mp_dr__1)
attributes(dat$bbild_mp_sonst__3) <- attributes(dat$bbild_mp_sonst__1)
attributes(dat$bbild_mp_ka__3) <- attributes(dat$bbild_mp_ka__1)
attributes(dat$phh_mp_ue18__3) <- attributes(dat$phh_mp_ue18__1)
attributes(dat$phh_mp_ue13u18__3) <- attributes(dat$phh_mp_ue13u18__1)
attributes(dat$phh_mp_u14__3) <- attributes(dat$phh_mp_u14__1)

# welle 1 bis 4

# Welle 1 bis 5
attributes(dat$einfl_iinc__5) <- attributes(dat$einfl_iinc__1) # minimal
attributes(dat$bbild_mp_ausb__5) <- attributes(dat$bbild_mp_ausb__1) # case
attributes(dat$bbild_mp_meist__5) <- attributes(dat$bbild_mp_meist__1)
attributes(dat$bbild_mp_fachs__5) <- attributes(dat$bbild_mp_fachs__1)
attributes(dat$bbild_mp_ba__5) <- attributes(dat$bbild_mp_ba__1)
attributes(dat$bbild_mp_ma__5) <- attributes(dat$bbild_mp_ma__1)
attributes(dat$bbild_mp_dr__5) <- attributes(dat$bbild_mp_dr__1)
attributes(dat$bbild_mp_sonst__5) <- attributes(dat$bbild_mp_sonst__1)
attributes(dat$bbild_mp_ka__5) <- attributes(dat$bbild_mp_ka__1)

# Wellen 1 bis 6

# Wellen 1 bis 7
attributes(dat$home_akt__7) <- attributes(dat$home_akt__1)
attributes(dat$einfl_iinc__7) <- attributes(dat$einfl_iinc__1)
attributes(dat$reg_home__7) <- attributes(dat$reg_home__5) # case

# Wellen 1 bis 8

# Wellen 1 bis 9
attributes(dat$w4_taetigk__9) <- attributes(dat$w4_taetigk__4) # gendern
attributes(dat$reg_home__9) <- attributes(dat$reg_home__5)
attributes(dat$sonntagsfrage__5) <- attributes(dat$sonntagsfrage__9) # minimal
attributes(dat$sonntagsfrage__7) <- attributes(dat$sonntagsfrage__9) 
attributes(dat$w8_aktvert_kb__9) <- attributes(dat$w8_aktvert_kb__8) # gendern

attributes(dat$bbild_mp_ausb__9) <- attributes(dat$bbild_mp_ausb__1) # case
attributes(dat$bbild_mp_meist__9) <- attributes(dat$bbild_mp_meist__1)
attributes(dat$bbild_mp_fachs__9) <- attributes(dat$bbild_mp_fachs__1)
attributes(dat$bbild_mp_ba__9) <- attributes(dat$bbild_mp_ba__1)
attributes(dat$bbild_mp_ma__9) <- attributes(dat$bbild_mp_ma__1)
attributes(dat$bbild_mp_dr__9) <- attributes(dat$bbild_mp_dr__1)
attributes(dat$bbild_mp_sonst__9) <- attributes(dat$bbild_mp_sonst__1)

# Wellen 1 bis 10
attributes(dat$erwt__10) <- attributes(dat$erwt__1)
attributes(dat$w4_taetigk__10) <- attributes(dat$w4_taetigk__4)

attributes(dat$home_potenzial__10) <- attributes(dat$home_potenzial__4)
attributes(dat$w8_aktvert_kb__10) <- attributes(dat$w8_aktvert_kb__8)

# Alte Funde (bis W9)----

# not quoted / tnz
attributes(dat$w5_phh_mp_ka__7) <- attributes(dat$w5_phh_mp_ka__5) 
attributes(dat$w5_phh_mp_ka__8) <- attributes(dat$w5_phh_mp_ka__5) 

# Wohnsituation (Rechtschr.)
attributes(dat$wohnsit__3) <- attributes(dat$wohnsit__5)

# Pendeln: Schwachsinnige Labels
attributes(dat$pend_mp_fahr_min__3)$labels <-  NULL
attributes(dat$pend_mp_fahr_min__8)$labels <-  NULL
attributes(dat$pend_mp_oeff_min__3)$labels <-  NULL
attributes(dat$pend_mp_oeff_min__8)$labels <-  NULL
attributes(dat$pend_mp_auto_min__3)$labels <-  NULL
attributes(dat$pend_mp_auto_min__8)$labels <-  NULL

attributes(dat$pend_mp_fahr_angabe__3) <-  attributes(dat$pend_mp_fahr_angabe__8)
attributes(dat$pend_mp_oeff_angabe__3) <-  attributes(dat$pend_mp_oeff_angabe__8)
attributes(dat$pend_mp_auto_angabe__3) <-  attributes(dat$pend_mp_auto_angabe__8)

# Work-Life-Balance
attributes(dat$wlb__3) <- attributes(dat$wlb__5)

# Konsumverhalten
for(b in c("wn", "and", "tour", "bild","unth", "post", "mobil", "gesn", "gert", "wohn", "bekl", "kons"))
attributes(dat[[paste0("kverh2_mp_", b, "__2")]]) <- attributes(dat[[paste0("kverh2_mp_", b, "__3")]])

for(b in c("wn", "nein", "garn", "spaet"))
  attributes(dat[[paste0("kverh1_mp_", b, "__2")]]) <- attributes(dat[[paste0("kverh1_mp_", b, "__3")]])

# Arbeitszeitreduktion
for(b in c("ka", "nein", "partner", "ich")) {
  attributes(dat[[paste0("w2_azrk_mp_", b, "__2")]]) <- attributes(dat[[paste0("w2_azrk_mp_", b, "__3")]])
  attributes(dat[[paste0("w2_azrk_mp_", b, "__7")]]) <- attributes(dat[[paste0("w2_azrk_mp_", b, "__3")]])
}

# AZ Partner
attributes(dat$azpartner_vor__2) <- attributes(dat$azpartner_vor__7)
attributes(dat$azpartner_vor__3) <- attributes(dat$azpartner_vor__7)
attributes(dat$azpartner_vor__5) <- attributes(dat$azpartner_vor__7)

# Homeoffice Perspektive
attributes(dat$home_persp__2) <- attributes(dat$home_persp__7)
attributes(dat$home_persp__3) <- attributes(dat$home_persp__7)
attributes(dat$home_persp__4) <- attributes(dat$home_persp__7)
attributes(dat$home_persp__5) <- attributes(dat$home_persp__7)

# Arbeitszeit
attributes(dat$az_mp_ka__2) <-  attributes(dat$az_mp_ka__5)
attributes(dat$az_mp_ka__3) <-  attributes(dat$az_mp_ka__5)
attributes(dat$az_mp_ka__7) <-  attributes(dat$az_mp_ka__5)
attributes(dat$az_mp_ka__8) <-  attributes(dat$az_mp_ka__5)

# test
sonntag <- list()
for(i in 1:w) {
  
  if(paste0("sonntagsfrage__", i) %in% names(dat))
    
    sonntag[[as.character(i)]] <- enframe(attributes(dat[[paste0("sonntagsfrage__", i)]])$labels)
  
}
sonntag <- sonntag[!sapply(sonntag, is.null)]

sonntag %>% 
  reduce(full_join, by="name") %>% 
  write.csv2("output/check_sonntagsfrage.csv")
