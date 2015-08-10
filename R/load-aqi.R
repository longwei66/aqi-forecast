## ============================================================================
##
##      Scripts to load AQI & Weather data
##      ************************************
##      
##      1. Load necessary libs
##      2. Load weather data from csv
##      3. Load AQI data from CSV
##      4. Clean weather data
##      5. Clean AQI data
## ============================================================================


##      [0]
##      Configure filenames for data sources
## ======================================
weatherDataFile <- "data/weather/2013-2014-2015.csv"

aqiWeatherFile2013 <- "data/aqi/Shanghai_2013_HourlyPM25_created20140423.csv"
aqiWeatherFile2014 <- "data/aqi/Shanghai_2014_HourlyPM25_created20150203.csv"
aqiWeatherFile2015 <- "data/aqi/Shanghai_2015_HourlyPM25_created20150803.csv"


##      [1]
##      Load libraries
## ======================================
source("R/aqi-functions.R")
load_libraries()

##      [2]
##      Load weather data from csv
## ======================================
weather <- load_weather_data(weatherDataFile)

##      [3]
##      Load aqi data from csv
## ======================================
aqi2013 <- load_aqi_data(aqiWeatherFile2013)
aqi2014 <- load_aqi_data(aqiWeatherFile2014)
aqi2015 <- load_aqi_data(aqiWeatherFile2015)

aqi <- rbind(aqi2013,aqi2014,aqi2015)
rm(aqi2015)
rm(aqi2014)
rm(aqi2013)


##      [4]
##      Clean weather data
## ======================================
weather <- clean_weather_data(weather)


##      [5]
##      Clean AQI data
## ======================================
aqi <- clean_aqi_data(aqi)

##      [6]
##      Merge weather and AQI data
## ======================================
weatherAQI <- merge_aqi_weather(weatherFrame = weather, aqiFrame = aqi)
rm(weather)
rm(aqi)

##      [7]
##      Clean merged data
## ======================================
weatherAQI <- clean_aqi_weather_data(weatherAQI)


