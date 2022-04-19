##FP1 - Scraping stock/ticker symbols and names of companies from assigned page##

install.packages('rvest')
install.packages('dplyr')

library(rvest)
library(dplyr)

motley <- "https://www.fool.com/investing/general/2013/12/21/9-top-stocks-to-buy-in-2014.aspx"
find <- read_html(motley) 

ticker = find %>% 
  html_nodes("span a") %>% 
  html_text()

df_ticker = data.frame(ticker)

install.packages('tidyverse')
library(tidyverse)
knitr::kable(df_ticker)

##FP2 - Scraping financial data of these ticker symbols from Yahoo finance##

tickersym <- c("EBAY", "KMI", "LBTYA", "LNN", "MNTA", "OLED", "PHM", "TSLA")
df_finsummary = data.frame()

for (tickersym in c("EBAY", "KMI", "LBTYA", "LNN", "MNTA", "OLED", "PHM", "TSLA")) {
  yahoofinance = paste0("https://finance.yahoo.com/quote/",tickersym,"?p=", tickersym,"&.tsrc=fin-srch")
  search = read_html(yahoofinance) 

  finsummary = search %>% 
  html_nodes("tr td") %>% 
  html_text()

  df_finsummary = rbind(df_finsummary, data.frame(finsummary))
}

EBAY <- head(df_finsummary, 32)
#I need to find a way to split all 8 of these dataframes, because they're all combined, one after the other.

oneyrte <- data.frame(ticker=rep(c("EBAY", "KMI", "LBTYA", "LNN", "MNTA")),
                      oneyrtargetestimate=rep(c("978.19", "66.49", "19.68", "39.30", "180.00")))
                             
install.packages(ggplot2)
library(ggplot2)

oneyrte %>% 
  ggplot(aes(x = ticker, y=oneyrtargetestimate, )) +
  geom_col()
