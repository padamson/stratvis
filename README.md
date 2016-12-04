stratvis - interactive timeline visualization of hierarchical items 
===================================================================

> *Licensed under the MIT license.*

`stratvis` is a Shiny app containing a rich and *fully interactive* 
timeline visualization of
hierarchical items (e.g. strategy, policy, guidance, goals, objectives,
milestones, decisions) for a strategic view of organizational activity. 
This app uses the `timevis` R package, which is based on the 
[vis.js](http://visjs.org/) Timeline module
and the [htmlwidgets](http://www.htmlwidgets.org/) R package.

Requirements
------------

1. items read in from Excel file
1. (TODO) theme with color-coded rows
1. (TODO) data under version control
1. (TODO) vertical line marking current date
1. (TODO) support multiple views (multiple options for grouping items); buttons to change view
1. (TODO) form to input items into timeline, updating database
1. (TODO) button to highlight particular items for presentations
1. (TODO) acronym list auto populates with only those items in view
1. (TODO) print to PDF
1. (TODO) highlight overdue items 
1. (TODO) highlight interactions between items

Prerequisites
-------------

- RStudio
- `timevis` package
- `Shiny` package
- `dplyr` package
- Java JDK
- `xlsx` package

Configuration
-------------

Edit the `dyn.load('/Library/Java/...` command in the `server.R` file to
point to your Java JDK.

Demo
----

To view a live interactive demo of the `stratvis` app, 
open the `server.R` and/or `ui.R` files located in the `inst/example` folder
in RStudio and click the `Run App` button.
