library(tidyverse)
library(cluster)


# Loading dataset
df <- your_data

# Omitting any NA values
df <- na.omit(df)

# categorical/ numeric clustering
gower_dist<-daisy(df, metric = "gower")
gower_mat <- as.matrix(gower_dist)

#' Print most similar observations
df[which(gower_mat == min(gower_mat[gower_mat != min(gower_mat)]), arr.ind = TRUE)[1, ], ]
#' Print most dissimilar observations
df[which(gower_mat == max(gower_mat[gower_mat != max(gower_mat)]), arr.ind = TRUE)[1, ], ]



# fit 
fith <- hclust(gower_dist , method = "ward.D")
plot(fith , labels = FALSE)

# choose k
rect.hclust(fith, k=5, border = 2:6)
cluster <- cutree(fith, k=5)

# cluster size 
table(cluster)

# add cluster to original data
df <- df %>% mutate(cluster = as.factor(cluster))