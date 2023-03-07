
# packages ----------------------------------------------------------------

library(tidyverse)
library(here)

# dataset -----------------------------------------------------------------

# ubicación de la base de datos
  hereds <- here("3 data manipulation with dplyr", "counties.rds")

# cargando la base de datos
  counties_selected <- readRDS(hereds) %>%
    select(county, 
           region, 
           state, 
           population, 
           citizens, 
           walk, 
           income, 
           unemployment, 
           land_area,
           metro)

# count -------------------------------------------------------------------
  
  # counting by region
    counties_selected %>% 
    count(region, sort=T)
  
  # counting citizens by state
    counties_selected %>% 
      count(state, wt=citizens, sort=T)
  
  # mutating and counting
    counties_selected %>% 
      mutate(population_walk = population * walk /100) %>% 
      count(state, wt=population_walk, sort=T)
    
# summarize ---------------------------------------------------------------

  # summarizing
    counties_selected %>% 
      summarize( min_population = min(population),
                 max_unemployment = max(unemployment),
                 average_income = mean(income))
    
  # summarizing by state
    counties_selected %>% 
      group_by(state) %>% 
      summarize( total_area = sum(land_area),
                 total_population = sum(population)) %>% 
      mutate( density = total_population / total_area) %>% 
      arrange(desc(density))
    
  # summarizing by state and region
    counties_selected %>% 
      group_by(region, state) %>% 
      summarize( total_pop = sum(population)) %>%
      summarize( average_pop = mean(total_pop),
                 median_pop = median(total_pop))
    
# slice_max and slice_min -------------------------------------------------

  # selecting a county from each region
    counties_selected %>% 
      group_by(region) %>% 
      slice_max(walk, n=1)
  
  # finding the lowest-income state in each region
    counties_selected %>% 
      group_by(region, state) %>% 
      summarize(average_income = mean(income)) %>% 
      slice_min(average_income, n=1)
    
  # using summarize, slice_max and count together
    counties_selected %>% 
      group_by(state, metro) %>% 
      summarize(total_pop = sum(population)) %>% 
      slice_max(total_pop, n=1) %>% 
      ungroup() %>% 
      count(metro)
    