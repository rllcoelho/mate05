library(dplyr)
library(geosphere)

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
		summarize(lon = round(mean(lon), 6), lat = round(mean(lat), 6)) %>%
		ungroup()

	for (x in 1:nrow(points.by.day[[i]])-1) {
		for (y in x+1:nrow(points.by.day[[i]])) {
			print(distm(points.by.day[[i]][x,c(3:4)], distm(points.by.day[[i]][y,c(3:4)], fun = distHaversine)))
		}
	}
}

head(points.by.day[[1]]$lat)
	
