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

encontros = list()

achaEncontros = function(ponto) {

}

for (i in 1:30) {
	points.by.day[[i]] = points.by.day[[i]] %>%
		group_by(user, time) %>%
		summarize(lon = round(mean(lon), 6), lat = round(mean(lat), 6)) %>%
		ungroup()

	dia.atual = points.by.day[[i]]

	print(i)
	print(nrow(dia.atual))
	Sys.sleep(1000)
	
	

	for (x in 1:(nrow(dia.atual)-1)) {
		user1 = dia.atual[x,'user']
		for (y in (x+1):nrow(dia.atual)) {
			user2 = dia.atual[y, 'user']
			print(user1)
			print(user2)
			if (user2 != user1) {
				ponto1 = data.frame(dia.atual[x,c(3:4)])
				ponto2 = data.frame(dia.atual[y,c(3:4)])
				dist = distm(c(ponto1[1,1], ponto1[1,2]), c(ponto2[1,1], ponto2[1,2]) , fun = distHaversine)
				if(dist > 50) {
					nome.encontro = paste(user1, ',', user2, sep='')
					if (is.null(encontros[[nome.encontro]])) {
						encontros[[nome.encontro]] = 1
					}
					else {
						encontros[[nome.encontro]] = encontros[[nome.encontro]] + 1
					}
				}
			}
		}
	}
	write.csv(encontros, paste('~/Documents/mate05/encontrosAteDia', i, '.csv', sep='')
}

write.csv(encontros, '~/Documents/mate05/encontros.csv')
	
