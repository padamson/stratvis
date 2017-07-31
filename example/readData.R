# Simple timeline with 4 items for interactive demo
dataBasic <- data.frame(
  id = 1:4,
  content = c("Item one", "Item two" ,"Ranged item", "Item four"),
  start   = c("2016-01-10", "2016-01-11", "2016-01-20", "2016-02-14"),
  end    = c(NA, NA, "2016-02-04", NA)
)

datafile <- paste0(appname, '/data.csv')
groupfile <- paste0(appname, '/groups.csv')
acrofile <- paste0(appname, '/acronyms.csv')
objfile <- paste0(appname,'/objectives.csv')
subobjfile <- paste0(appname, '/subobjectives.csv')

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%m/%d/%Y") )

dataGroups <- 
  read.csv(file=datafile, stringsAsFactors = FALSE, 
           colClasses = c('numeric',
                          'character',
                          rep('myDate',2),
                          rep('character',5))) %>%
  mutate(content =  
           ifelse(
             is.na(icon),
             content,
             sprintf('<img src="icons/%s.png" width="20" height="20" alt="%s"> %s', 
                     icon, icon, content)
             ) )

groups <- read.csv(file=groupfile)
acronyms <- read.csv(file=acrofile)
#objectives <- read.csv(file=objfile)
#subobjectives <- read.csv(file=subobjfile)