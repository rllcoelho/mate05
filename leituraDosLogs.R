#definir o caminho para dentro da pasta do dataset
setwd("~/Downloads/Geolife Trajectories 1.3/Geolife Trajectories 1.3/Data")
print("Diretório de trabalho: '~/Downloads/Geolife Trajectories 1.3/Geolife Trajectories 1.3/Data'")

dirs = list.dirs()
split_dirs  = strsplit(dirs, '/')
split_tr_dirs = split_dirs[which(lengths(split_dirs) == 3)]
split_tr_dirs = split_tr_dirs[-c(1:25)]
print(split_tr_dirs)

points = data.frame(user = NA, trajectory = NA, lat = NA, lon = NA, date.days = NA, date.str = NA, time = NA)

for (dir in split_tr_dirs) {
  setwd(paste(dir[2],'/',dir[3], sep = ''))
  print("Diretório de trabalho: ")
  print(getwd())
  trajectories = list.files()
  for (fil in trajectories) {
    #traj = strsplit(fil, '.')[1]
    print("Trajetória: ")
    print(fil)
    con  <- file(fil, open = "r")
    cont = 1
    trajPoints = data.frame(user = NA , trajectory = NA, lat = NA, lon = NA, date.days = NA, date.str = NA, time = NA)
    while (length(oneLine <- readLines(con, n = 1)) > 0) {
      myLine <- unlist((strsplit(oneLine, ",")))
      if (myLine[5] >= 39965 & myLine[5] < 39994 & cont > 6) {
        point = as.data.frame(cbind(dir[2], fil, myLine[1], myLine[2], myLine[5], myLine[6], myLine[7]))
        names(point) = c('user', 'trajectory', 'lat', 'lon', 'date.days', 'date.str', 'time')
        trajPoints = rbind(trajPoints, point)
      }
      if (cont < 7) {
        cont = cont + 1
      }
    } 
    close(con)
    if (!nrow(trajPoints) == 1 & !all(is.na(trajPoints))) {
      points = rbind(points, trajPoints)
    }
    
  }
  setwd('../..')
}

write.csv(points, '~/Documents/mate05/pontosDo25emDiante.csv')

