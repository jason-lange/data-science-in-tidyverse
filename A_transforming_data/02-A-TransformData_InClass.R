#'---
#'title: "Transforming Data, Part A"
#'author:
#'date: "NICAR 2019"
#'output: github_document
#'---


#' Load the packages we'll need
library(tidyverse)
library(lubridate)
  
  
#' Toy dataset to use, created manually with a tibble  

pollution <- tibble(city=c("New York", "New York", "London", "London", "Beijing", "Beijing"),
               size=c("large", "small", "large", "small", "large", "small"),
               amount=c(23, 14, 22, 16, 121, 56))

#'*What are "tibbles"...?*    
#'  
#'They're dataframes, with some additional tidyverse-infused features. Returns more readable output in the console.
#' 
 
#'Let's see the data we just created, you'll see how a tibble view differs in the console

pollution

#'Since there are only a handful of rows, a bit harder to see - let's try the built-in "iris" data



#'That was a lot of output! Can limit rows with head()



#'But let's see how tibbles differ in their output




#'### FILTERING AND SORTING 

#'The tidyverse's *dplyr* provides intuitive functions for exploring and analyzing dataframes  
#'  

#'Let's go back to our little pollution dataset



#'Show me only the ones with a "large" size



#'Show me only the ones where the city is London


#'For numeric values, you can use boolean operators 


#'Now, let's try filtering based on two different variables




#'This can still get a little confusing once you wind up with larger amounts of steps to string together.  
#'  
#'Enter a glorious feature of the tidyverse: **the PIPE** `%>%`  
#'   
#'The "pipe" (shortcut is CTRL/CMD + SHIFT + M) allows you to chain together commands  
#'  
#'Watch this, and see how much easier it becomes for a human to think through (and read later!)



#'Voila! So what just happened there?  
#'  
#'Think of %>% as the equivalent of "and then do this"...  
##'It takes the result and then applies something new to it, in sequential order  
#'  

#'This becomes easy to see when we add new functions - so let's talk about sorting with arrange()



#'To sort by highest value, add desc()



#'Now let's go back to our filtering and add arranging, too

)

#'Add another filter criteria



#'This can be formatted this way as well, if it's even easier for you to read  
#'Let's add another filter criteria



#'Think about what we just did here.  
#'  
#'You can read the code and it intuitively makes sense. 
#'Each step sequentially listed and executes in order.  
#'  
#'  

#' One more thing - what if we don't want all the columns? Just some.  
#' This happens all the time.
#' 
#' Dplyr makes this easy using **select()`**
#'   


#' You can pull out just certain variables as well  
#' This results in the same thing as above




#'### PRESIDENTIAL CANDIDATE TRIPS  
#'  
#' Let's take a look at some more intersting data now and try out some of these methods  
#'   
#' Load in data of prez candidate campaign trips between midterms and end of Jan

events <- readRDS("events_saved.rds")

#' Let's take a look at what we've got

events

#' Even easier to see a dataset with `View()`  
#' Click on its name under the environment tab in upper right, or:



#' Can also pipe the results of a chain if we wanted to




#' Can you think of when we might find ourselves wanting to do that? (hint: think big)  
#'   
#' Now let's try out some of our filtering and arranging techniques.  
#'   
#' Show all events in Iowa:



#' Has Kamala Harris been to Iowa?



#' What about another candidate



#' Let's talk about **date-specific** stuff.    
#' If I have a properly formatted date in a dataframe, can I sort by it? *Yes.*



#' What if I want to pull out only certain ranges of dates? *Several approaches.*   

#' Specifiying a specific date using as.Date()



#' Take advantage of the LUBRIDATE package - a tidyverse package specifically for dates  
#' *Note: lubridate needs to be called separately at the top with library(lubridate) - it doesn't yet load with library(tidyverse)*    
#'   
  
#' Now watch what we can do:



#' Just events in January 2019



#' Events earlier than Dec 2018



#' Also allows us to do things like, "I only want to see events the *first week of every month*" 



#' Who's visiting Iowa the first week of a month? 



#'  
#' This is helpful but let's say you're doing this all the time.  
#' It may be easier to create new columns to hold these values.
#'     
#' Brings us to another key function of dpylr/tidyverse - **MUTATE**
#'   
#'  


#'### ADDING COLUMNS WITH MUTATE  
#'   
#' To add a column, you give it a name, then a single equal sign (=), then define what's in it.  
#' Test example:

events %>% 
  mutate(mycolumn = "hi there")


#' Now let's try adding our date-related columns.  First we'll try year.



#' We can add multiple columns as part of one mutate call. Let's do year, month and day in one swoop.



#' This is a good time to remind ourselves that if we want to save our new columns, need to *create new object* or *overwrite*



#' Now we can use our new columns to filter



#' Show me just Kamala's events in January



#'  
#'  

#'### GROUPING AND AGGREGATING  
#'  
#'  
#' Able to aggregate our campaign trips would be helpful at this point, right?  
#' Let's get into how to do it using the tidyverse and dplyr's `group_by()` and `summarise()` 
#'   
#' Have you all grouped before in other languages? In base R itself?  Let's discuss.  
#'   
#' Grouping to see how many trips each candidate have been on in our data  
#' Getting used to `n()`




#' now let's add arrange to see who has the most trips

# events %>% 
#   group_by(cand_lastname) %>% 
#   summarise(n()) %>% 
#   arrange(n)

#' hmm - what's going on here? Look closely and see what the generated count column is called

# events %>% 
#   group_by(cand_lastname) %>% 
#   summarise(n()) %>% 
#   arrange("n()")

#' that doesn't work either.  What about this.

events %>% 
  group_by(cand_lastname) %>% 
  summarise(n()) %>% 
  arrange()

#' Ah - so that sort of works? But not really, how do we get desc


# events %>% 
#   group_by(cand_lastname) %>% 
#   summarise(n()) %>% 
#   arrange(desc)

#' Oy - this is getting frustrating. How do we solve?  
#' By doing this: giving the new column a **name of our own**.  
#' Check it out:



#' Now we can do:



#' Bingo  
#' We can call the new columnn anything we want. "n" is a common thing for counts,  
#' but can be anything



#' Now for the magic  
#' Because this counting is such a common operation, and because the `n()` becomes a pain to deal with...  
#' ...there is a special shortcut - `count()` - that we can use that collapses everything into one function





#' top states visited



#' top months



#' top single day for most trips



#' we can also group by **more than one** variable  
#' which candidates have gone to which states?



#' what about the most frequent types of events



#' here we're seeing some potentially dirty data that needs cleaning.  
#' the event types seem to be inconsistently entered.  
#' how might we standardize them? let's take a look.  
#'   
#' A function that returns a vector the same length as the input is called **vectorized**.  
#' * `ifelse()`  
#'   
#' let's see `ifelse()` in action

events %>% 
  mutate(new_type = ifelse(event_type == "event speech", "TEST", event_type)) 

#' ok now let's clean a few columns for real

events %>% 
  mutate(new_type = ifelse(event_type == "campaign event", "event", event_type),
         new_type = ifelse(event_type == "campaign events", "event", new_type),
         new_type = ifelse(event_type == "event speech", "speech", new_type)
         ) 

#' this can start to get a little tedious though. enter `case_when`

events %>%
  mutate(new_type = case_when(
            event_type == "campaign event" ~ "event",
            event_type == "campaign events" ~ "event",
            event_type == "event speech" ~ "speech",
            event_type == TRUE ~ "other"
      ))

#' Of course, you may be asking: wouldn't it be nice if we could standardize...  
#' ...based on certain keywords or patterns?  Instead of spelling out every variation.  
#'   
#' The answer is yes. Thanks to "string functions"...!  
#'   
#' We'll show a quick example of what that looks like, and then start from the beginning in the next module.  

events %>%
  mutate(new_type = case_when(
    str_detect(event_type, "event") ~ "event")
  )


#' We'll take a closer look at string functions now using the stringr package.  
#'   
#' First, are there questions? Let's discuss.






