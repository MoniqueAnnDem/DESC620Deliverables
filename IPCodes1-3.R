##IP1 - Scraping all links from Navigation Menu##

install.packages('rvest')
install.packages('dplyr')

library(rvest)
library(dplyr)
        
book <- "https://r-graphics.org"
scrape <- read_html(book) 

nav_links = scrape %>% 
  html_nodes("li a") %>% 
  html_attr("href") %>% 
  paste("https://r-graphics.org/", ., sep="")

nav_links

##IP2 - Scraping content from a single page of book##

singlepage <- "https://r-graphics.org/installing-a-package.html"
pagescrape <- read_html(singlepage) 

apage = pagescrape %>% 
  html_nodes("body") %>% 
  html_text()

apage


##IP3 - Scraping content from all pages of book##

allpagelinks <- nav_links
fullscrape = data.frame()

for (fullscrapecontent in seq(from = 1, to = 766, by = 1)) {
  fullscrape <- read_html(fullscrapecontent) 
  pages = fullscrape %>% 
    html_nodes("body") %>% 
    html_text()
}
  
