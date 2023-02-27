library(tidyverse)

# Transforming data with dplyr --------------------------------------------

# Understanding your data
  glimpse(iris)

# select() Selects columns
  select(iris, Species)

# arrange() sorts observations based on one or more variables
  arrange(iris, Species) # orden alfabético
  arrange(iris, Sepal.Length) # orden ascendente
  arrange(iris, desc(Sepal.Length)) # orden descendente

# filter() extract observations based on conditions
  filter(iris, Species == "virginica")
  filter(iris, Sepal.Length <= 5)

  # Combining conditions
    filter(iris, Species == "virginica", Sepal.Length <= 5)
  
# mutate() create o replace variables
  iris_selected <- mutate(iris, Ratio.Sepal = Sepal.Length / Sepal.Width)
  glimpse(iris_selected)
  
# Combining dplyr verbs
  iris %>% 
    select(starts_with("Sepal"), Species) %>% 
    mutate(Ratio=Sepal.Length/Sepal.Width) %>% 
    filter(Species=="virginica") %>% 
    arrange(desc(Ratio))
  