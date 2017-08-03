# Simple timeline with 4 items for interactive demo
dataBasic <- data.frame(
  id = 1:4,
  content = c("Item one", "Item two" ,"Ranged item", "Item four"),
  start   = c("2016-01-10", "2016-01-11", "2016-01-20", "2016-02-14"),
  end    = c(NA, NA, "2016-02-04", NA)
)

eventfile <- paste0(appname, '/events.csv')
groupfile <- paste0(appname, '/groups.csv')
acrofile <- paste0(appname, '/acronyms.csv')
objfile <- paste0(appname,'/objectives.csv')
subobjfile <- paste0(appname, '/subobjectives.csv')
goalfile <- paste0(appname, '/goals.csv')

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%m/%d/%Y") )

dataGroups <- 
  read.csv(file=eventfile, stringsAsFactors = FALSE, 
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

goals <- read.csv(file=goalfile, stringsAsFactors = FALSE,
                  colClasses = c('numeric',
                                 'character',
                                 rep('numeric',2)))

goalContent <- NULL
goalContent$event <- intersect(unique(goals$event),goalList)
goalContentText <- NULL
for(event in goalContent$event) {
  goalContentVector <- which(goals$event %in% event)
  goalContentText <- append(goalContentText,
                            paste0("<ul><li>", 
                                   paste(goals$content[goalContentVector], collapse = '</li><li>'),
                                   "</li></ul>"))
}
goalContent$text <- goalContentText
rm(goalContentText, goalContentVector)

for(id in 1:length(goalContent$event)){
  dataGroupsID <- which(dataGroups$id == goalContent$event[id])
  dataGroups$content[dataGroupsID] <- paste0(dataGroups$content[dataGroupsID],goalContent$text[id]) 
}
rm(goalContent)

groups <- read.csv(file=groupfile)
acronyms <- read.csv(file=acrofile)
#objectives <- read.csv(file=objfile)
#subobjectives <- read.csv(file=subobjfile)
