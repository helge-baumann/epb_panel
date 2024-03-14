for(b in names(dat)) {
  
  if(length(attributes(dat[[b]])[["labels"]]) > 0) {
  if(max(attributes(dat[[b]])$labels) == 169)
    attributes(dat[[b]])$labels <- attributes(dat[[b]])$labels[attributes(dat[[b]])$labels < 0] 
  }
}
