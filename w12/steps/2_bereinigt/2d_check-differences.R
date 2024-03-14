# manueller Abgleich

Doku$manueller_abgleich <- "Bei ansonsten identischen Variablen wird das 
sinnvollere Labeling vergeben"

# "neue Funde" (W11 + W12)
for(i in 1:11) { attributes(dat[[paste0("erwt__", i)]]) <- attributes(dat[[paste0("erwt__", 12)]]) }

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
attributes(dat$home_potenzial__12) <- attributes(dat$home_potenzial__4)
attributes(dat$w8_aktvert_kb__11) <- attributes(dat$w8_aktvert_kb__8) # gendern
attributes(dat$w8_aktvert_kb__12) <- attributes(dat$w8_aktvert_kb__8) # gendern
attributes(dat$az_mp_mai23__12) <- attributes(dat$az_mp_mai23__10) # codierung


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




