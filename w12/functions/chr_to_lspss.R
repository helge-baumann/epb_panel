chr_to_lspss <- function(x, label="label") {
  
  x <- 
    labelled_spss(
      as.integer(as_factor(x)),
      labels = setNames(
        unique_na(as.integer(as_factor(x))),  
        unique_na(as_factor(x))
      ),
      label=label
    )
  
  return(x)
  
}
