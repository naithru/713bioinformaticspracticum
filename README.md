# Bioinformatics Data Integration Practicum - Final Project

# Cross-Species Regulatory Element Conservation Analysis

This project analyzes the conservation of open chromatin regions (enhancers/promoters) across human and mouse tissues (Liver, Adrenal Gland) using comparative genomics tools.
## Project Overview
**Goal**: Determine whether transcriptional regulatory element activity is more conserved across tissues or species. 
1. Evaluate the quality of the datasets - The data that was given to us was pre-processed.
2.  Map the mouse open chromatin regions to the human genome and map the human open chromatin regions to the mouse genome  - Using Hal and HalLiftover
3. Find the percentages of the overlapped regions - Using bedtool intersect.
4. Find the regulatory regions and its functions - Using GREAT webtool.
5. Divide the open chromatin data into likely enhancers and likely promoters - Using bedtool intersect and GENCODE/ENCODE data.
6. Find sequence patterns - Motif Analysis - Using MEMESuite, Centrimo, FIMO


**Key Questions**:
1. Are open chromatin regions more conserved across tissues (human Liver vs. human Adrenal) or species (human Liver vs. mouse Liver)?
2. What biological processes are regulated by conserved regions?

## Setup

### Dependencies
1. https://github.com/pfenninglab/halLiftover-postprocessing
2. https://bedtools.readthedocs.io/en/latest/
3. https://meme-suite.org/meme/

### Installation

# Create Conda environment
conda create -n conservation-env -c bioconda hal bedtools python=3.8
conda activate conservation-env
# Clone this repository
git clone https://github.com/pfenninglab/halLiftover-postprocessing.git

halLiftover --help        # Should show usage
halStats --version        # Confirm HAL is installed
bedtools --version        # Ensure v2.30+
ls repos/halLiftover-postprocessing/scripts/*.py  # Should list scripts

## *NOTE: For the installation and the entire code, the cloned github repositories are in the repos directory*
If you used a conda env name other than hal, modify:
sed -i 's/conda activate hal/conda activate YOUR_ENV_NAME/g' \
  repos/halLiftover-postprocessing/halper_map_peak_orthologs.sh
- **HAL Tools**: For halLiftover (install via Conda).
- conda create -n hal python=3.7  # Name MUST be "hal" for HALPER compatibility
conda activate hal
- **HALPER**: Post-processing scripts from [pfenninglab/halLiftover-postprocessing](https://github.com/pfenninglab/halLiftover-postprocessing).
conda install -c bioconda hal bedtools  # Install HAL tools + BEDTools
conda install -c conda-forge git        # Install Git
- **Python**: For plotting and data manipulation.


