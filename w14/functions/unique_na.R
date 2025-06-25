# uniques without na

unique_na <- function(x) {
  
  x <- unique(x)
  x <- x[!is.na(x)]
  return(x)
  
}

