# very slow, will optimize soon
options(scipen=999)
raw <- strsplit(gsub(":|,"," ",commandArgs(trailingOnly=TRUE)[1]),split = "=")
pdata=c()
intervalstart=c()
intervalend=c()
for(i in raw[[1]][-1]){
  pdata <- append(pdata, strtoi(sapply(strsplit(i, " "), head, 1)))
}
minx <- 0xffffff
miny <- 0xffffff
maxx <- 0
maxy <- 0
for(i in seq(1, length(pdata), 2)){
    minx = min(pdata[i], minx)
    maxx = max(pdata[i], maxx)
    miny = min(pdata[i+1], miny)
    maxy = max(pdata[i+1], maxy)
}

crunchthenumbers <- function(pt1x, pt1y, pt2x, pt2y, y) {
    distance <- abs(pt1x-pt2x)+abs(pt1y-pt2y)
    ydist <- abs(pt1y-y)
    if(ydist < distance){
        intervalstart <<- append(intervalstart, pt1x-(distance - ydist))
        intervalend <<- append(intervalend, pt1x+ (distance - ydist))
    }
    return (ydist)

}
for(y in 0:4000000){
    intervalstart <<- c()
    intervalend <<- c()
    for(j in seq(1, length(pdata), 4)){
        crunchthenumbers(pdata[j], pdata[j+1], pdata[j+2], pdata[j+3], y)
    }
    if(length(intervalstart) < 2){
        mergedstart <-(intervalstart)
        mergedend <-(intervalend)
    } else {
    intervalend <- intervalend[order(intervalstart)]
intervalstart <-intervalstart[order(intervalstart)]
mergedstart <- c()
mergedend <- c()
previous <- c(intervalstart[1], intervalend[1])
for (q in 2:length(intervalstart)) {
if (previous[2]  >= intervalstart[q]) {
      previous <- c(previous[1], max(previous[2], intervalend[q]))
    } else {
      mergedstart <- append(mergedstart,previous[1])
      mergedend <-append(mergedend, previous[2])
     previous <- c(intervalstart[q], intervalend[q])
    }
 }

      mergedstart <- append(mergedstart,previous[1])
      mergedend <-append(mergedend, previous[2])
}
      if(length(mergedend) > 1){
    for(i in 1:(length(mergedend) -1)){
        if(mergedend[i] == mergedstart[i+1]-2){
            print(mergedend[i]*4000000+y)
        }
    }
    
}
}

