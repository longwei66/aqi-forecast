library(XML)

Sys.setlocale(category = "LC_ALL", locale = "US_us")
day <- "2015-04-12"
#day <- "2013-08-31"

date <- strptime(day,"%Y-%m-%d")
date_obs <- date

weather_matrix <- matrix(nrow = 1, ncol = 12)
weather <- data.frame(weather_matrix)
names(weather) =  c("Local.Time", "Temperature", "Dewpoint", "Humidity", "Barometer", "Visibility", "Wind.Direction", "Wind.Speed", "Gust.Speed", "Precipitation", "Events", "Conditions")
weather <- cbind(date_obs, weather)



## LOOP 100 days
for(i in 1:1196) {  
        ## Create data frame with 
        ## Hourly data recorded from ZSSS, located 0 kilometers away from Shanghai, China
        day <- as.character(date)
        fileUrl <- paste("http://www.weatherbase.com/weather/weatherhourly.php3?s=76385&cityname=Shanghai-Shanghai-China&date=", day, "&units=metric", sep = "")
        dochtml <- htmlTreeParse(fileUrl,useInternal=TRUE)
        data_wt <- xpathSApply(dochtml,"//tr[@class='bb']//td",xmlValue)
        
        if(!is.null(data_wt)){
                ## index 
                if(sum(max((data_wt == "Growing Degree Days"))) == 0 & sum(max((data_wt == "Heating Degree Days"))) == 0){ 
                index <- 1} else {
                index <- max(max((data_wt == "Growing Degree Days")*1:length(data_wt))+2,max((data_wt == "Heating Degree Days")*1:length(data_wt))+2)}
                
                ## remove the top part of the page data
                raw_wt <- data_wt[index:length(data_wt)]
                
                if (length(raw_wt) != 0){
                        ## build the matrix from the list
                        weather_daily_matrix <- t(matrix(raw_wt, nrow = 12, ncol = (length(raw_wt)/12)))
                        weather_daily <- data.frame(weather_daily_matrix)
                        
                        
                        date_obs <- c(rep(date, nrow(weather_daily)))
                        #date_obs <- strptime(date_obs,"%Y-%m-%d")
                        weather_day <- cbind(date_obs, weather_daily)
                        names(weather_day) =  c("date_obs","Local.Time", "Temperature", "Dewpoint", "Humidity", "Barometer", "Visibility", "Wind.Direction", "Wind.Speed", "Gust.Speed", "Precipitation", "Events", "Conditions")
                        
                        ## Clean Data
                        weather_day$Temperature <- as.numeric(substr(weather_day$Temperature,1, nchar(as.character(weather_day$Temperature))-4))
                        weather_day$Dewpoint <- as.numeric(substr(weather_day$Dewpoint,1, nchar(as.character(weather_day$Dewpoint))-4))
                        weather_day$Humidity <- as.numeric(substr(weather_day$Humidity,1, nchar(as.character(weather_day$Humidity))-2))
                        weather_day$Barometer <- as.numeric(substr(weather_day$Barometer,1, nchar(as.character(weather_day$Barometer))-4))
                        weather_day$Visibility <- as.numeric(substr(weather_day$Visibility,1, nchar(as.character(weather_day$Visibility))-3))
                        weather_day$Wind.Speed <- as.numeric(substr(weather_day$Wind.Speed,1, nchar(as.character(weather_day$Wind.Speed))-5))
                        weather_day$Gust.Speed <- as.numeric(substr(weather_day$Gust.Speed,1, nchar(as.character(weather_day$Gust.Speed))-5))
                        
                        
                        weather <- rbind(weather, weather_day)
                }}
        date <- date-60*24*60
        message(date)
}
