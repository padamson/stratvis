setwd('/srv/shiny-server/stratvis/')

# Simple timeline with 4 items for interactive demo
dataBasic <- data.frame(
  id = 1:4,
  content = c("Item one", "Item two" ,"Ranged item", "Item four"),
  start   = c("2016-01-10", "2016-01-11", "2016-01-20", "2016-02-14"),
  end    = c(NA, NA, "2016-02-04", NA)
)

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%m/%d/%Y") )

dataGroups <- 
  read.csv(file='data/data.csv', stringsAsFactors = FALSE, 
           colClasses = c('numeric',
                          'character',
                          rep('myDate',2),
                          rep('character',5))) %>%
  mutate(content =  
           ifelse(
             is.na(icon),
             label,
             sprintf('<img src="icons/%s.png" width="20" height="20" alt="%s"> %s', 
                     icon, icon, label)
             ) )
groups <- read.csv(file='data/groups.csv')
acronyms <- read.csv(file='data/acronyms.csv')
