# Jennifer Selgrath
# NOAA CINMS
#
# driver for DSC and VMS project

# -----------------------------------------------------------
setwd("C:/Users/jennifer.selgrath/Documents/research/R_projects/dsc_value_vms/")

# load all the needed libraries for spatial analysis
source("./bin/loadlibraries.R")
# input:  none
# output: none

# clean test file - 2019 january
source("./bin/id_clean_vms_records.R")
# input:  ./data/vms_ca_2019/NOAA23-004-2019_01.csv
# output: ./results/vms_ca_2019_01.csv

