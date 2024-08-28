# Jennifer Selgrath
# NOAA CINMS
#
# driver for DSC and VMS project

# load libraries --------------------------------------------
library(tidyverse)
library(janitor)

# -----------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jennifer.selgrath/Documents/research/R_projects/dsc_value_vms/")

# list files in directory
l1<-list.files(path="./data/vms_ca_2019/", pattern = "*.csv")
l1

# try reading in list - reads from wrong directory
# d1<-read_csv(l1[1])

# read in file for 2019 Jan
d1<-read_csv("./data/vms_ca_2019/NOAA23-004-2019_01.csv")%>%
  glimpse()

names(d1)



# clean column names and fix errors in column format ----------------------------
d2<-d1%>%
  select(UTC_TIME:DECLARATIONS,LONGITUDE,LATITUDE)%>%
  mutate(id=as.numeric(paste0(201901,row_number())))%>% # ok but not standard number of spaces
  mutate(declarations=if_else(DECLARATIONS=="N/A",NA,DECLARATIONS))%>%
  mutate(declarations=as.numeric(declarations))%>%
  select(!DECLARATIONS)%>%
  clean_names()%>%
  glimpse()

# df all- not working because of parsing problems
# https://sparkbyexamples.com/r-programming/r-read-multiple-csv-files/
# d_all<-list.files(path="./data/vms_ca_2019/", pattern = "*.csv") %>%
#     map_df(~read_csv(.))%>%
#   glimpse()


# SAVE ##### ----------------------------
write_csv(d2,"./results/vms_ca_2019_01.csv")
