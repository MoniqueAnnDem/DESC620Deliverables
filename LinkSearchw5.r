
install.packages('readr')
library('readr')

rawInput <- readLines("list.txt")
rawInput[5]

rawInput1 <- paste(rawInput, collapse = " \n ")


rawInputByLine <- readLines("list.txt", n = 1)

df <- data.frame(rawInput)
df$address <- ""
df$name <- ""

df$addr <- str_split_fixed(df$rawInput, " \\| ", 2)[1]
df$nm <- str_split_fixed(df$rawInput, " \\| ", 2)[2]

test <- df$rawInput[4]
test1 <- str_locate(test, " \\| ")
str(test1)

df1 <- str_split_fixed(test, " \\| ", 2)[1]
df1
