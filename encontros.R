library(dplyr)

print("Lendo csv dos pontos.")
points = read.csv("~/Documents/mate05/points.csv")

points.by.day = list()
date = ""

for (i in 1:30) {
	if(i < 10) {
		date = paste("2009-06-0", as.character(i), sep = "")
	}
	else {
		date = paste("2009-06-", as.character(i), sep = "")
	}
	points.by.day[[date]] = subset(points, date.str == date)
}

#points.by.day.min = list()

for (i in 1:30) {
	points.by.day[[i]]$time = as.character(sapply(as.character(points.by.day[[i]]$time), substr, 1, 5))
}

for (i in 1:30) {
	points.by.day[[i]] = points.by.day[[i]] %>%
		group_by(user, time) %>%
		summarize(lon = round(mean(lon), 5), lat = round(mean(lat), 5)) %>%
		ungroup()
}



head(points.by.day[[1]]$lat)
	
