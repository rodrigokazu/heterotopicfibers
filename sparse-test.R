library(slam)

m = simple_sparse_zero_array(c(10,10,10), mode = "integer")
m[1,1,1] = 3

#################
library(spray)
library(tidyverse)

limits = expand_grid(x = c(0, 1000), y = c(0, 500), z = c(0, 250)) %>% as.matrix()

m = spray(limits, rep(1,8))
m$index %>% as_tibble() %>% `colnames<-`(c("x","y","z")) %>% bind_cols(tibble(v = as.integer(m$value)))
