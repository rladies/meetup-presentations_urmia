# Libraries in This season
library(sf)            # classes and functions for vector data
library(terra)         # classes and functions for raster data
library(spData)        # load geographic data
library(spDataLarge)   # load larger geographic data


# Learning about installing different packages in different ways

install.packages("ctv")
library(ctv)

#Example
ctv::available.views()
ctv::ctv("Spatial")
ctv::install.views("Spatial")
ctv::update.views("Spatial")


install.packages("pacman")
library(pacman)
#Example
pacman::p_load(
  R.utils,
  terra,
  giscoR,
  sf,
  classInt,
  tidyverse,
  tidyterra,
  colorspace
)

p_unload("remotes")

install.packages("pak")
library(pak)

#Example
pak::pak("terra")

#Install Packages from Git-Hub with remotes and Devtools
install.packages("remotes")
library(remotes)
remotes::install_github(
  "r-arcgis/arcgis",
  dependencies = TRUE
)
remotes::install_github(
  "chris-prener/biscale"
)
install.packages("devtools")
library(devtools)
devtools::install_github(
  "chris-prener/biscale"
)

#Install Packages with installed_libraries

libs <- c(
  "terra",
  "hydroGOF",
  "sf",
  "tidyverse",
  "ggtern",
  "elevatr",
  "png",
  "rayshader",
  "magick"
)

installed_libraries <- libs %in% rownames(
  installed.packages()
)

if(any(installed_libraries == F)){
  install.packages(
    libs[!installed_libraries]
  )
}

invisible(
  lapply(
    libs, library, character.only = T
  )
)