#definir o caminho para dentro da pasta do dataset
setwd("~/Downloads/Geolife Trajectories 1.3/Data")

dirs = list.dirs()
split_dirs  = strsplit(dirs, '/')
split_tr_dirs = split_dirs[which(lengths(split_dirs) == 3)]

points = data.frame(user = NA, trajectory = NA, lat = NA, lon = NA, alt=NA, date.days = NA, date.str = NA, time = NA)

for (dir in split_tr_dirs) {
  setwd(paste(dir[2],'/',dir[3], sep = ''))
  trajectories = list.files()
  for (file in trajectories) {
    traj = read.csv(file, header=FALSE)
    traj = traj[-c(1:6),-8]
    traj_points = data.frame(user = rep(dir[2], nrow(traj)),
                             trajectory = rep(file, nrow(traj)),
                             traj[1],
                             traj[2],
                             traj[4],
                             traj[5],
                             traj[6],
                             traj[7])
    names(traj_points) = c('user', 'trajectory', 'lat', 'lon', 'alt', 'date.days', 'date.str', 'time')
    points = rbind(points, traj_points)
  }
  setwd('../..')
}

#-------------------------------------------------------------------------------------

nodes = list()

for (i in 1:9) {
  file_list <- list.files(paste("~/Geolife Trajectories 1.3/Data/00", i, "/Trajectory", sep=""), full=T)
  file_con <- lapply(file_list, function(x){
    return(read.table(x, head=F, quote = "\"", skip = 6, sep = ","))
  })
  file_con_df <- do.call(rbind, file_con)
  nodes[[i]] <- file_con_df
}

for (i in 10:99) {
  file_list <- list.files(paste("~/Geolife Trajectories 1.3/Data/0", i, "/Trajectory", sep=""), full=T)
  file_con <- lapply(file_list, function(x){
    return(read.table(x, head=F, quote = "\"", skip = 6, sep = ","))
  })
  file_con_df <- do.call(rbind, file_con)
  nodes[[i]] <- file_con_df
}

for (i in 100:181) {
  file_list <- list.files(paste("~/Geolife Trajectories 1.3/Data/", i, "/Trajectory", sep=""), full=T)
  file_con <- lapply(file_list, function(x){
    return(read.table(x, head=F, quote = "\"", skip = 6, sep = ","))
  })
  file_con_df <- do.call(rbind, file_con)
  nodes[[i]] <- file_con_df
}

file_list <- list.files(paste("~/Geolife Trajectories 1.3/Data/000/Trajectory", sep=""), full=T)
file_con <- lapply(file_list, function(x){
  return(read.table(x, head=F, quote = "\"", skip = 6, sep = ","))
})
file_con_df <- do.call(rbind, file_con)
nodes[[182]] <- file_con_df
