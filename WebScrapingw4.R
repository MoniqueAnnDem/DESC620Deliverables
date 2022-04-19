library(rvest)
library(dplyr)

gasprice <- "https://gasprices.aaa.com/state-gas-price-averages/"
GPage <- read_html(gasprice)

# body_nodes <- html_children(html_node("body", GPage))

body_nodes <- GPage %>% 
  html_node("body") %>% 
  html_children()

# #title-of-a-story
# document.querySelector("title-of-a-story")
# 
# # //*[@id="title-of-a-story"]
# 
# //*[@id="sortable"]/tbody/tr[2]/td[1]/a    #Alabama
# //*[@id="sortable"]/tbody/tr[1]/td[1]/a    #Alaska
# //*[@id="sortable"]/tbody/tr[2]/td[2]      #regular gas price Alabama
# 
# #sortable > tbody > tr:nth-child(2) > td.nth-child(1) > a
# #sortable > tbody > tr:nth-child(2) > td.regular
# #sortable > tbody > tr:nth-child(2) > td.mid_grade
# #sortable > tbody > tr:nth-child(2) > td.premium
# #sortable > tbody > tr:nth-child(2) > td.diesel


df1 <- GPage %>% 
  rvest::html_nodes('body') %>% 
  xml2::xml_find_all('//*[@id="sortable"]/tbody/tr[*]/td[1]/a') %>% 
  rvest::html_text()

df2 <- GPage %>% 
  rvest::html_nodes('body') %>% 
  xml2::xml_find_all('//*[@id="sortable"]/tbody/tr[*]/td[2]') %>% 
  rvest::html_text()

df3 <- GPage %>% 
  rvest::html_nodes('body') %>% 
  xml2::xml_find_all('//*[@id="sortable"]/tbody/tr[*]/td[3]') %>% 
  rvest::html_text()

df4 <- GPage %>% 
  rvest::html_nodes('body') %>% 
  xml2::xml_find_all('//*[@id="sortable"]/tbody/tr[*]/td[4]') %>% 
  rvest::html_text()

df5 <- GPage %>% 
  rvest::html_nodes('body') %>% 
  xml2::xml_find_all('//*[@id="sortable"]/tbody/tr[*]/td[5]') %>% 
  rvest::html_text()

df <- data.frame(df1, df2, df3, df4, df5)

library("tidyverse")

names(df)[1] <- "State"
names(df)[2] <- "Regular Price"
names(df)[3] <- "Mid-Grade Price"
names(df)[4] <- "Premium Price"
names(df)[5] <- "Diesel Price"

knitr::kable(df)

str_remove(df,"[]")