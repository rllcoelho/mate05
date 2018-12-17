print("Lendo csv dos pontos.")
points = read.csv("~/Documents/mate05/points.csv")
print("csv lido")

points.by.day = list()

date = ""

for (i in 1:30) {
	print(paste("Dia", i))
	if(i < 10) {
		date = paste("2009-06-0", as.character(i), sep = "")
	}
	else {
		date = paste("2009-06-", as.character(i), sep = "")
	}
	print(date)
	print(subset(points, data.days == date))
	points.by.day[[date]] = subset(points, date.days == date)
}

print(points.by.day$'2009-06-04')


	
