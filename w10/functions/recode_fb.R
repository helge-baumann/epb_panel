n <- 8

fb <- readLines(paste0("frageboegen/neu/Fragebogen_W", n, ".txt"))

w <- datenbasis[[n]]

names <- unlist(map(w, function(x) return(names(attributes(x)$labels))))
values <- unlist(map(w, function(x) return(attributes(x)$labels)))

labs <- tibble(values, names)
labs <- filter(labs, names != "")

fb_new <- fb

for(i in seq_along(fb)) {
  
  if(fb[i] %in% labs$names) {
    
    index <- which(labs$names == fb[i])[1]
  
  fb_new[i] <- 
      str_replace(
        fb[i], 
        fb[i], 
        paste0(labs$values[index], ": ", fb[i])
        )
  
  } else {
    
    if(nchar(fb[i]) > 20 & any(str_detect(fb[i], paste0("^", labs$names)))) {
      
      index <- which(str_detect(fb[i], paste0("^", labs$names)))[1]
      
      fb_new[i] <- 
        str_replace(
          fb[i], 
          fixed(fb[i]), 
          paste0(labs$values[index], ": ", fb[i])
        )
      
    }
    
  }
  
}

test <- cbind(fb, fb_new)

#writeLines(fb_new, paste0("frageboegen/neu/Fragebogen_W", n, ".txt"))

l <- function(x) { return(attributes(w[[x]])$labels) }
t <- function(x) { return(table(haven::as_factor(w[[x]], "both"))) }
