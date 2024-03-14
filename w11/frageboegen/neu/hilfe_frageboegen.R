fb <- readLines("frageboegen/neu/Fragebogen_Betriebsrätebefragung_2015.txt")

fb <- str_replace_all(fb, "Int.:|Int:", "INT:")
fb <- str_replace_all(fb, "Progr.:|Progr:", "PROG:")
fb <- str_replace_all(fb, "^Wenn |^Wenn: ", "WENN: ")

num <- 0
for(b in LETTERS) {
  
  num <- num+1
  
  fb <- str_replace_all(fb, paste0("^", b, ": "), paste0("_", num, ": "))
  
}

writeLines(fb, "frageboegen/neu/Fragebogen_Test.txt")
