# Jennifer Selgrath
# NOAA CINMS
#
# clean vms data

# load libraries --------------------------------------------
library(tidyverse)
library(janitor)
library(here)

# -----------------------------------------------------------
remove(list=ls())

# set year to process
process_year=2019

# set wd
setwd(paste0("C:/Users/jennifer.selgrath/Documents/research/R_projects/dsc_value_vms/data/vms_ca_",process_year))

# list files in directory for year
l1<-list.files(path="./", pattern = "*.csv")
l1

##Create list of data frame names without the ".csv" part 
# names <-substr(l1,1,18); names  # this also works
filenames <- gsub("\\.csv$","", list.files(pattern="\\.csv$"))

# shorter names
names1 <-substr(l1,12,18)
names2 <-paste0("vms_",names1)

# dataframes to assign
names3 <-substr(l1,17,18)
names4 <-paste0("d",names3)

# for(i in filenames){
#   assign(i, read_csv(paste0(i, ".csv")))
# }# loop

# loop and assign files to separate dataframes
for(i in 1:12){
  assign(paste0("d",i), read_csv(paste0(filenames[i], ".csv")))
}


# check
d1%>%   glimpse()
d7%>%   glimpse()
d7$DECLARATIONS
d12%>%  glimpse()

# functions
f1<-function(x){
  # get rid of problematic columns first ----------------------------
  # note: d7 has problems so does not run if both functions are run together
  x%>%
    select(UTC_TIME:DECLARATIONS,LONGITUDE,LATITUDE)%>%
    mutate(declarations=if_else(DECLARATIONS=="N/A",NA,DECLARATIONS))
}

f2<-function(x){
  # clean column names and fix errors in column format ----------------------------
  x%>%
    mutate(declarations=as.numeric(declarations))%>%
    select(!DECLARATIONS)%>%
    clean_names()%>%
    mutate(
      date=date(utc_time),
      year=year(utc_time),
      month=month(utc_time),
      day=day(utc_time))%>%
    mutate(id=as.numeric(paste0(year,month,day,"_",row_number()))) # ok but not standard number of spaces
}


# process the files 
d1c<-f1(d1)%>%f2()%>%  glimpse()
d2c<-f1(d2)%>%f2()%>% glimpse()
d3c<-f1(d3)%>%f2()%>% glimpse()
d4c<-f1(d4)%>%f2()%>% glimpse()
d5c<-f1(d5)%>%f2()%>% glimpse()
d6c<-f1(d6)%>%f2()%>% glimpse()
d7b<-f1(d7)
d7c<-f2(d7b)%>% glimpse()
d8c<-f1(d8)%>%f2(d8b)%>% glimpse()
d9c<-f1(d9)%>%f2(d9b)%>% glimpse()
d10c<-f1(d10)%>%f2(d10b)%>% glimpse()
d11c<-f1(d11)%>%f2(d11b)%>% glimpse()
d12c<-f1(d12)%>%f2(d12b)%>% glimpse()

#   fix d7
d7b<-d7%>%
select(UTC_TIME:DECLARATIONS,LONGITUDE,LATITUDE)%>%
  # mutate(id=as.numeric(paste0(201901,row_number())))%>% # ok but not standard number of spaces
  # mutate(declarations=if_else(DECLARATIONS=="N/A",NA,DECLARATIONS))%>%
  # mutate(declarations=as.numeric(declarations))%>%
  # select(!DECLARATIONS)%>%
  # clean_names()%>%
  # mutate(
  #   date=date(utc_time),
  #   year=year(utc_time),
  #   month=month(utc_time)
  # )%>%
  glimpse()


# # clean column names and fix errors in column format ----------------------------
# d2<-d1%>%
#   select(UTC_TIME:DECLARATIONS,LONGITUDE,LATITUDE)%>%
#   mutate(id=as.numeric(paste0(201901,row_number())))%>% # ok but not standard number of spaces
#   mutate(declarations=if_else(DECLARATIONS=="N/A",NA,DECLARATIONS))%>%
#   mutate(declarations=as.numeric(declarations))%>%
#   select(!DECLARATIONS)%>%
#   clean_names()%>%
#   glimpse()

# df all- not working because of parsing problems
# https://sparkbyexamples.com/r-programming/r-read-multiple-csv-files/
# d_all<-list.files(path="./data/vms_ca_2019/", pattern = "*.csv") %>%
#     map_df(~read_csv(.))%>%
#   glimpse()


# SAVE ##### ----------------------------
write_csv(d2,"./results/vms_ca_2019_01.csv")
