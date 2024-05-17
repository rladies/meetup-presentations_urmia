#Fuzzy c-means clustering
library(factoextra)   #Custom visualizations for clusters
library(tidyverse)    #Data handling
library(cluster)      #Clustering algorithms

data(iris)
x=iris[,-5]

#fanny() function from cluster package is 
#for fuzzy c-means clustering algorithm 
# we are also defining 3 clusters to create.
res.fanny <- fanny(x, metric = "euclidean",3)
print(res.fanny)

#Look at membership coefficients at first 7  element
head(res.fanny['membership'],7)


#cluster plot
fviz_cluster(res.fanny, ellipse.type = "convex",
             palette = c("#00AFBB" , "#E7B800", "#FC4E07"),
             ggtheme = theme_minimal(),
             legend = "right")
