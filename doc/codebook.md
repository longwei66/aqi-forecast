---
title: "AQI Shanghai"
author: "Barthelemy Longueville"
date: "August 3, 2015"
output: html_document
---


Variable | Class | Comments | Values
---------|-------|----------|------
date.time| POSIXlt | date / time | from 2013-01-02 00:30:00 CST, to 2015-04-11 23:30:00 CST
year | num | year | 2013 to 2015
quarter | num | quarter number | 1 to 4
month | num | month | 1 to 12
mday | int | day of the month | 1 to 31
hour | int | hour of the day | 0 to 23 
temperature | int  | temperature in Celcius degree | -4 to 41
dewpoint |  int | dewpoint temperature | -17 to 27
humidity | int | humidity % | 13% to 100%
pressure | num | pressure in hPa | 994.2 to 1040
visibility | num | visibility distance in km | NA, 0 to 10 km
wind.speed | num | speed of the wind in km/h (to be confirmed) | NA, 3.5 to 61.2
wind.gust.speed| num   | gust speed of the wind in km/h (to be confirmed) | NA, 25.3 to 82.9
pm2.5| numeric   | pm2.5 value in micro g per m3 | 0 to 651
wind.direction | chr  | wind direction - cardinal | "ESE"      "SE"       "VARIABLE" "NORTH"    "CALM"     "ENE"     "EAST"     "SSE"      "NNW"      "NW"       "NNE"      "NE"      "WNW"      "SOUTH"    "SW"       "WEST"     "WSW"      "SSW"    
wind.angle | chr  | direction of the wind in degree from north | 10 to 360 and CALM, VARIABLE
events | chr | meteorogical event | ""                  "Rain"              "Rain-Thunderstorm"  "Thunderstorm"      "Snow"              "Fog" "Fog-Rain"          "Rain-Snow"         "Snow-Thunderstorm"
conditions | chr |   weather condition | "CLEAR"                        ""  "MIST"                         "SCATTERED CLOUDS"             "MOSTLY CLOUDY"                "PARTLY CLOUDY"                "LIGHT RAIN SHOWERS"           "LIGHT RAIN"                   "RAIN SHOWERS"                 "LIGHT THUNDERSTORMS AND RAIN" "HEAVY THUNDERSTORMS AND RAIN" "OVERCAST"                     "HEAVY RAIN"                   "RAIN"                         "THUNDERSTORMS AND RAIN"       "HAZE"                         "THUNDERSTORM"                 "LIGHT SNOW"                   "LIGHT ICE PELLETS"            "FOG"                          "HEAVY RAIN SHOWERS"           "LIGHT THUNDERSTORMS AND SNOW" "LIGHT SNOW SHOWERS"           "LIGHT FREEZING FOG"       