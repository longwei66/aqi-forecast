## ============================================================================
##
##      Functions for AQI & Weather Analysis
##      ************************************
##      
##      1. load_libraries................Load necessary libs
##      2. load_weather_data.............Load weather data from csv
##      3. load_aqi_data                 Load AQI data from csv
##      4. clean_weather_data            Clean weather data
##      5. clean_aqi_data                 Clean AQI data
##      6. merge_aqi_weather             merge AQI with weather data
## ============================================================================

##      [1]
##      Load libraries
## ======================================
load_libraries <- function() {
     library(lubridate)
     library(dplyr)
#     library(grid)
     library(ggplot2)
#     library(ggthemes)
#     library(maps)
#     library(Hmisc)
}


##      [2]
##      Load weather data from csv
## ======================================
load_weather_data <- function(fileName) {
     dF <-
          read.csv(
               fileName, sep = ";", header = TRUE, stringsAsFactors = FALSE, strip.white =
                    TRUE
          )
     ## return the dataframe of severe weather events
     dF
}


##      [3]
##      Load weather data from csv
## ======================================
load_aqi_data <- function(fileName) {
     dF <-
          read.csv(
               fileName, sep = ",", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, skip = 3
          )
     ## return the dataframe of severe weather events
     dF
     names(dF) <- make.names(dF[1,])
     dF <- dF[2:nrow(dF),]
     dF
}



##      [4]
##      Clean weather data
## ======================================
clean_weather_data <- function(dataFrame) {
     
     ## remove NA values
     dataFrame <- dataFrame[!is.na(dataFrame$Local.Time),]
     
     ## create character variable with date time
     dataFrame$date.time <- paste(dataFrame$date_obs, dataFrame$Local.Time)
     
     ## convert the character variable to date format
     dataFrame$date.time <- strptime(dataFrame$date.time, "%Y-%m-%d %I:%M %p")
     

     ## Clean wind direction
     dataFrame$wind.card.direction <- toupper(gsub(pattern = " \\(.*\\)",replacement = "",x = dataFrame$Wind.Direction))
     dataFrame$wind.angle <- toupper(gsub(pattern = ".*\\((.*)\\°)",replacement = "\\1",x = dataFrame$Wind.Direction))

     ## Clean conditions
     dataFrame$Conditions <- toupper(dataFrame$Conditions)
          
     ## rename variables
     names(dataFrame) <- c(
          "date_obs",
          "local.time",
          "temperature",
          "dewpoint",
          "humidity",
          "pressure",
          "visibility",
          "wind.direction.old",
          "wind.speed",
          "wind.gust.speed",
          "precipitation",
          "events",
          "conditions",
          "date.time",
          "wind.direction",
          "wind.angle"
     )
     
     ## Select Variables
     dataFrame <- select(dataFrame,
                         date.time,
                         temperature,
                         dewpoint,
                         humidity,
                         pressure,
                         visibility,
                         wind.direction,
                         wind.angle,
                         wind.speed,
                         wind.gust.speed,
                         events,
                         conditions
     )
     
     
     
     dataFrame
}



##      [5]
##      Clean AQI data
## ======================================
clean_aqi_data <- function(dataFrame) {
     
     ## remove NA values
     dataFrame <- dataFrame[dataFrame$QC.Name == "Valid",]
     
     
     ## select variable we need
     dataFrame <- select(dataFrame, Date..LST., Value)
     
     ## change names
     names(dataFrame) <- c("date.time", "pm2.5")
     
   
     ## convert the character variable to date format
     dataFrame$date.time <- strptime(dataFrame$date.time, "%Y-%m-%d %H:%M")
     
     ## convert pm2.5 data as numeric
     dataFrame$pm2.5 <- as.numeric(dataFrame$pm2.5)
     
     ## remove NA values as negatives pm2.5
     dataFrame <- dataFrame[dataFrame$pm2.5 >= 0,]
     
     dataFrame
}


##      [6]
##      Merge AQI data with weather data
## ======================================
merge_aqi_weather <- function(weatherFrame, aqiFrame) {
     
     dataFrame <- merge(weatherFrame, aqiFrame, by.x = "date.time", by.y = "date.time", all.x = TRUE, all.y = TRUE)
     
     dataFrame
}


##     [7]
##     Clean merged data
## ======================================
clean_aqi_weather_data <- function(dataFrame){
     
     ## remove NA Values
     dataFrame <- dataFrame[!is.na(dataFrame$pm2.5),]
     
     
     ## create year, quarter, month, day, hour variable
     dataFrame$year <- year(dataFrame$date.time)
     dataFrame$quarter <- quarter(dataFrame$date.time)
     dataFrame$month <- month(dataFrame$date.time)
     dataFrame$month <- month(dataFrame$date.time)
     dataFrame$mday <- mday(dataFrame$date.time)
     dataFrame$hour <- hour(dataFrame$date.time)
     
     dataFrame <- select(dataFrame, 
                         date.time,
                         year,
                         quarter,
                         month,
                         mday,
                         hour,
                         temperature,
                         dewpoint,
                         humidity,
                         pressure,
                         visibility,
                         wind.speed,
                         wind.gust.speed,
                         pm2.5,
                         wind.direction,
                         wind.angle,
                         events,
                         conditions
                         ) 

     dataFrame
     }
