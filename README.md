# AUTOdRep
An automated builder for dRep.  It builds out a root python2 anaconda environement to install the checkm dependency and installs the rest of the dependencies in a python3 sub-environment.  The `runner.py` script automatically loads the environments post-build and runs any dRep command.  For convenience, a flux wrapper was integrated (--flux) for easy distribution of dRep commands to the UofM cluster.

# Setup
1. Build environments
> $./build

2. Configure checkm db
> $python runner.py "checkm"

# Usage
Run the dependency check; it should show 'all good' across the board
> $python runner.py "dRep bonus testDir --check_dependencies"
```
Loading work directory
Checking dependencies
mash.................................... all good
nucmer.................................. all good
checkm.................................. all good
ANIcalculator........................... all good
prodigal................................ all good
centrifuge.............................. all good
```

Run dRep de-replication
> $dRep dereplicate outout_directory -g path/to/genomes/*.fasta
