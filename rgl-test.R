library(rgl)
library(spray)
library(tidyverse)

options(rgl.printRglwidget = TRUE)

neighbors = expand_grid(xi = c(1,0,-1), yi = c(1,0,-1), zi = c(1,0,-1)) %>%
  mutate(s = ((xi != 0) + (yi != 0) + (zi != 0))) %>%
  filter(s == 1) %>%
  select(-s) %>%
  as.matrix()

setup_model = function () {
  
  # Setup the parameters
  model <<- list(
    pars = list(
      xsize = 2000,
      ysize = 250,
      zsize = 500,
      midline = 1000
    ),
    v = list(
      corner = 1,
      axon_first = 2
    )
  )
  
  # Add the limits so that the sparse matrix knows its size
  limits = expand_grid(x = c(0, model$pars$xsize),
                       y = c(0, model$pars$ysize),
                       z = c(0, model$pars$zsize)) %>% as.matrix()
  
  model$space <<- spray(limits, rep(model$v$corner,8))
  
  # Define a single cone for testing
  model$cones <<- tibble(
    id = model$v$axon_first:(model$v$axon_first + 2),
    x = 25,
    y = 125,
    z = 250,
    crossed = F,
    ended = F
  )
}

run_iteration = function () {
  
  # Move the existing cones, marking the path with its id in the space
  pwalk(model$cones, function (id, x, y, z, crossed, ended) {
    # browser()
    # If reached the other side or got stuck, no movement
    if (ended) return (NULL)
    
    # Select a direction to move, detect collision, check if off limits
    dir_weights = c(5,1,1,1,1,0)#rep(1, 6)
    # one_of_neighbors = c(xi = 1, yi = 0, zi = 0)
    one_of_neighbors = neighbors[sample(1:nrow(neighbors), 1, prob = dir_weights), ]
    
    # Mark current position as occupied by an axon
    model$space[x,y,z] <<- id
    
    # Move cone to neighbor position
    # browser()
    model$space[x+one_of_neighbors["xi"], y+one_of_neighbors["yi"], z+one_of_neighbors["zi"]] <<- id
    model$cones[id-model$v$axon_first+1, c("x","y","z")] <<- list(x+one_of_neighbors["xi"], y+one_of_neighbors["yi"], z+one_of_neighbors["zi"])
  })
}

viz = function () {
  # browser()
  vxls = model$space$index %>% `colnames<-`(c("x","y","z")) %>% as_tibble() %>%
    bind_cols(tibble(id = as.integer(model$space$value))) %>%
    left_join(model$cones %>% select(id, ended), by = "id") %>%
    mutate(pcolor = case_when(
      id == 1 ~ "white",
      id >= 2 & ended ~ "#250552",
      id >= 2 & !ended ~ "#1560b0"
    ))
  
  with(vxls, {
    open3d()
    points3d(x = x, y = y, z = z, color = pcolor)
    decorate3d(xlim = c(0, model$pars$xsize),
               ylim = c(0, model$pars$ysize),
               zlim = c(0, model$pars$zsize),
               box = T, axes = T)
  })
}


setup_model()

for (i in 1:1000) { if (i %% 100 == 0) print(i); run_iteration() }

viz()

# Abandonar o spray e usar só uma matrix N x 4 (N sendo o tamanho do espaço, com memória reservada)

