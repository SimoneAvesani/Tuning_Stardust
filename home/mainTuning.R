library(rCASC)
library(GenSA)
system("service docker start")
source("/home/stardustPermutation.R")
source("/home/permAnalysisForStardust.R")

setwd("/scratch")
#file="/home/lucastormreig/stardust/filtered_expression_matrix.txt"
#scratch="/home/lucastormreig/stardust/scratch/"
#coordinates="/home/lucastormreig/stardust/spot_coordinates.txt"
#group="sudo"

stardustTuning=function(group,file,scratch,coordinates,sep){
scratchDef=scratch
name=strsplit(basename(file),"\\.")[[1]][1]
format=strsplit(basename(file),"\\.")[[1]][2]
prediction=function(x){
StardustPermutation(group, scratch.folder=scratch, 
  file=file, tissuePosition=coordinates, spaceWeight=x[1], res=x[2], nPerm=10, permAtTime=10, percent=10, separator=sep, 
  logTen=0, pcaDimensions=10, seed=1111, sparse=FALSE, format="NULL")
cluster.path <- paste(data.folder=dirname(file), strsplit(basename(file),"\\.")[[1]][1], sep="/")
cluster <- as.numeric(list.dirs(cluster.path, full.names = FALSE, recursive = FALSE))
print(scratchDef)
print(file)
print(cluster)
print(group)
print('###################################################################################################################')
permAnalysisSeuratFD(group,scratch.folder = scratchDef,file=file, nCluster=cluster,separator=sep,sp=0.8)
result=mean(read.table(paste(cluster.path,"/",cluster,"/",name,"_scoreSum.",format,sep=""),header=FALSE,row.names=1,sep="\t")[,1])
system(paste("rm -r ",cluster.path,sep=""))
return(1-result)

}

lower=c(0.1, 0.5)
upper=c(1, 1.5)
#lower = c(0.1)
#upper = c(1)

out <- GenSA(lower = lower, upper = upper, fn = prediction,control = list(max.call = 100))

sink("results.txt")
print(out)
sink()

}

library("argparser")
 
p <- arg_parser("permutation")
p <- add_argument(p, "file", help="matrix count name")
p <- add_argument(p, "coordinates", help="matrix separator ")
p <- add_argument(p, "sep", help="matrix separator ")
p <- add_argument(p, "scratch", help="matrix separator ")



argv <- parse_args(p)

if(argv$sep=="tab"){sep="\t"}else{sep=argv$sep}
stardustTuning(group="docker",file=paste("/scratch/",argv$file,sep=""),scratch=argv$scratch,coordinates=paste("/scratch/",argv$coordinates,sep=""),sep=sep)
