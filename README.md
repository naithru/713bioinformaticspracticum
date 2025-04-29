# Bioinformatics Data Integration Practicum - Final Project

# Cross-Species Regulatory Element Conservation Analysis

This project analyzes the conservation of open chromatin regions (enhancers/promoters) across human and mouse tissues (Liver, Adrenal Gland) using comparative genomics tools.
## Project Overview
**Goal**: Determine whether transcriptional regulatory element activity is more conserved across tissues or species. 
1. Evaluate the quality of the datasets - The data that was given to us was pre-processed.
2.  Map the mouse open chromatin regions to the human genome and map the human open chromatin regions to the mouse genome  - Using Hal and HalLiftover
3. Find the percentages of the overlapped regions - Using bedtool intersect.
4. Find the regulatory regions and its functions - Using GREAT webtool.
5. Divide the open chromatin data into likely enhancers and likely promoters - Using bedtools and GENCODE/ENCODE data.
6. Find sequence patterns - Motif Analysis - Using MEMESuite, Centrimo, FIMO


**Key Questions**:
1. Are open chromatin regions more conserved across tissues (human Liver vs. human Adrenal) or species (human Liver vs. mouse Liver)?
2. What biological processes are regulated by conserved regions?

## Setup

### Dependencies
1. [HALPER and HalLiftover](https://github.com/pfenninglab/halLiftover-postprocessing) - Clone the repository
2. [bedttols](https://anaconda.org/bioconda/bedtools) - v2.30+
3. [Gene Ontology Enrichment (GREAT)](http://great.stanford.edu/public/html/index.php) - To use GREAT please cut the first 3 columns from the input files

#Command for keeping only the first 3 columns

          `cut -f1-3 input_bed_file  > output_file_name`



4. [MEMEsuite](https://meme-suite.org/meme//doc/download.html) -  v MEME-suite/5.4.1 If your input files are not huge, you can also use [MEME-ChIP webtool](https://meme-suite.org/meme/tools/meme-chip)
5. [Anaconda3](https://www.anaconda.com/docs/getting-started/anaconda/install) - For Conda environment and Python. V 2024.10-1

### Installation

# Create Conda environment

conda create -n conservation-env -c bioconda hal bedtools python=3.8

conda activate conservation-env

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
## For running the entire pipeline, use the below mentioned commands from our Snakefile (Example run)
[Snakefile](https://github.com/naithru/713bioinformaticspracticum/blob/main/Snakefile)

`git clone https://github.com/naithru/713bioinformaticspracticum.git
cd your-repo-name`
`# If you do no have SnakeMake already
conda create -n atac_env -c bioconda -c conda-forge snakemake
conda activate atac_env`
`# Basic local run
snakemake --cores 4`
`Cluster/SLURM example
snakemake --jobs 20 \
  --cluster "sbatch -p RM-shared --mem=8G -t 24:00:00 -c 4" \
  --latency-wait 60
`


### Input files for pipeline

1. HALPER - idr.conservative_peak.narrowPeak
2. Overlap analysis via bedtool intersect - Bed file from the output of HALPER - mouse_adrenal_peaks.bed
3. Classifying Enhancers and Promoters - Need to clean the bed files first and named as - halper_cleaned.bed
4. To find the TSS bedfile - either use the path in /ocean/project/bio230007p
   /ikaplow/HumanGenomeInfo/gencode.V27.annotation.protTranscript.TSSsWithStrand_sorted.bed
   or make the promoter bed file from gencode.v44.basic.annotation.gtf.gz (repeat the steps with proper genome for human and mouse).
5. GREAT - Take the first 3 columns of halper results - named as halper_great_final.bed (Performed on the webtool).
6. Motif Analysis - all the found enhancers and promoters bed files - example: enhancer_adrenal.bed

### Output files pipeline
1. After Halper - Bed files. example: mouse_adrenal_peaks.bed
2. Overlap - txt or output on interactive shell with overlap percentages.
3. Number of Promoters and Enhancers  - Ouput on interactive shell with the number using the echo command.
4. GREAT - Results on the webtool. Can be saved as pdf, png or html.
5. Motif Analysis - Results are saved as HTML files.

### Contributors
1. Jiayi Zhao (jiayizh3@andrew.cmu.edu)
2. Shreya Rao SS (ssamaved@andrew.cmu.edu)
3. Naithruvan Rammohan (nrammoha@andrew.cmu.edu)
4. Ziyun Huang (ziyunh@andrew.cmu.edu)

### Project Guide
1. Dr. Irene Kaplow - ikaplow@andrew.cmu.edu
2. Wanxing Zhang (TA) - wanxingz@andrew.cmu.edu
