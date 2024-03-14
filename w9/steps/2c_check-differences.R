# manueller Abgleich

# not quoted / tnz
attributes(dat$w5_phh_mp_ka__7) <- attributes(dat$w5_phh_mp_ka__5) 
attributes(dat$w5_phh_mp_ka__8) <- attributes(dat$w5_phh_mp_ka__5) 

# neue Parteien
attributes(dat$sonntagsfrage__5) <- attributes(dat$sonntagsfrage__7) 

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

# Homeoffice Prspektive
attributes(dat$home_persp__2) <- attributes(dat$home_persp__7)
attributes(dat$home_persp__3) <- attributes(dat$home_persp__7)
attributes(dat$home_persp__4) <- attributes(dat$home_persp__7)
attributes(dat$home_persp__5) <- attributes(dat$home_persp__7)

# Arbeitszeit
attributes(dat$az_mp_ka__2) <-  attributes(dat$az_mp_ka__5)
attributes(dat$az_mp_ka__3) <-  attributes(dat$az_mp_ka__5)
attributes(dat$az_mp_ka__7) <-  attributes(dat$az_mp_ka__5)
attributes(dat$az_mp_ka__8) <-  attributes(dat$az_mp_ka__5)

# Homeoffice aktuell
attributes(dat$home_akt__2) <-  attributes(dat$home_akt__7) 
attributes(dat$home_akt__3) <-  attributes(dat$home_akt__7)
attributes(dat$home_akt__4) <-  attributes(dat$home_akt__7)
attributes(dat$home_akt__5) <-  attributes(dat$home_akt__7)

# Regelungen
attributes(dat$reg_home__5) <- attributes(dat$reg_home__9)
