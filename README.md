# Tuning_Stardust

Tuning tool to estimate Stardust parameters (space weight, resolution) allowing to achieve the highest average cell stability score.
The docker image will be available on the Docker Hub soon.

## Installation
No installation is required to run the tuning tool. The only prerequisite is to have installed docker and git on your local machine.
To prepare your enviromnent follow these steps:

```
# clone the repository
git clone https://github.com/SimoneAvesani/Tuning_Stardust.git

# move inside the directory 
cd /Tuning_Stardust

# build the docker image
bash run_container.sh

```
## Run tuning example

Once that the docker image is built, run the following commands:

```
# move inside example directory 
cd runExample/

# run tuning tool specifyng the dataset directory name contained inside /runExample/Dataset
Rscript runTuning.R MK 

```
## Add datasets
To add a dataset create a new directory /runExample/Dataset/NameNewDataset and put there your data including the expression matrix and the spot coordinates file.
After that:

```
# build docker image
bash run_container.sh

# change directory 
cd runExample

# run tuning
Rscript runTuning.R NameNewDataset
```

## Output

Once that the tuning is ended, estimated parameters are sotred in file called Results.txt stored inside /runExample/Dataset/NameDataset.
To have more details about the output format, you can consult the help manual of GenS() function: https://cran.r-project.org/web/packages/GenSA/GenSA.pdf
The output parameters are stored in the following order: 

1) space weight 
2) clustering resolution
