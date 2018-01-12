#!/bin/bash

# unload potentially conflicting anaconda instances
{ # try
    module unload python-anaconda2 &&
    module unload python-anaconda3
} || { # catch
    echo 'module unloading failed: maybe module does not exist'
}


# install miniconda for local independent package management
wget http://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
mkdir dependencies
chmod 775 miniconda.sh
chmod 775 dependencies
bash miniconda.sh -b -p ./dependencies/miniconda
rm miniconda.sh

# activate python2 anaconda environment and install checkm
source ./dependencies/miniconda/bin/activate
conda install -y -c bioconda checkm-genome=1.0.7

# pyflow also requires python2
wget https://github.com/Illumina/pyflow/releases/download/v1.1.17/pyflow-1.1.17.tar.gz
pip install pyflow-1.1.17.tar.gz
rm pyflow-1.1.17.tar.gz

# create python3 env and install the rest of the dependencies
conda create --name py3 python=3 anaconda
source activate py3
pip install drep
conda install -y -c bioconda mummer=3.23 mash=1.1 prodigal=2.6.3 centrifuge=1.0.3 pyyaml click

wget https://ani.jgi-psf.org/download_files/ANIcalculator_v1.tgz
gunzip ANIcalculator_v1.tgz
tar -xvf ANIcalculator_v1.tar
rm -r ANIcalculator_v1.tar
chmod -R 755 ANIcalculator_v1
mv ANIcalculator_v1/ANIcalculator ./dependencies/miniconda/envs/py3/bin/
rm -r ANIcalculator_v1

# simlink checkm from python2 root env for use in py3 env
checkm_path="$(readlink -f ./dependencies/miniconda/bin/checkm)"
ln -s $checkm_path ./dependencies/miniconda/envs/py3/bin/checkm
