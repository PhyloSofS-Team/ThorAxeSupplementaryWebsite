# ThorAxe Supplementary Material Website

To use it locally, you need a Julia version greater than 1.3. Then, you 
need to clone this git repo and do:

```bash
git clone https://github.com/PhyloSofS-Team/ThorAxeSupplementaryWebsite.git

cd ThorAxeSupplementaryWebsite

julia -e "using Pkg; Pkg.activate(\".\"); Pkg.instantiate(); Pkg.precompile();"
```

**NOTE:** If you want to add your own *ThorAxe* results to the local 
webpage, you need to copy the folder (gene) containing the `thoraxe` 
subfolder into `public/data/thoraxe` before running the server.

Then you can run the server by running the following command in the root 
folder of the repo:

```bash
GENIE_ENV=prod nohup bin/server &
```

Then you can see the webpage at [localhost:8000/ThorAxe](http://localhost:8000/ThorAxe).

## Singularity

To create a singularity image, you need to clone the repo as before and 
build the image using the definition file there:

```bash
git clone https://github.com/PhyloSofS-Team/ThorAxeSupplementaryWebsite.git

cd ThorAxeSupplementaryWebsite

sudo singularity build thoraxe-supplmat.sif Singularity
```

Then you can simply run it:

```bash
singularity run thoraxe-supplmat.sif
```

Or to create an instance to run the server:

```bash
singularity instance start thoraxe-supplmat.sif thoraxe-supplmat

singularity run instance://thoraxe-supplmat
```