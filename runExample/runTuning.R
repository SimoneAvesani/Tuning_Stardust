library("argparser")
library("rCASC")

p <- arg_parser("permutation")
p <- add_argument(p, "folder", help="dataset name")
argv <- parse_args(p)

name.dir = argv$folder

path=getwd()
source(paste(path,"tuneStardust.R",sep="/"))

path = paste(path, "Dataset", sep = "/")
file=paste(paste(path, name.dir, sep = "/"),"filtered_expression_matrix.txt",sep="/")
spot_coordinates=paste(paste(path, name.dir, sep = "/"),"spot_coordinates.txt",sep="/")

print(file)
scratch=paste(paste(path, name.dir, sep = "/"),"scratch",sep="/")
dir.create(scratch)
group="sudo"
separator="\t"

tuneStardust(group=group, scratch.folder=scratch, file=file,spot_coordinates=spot_coordinates,separator=separator)
 
