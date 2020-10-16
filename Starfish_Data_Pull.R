# install.packages("googlesheets4")
# install.packages("rscorecard")
library(googlesheets4)
library(rscorecard)


# Import field variables
gs4_deauth()
starfish.fields <- read_sheet('https://docs.google.com/spreadsheets/d/1PL5zn6QLU9GSSD8rRreL8r7xaoClrPIrf5qnioZ3eE4/edit?usp=sharing')
head(starfish.fields)
starfish.colnames <- unique(tolower(starfish.fields[['VARIABLE NAME']]))



# Accessing Data
sc_key('lt36uO4r7wWfcijac20x6e6FforftHUitahjuh1A')

starfish.df <- sc_init() %>%  
  sc_filter(region == 5) %>% 
  sc_select_(starfish.colnames) %>%
  sc_get()

for (year in 2015:2018) {
  starfishdf.temp <- sc_init() %>%
    sc_filter(region == 5) %>%
    sc_select_(starfish.colnames) %>%
    sc_year(year) %>%
    sc_get()
  starfish.df <- rbind(starfish.df, starfishdf.temp)
}


# Preview Data
head(starfishdf)


# write to CSV
write.csv(starfishdf,'starfishdf.csv')




