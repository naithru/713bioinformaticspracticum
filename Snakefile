rule all:
    """
    Final output files to be produced by the pipeline.
    """
    input:
        bed_sfile = "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.halLiftover.sFile.bed",
        bed_tfile = "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.halLiftover.tFile.bed",
        mapped_peaks = "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.HALPER.narrowPeak",
        overlap = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/HumanLiver_to_MouseLiver/halper_liver_overlap.bed",
        liver = "Liver_human_peaks.bed",
        adrenal = "Adrenal_human_peaks.bed",
        shared_in_human = "step3a_human/human_shared_OCRs.bed",
        liver_specific = "step3a_human/human_liver_only_OCRs.bed",
        adrenal_specific = "step3a_human/human_adrenal_only_OCRs.bed",
        shared_in_liver = "shared_liver_OCR.bed",
        human_specific = "human_specific_liver_OCR.bed",
        mouse_specific = "mouse_specific_liver_OCR.bed",
        shared_enhancers_human = "region_by_TSS_distance_human_shared/shared_enhancers_2kbplus.bed",
        shared_promoters_human = "region_by_TSS_distance_human_shared/shared_promoters_2kb.bed",
        liver_only_enhancers_human = "region_by_TSS_distance_human_liver/liver_enhancers_2kbplus.bed",
        liver_only_promoters_human = "region_by_TSS_distance_human_liver/liver_promoters_2kb.bed",
        adrenal_only_enhancers_human = "region_by_TSS_distance_human_adrenal/adrenal_enhancers_2kbplus.bed",
        adrenal_only_promoters_human = "region_by_TSS_distance_human_adrenal/adrenal_promoters_2kb.bed",
        fasta = expand("results/fasta_OCR/_{tissue}.fa", tissue=["liver", "adrenal"]),
        outdir = expand("results/output.outdir/memechip_{species}_{tissue}_{element}",
                        species=["human", "mouse"],
                        tissue=["liver", "adrenal"],
                        element=["enhancer", "promoter"]),
        great_input = "results/great_input/mouse_specific_liver_OCRs_clean_3col.bed"



        
    


rule halLiftover_mapping:
"""
Mapping human liver IDR peaks to mouse genome in mouse coordinates using HALPER as one example.
"""
    input:
    # Unzip and Copy the file of human liver ATAC data from Irene Kaplow /ocean/projects/bio230007p/ikaplow/HumanAtac/Liver/peak/idr_reproducibility/idr.conservative_peak.narrowPeak.gz
    # in your own path the same folder for output
    # If no access to this file, we provide the liver "idr.conservative_peak.narrowPeak" through the link 
    # https://github.com/naithru/713bioinformaticspracticum/blob/main/HALPER_code/idr.conservative_peak.narrowPeak
        "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.narrowPeak"
    output:
        # Need to edit in your path
        # Outputs generated by HALPER (3 files)
        bed_sfile = "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.halLiftover.sFile.bed",
        bed_tfile = "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.halLiftover.tFile.bed",
        mapped_peaks = "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.HALPER.narrowPeak"
    
    params:
        # Download the script from the link https://github.com/naithru/713bioinformaticspracticum/blob/main/HALPER_code/liver_map.job in your own path
        job_script = "/ocean/projects/bio230007p/jzhao15/project/HALPER_code/liver_map.job"
        
    shell:
        """
        bash {params.job_script}
        """
rule overlap_analysis_liver:
    """
    Intersect HALPER-mapped human liver peaks with mouse liver ATAC-seq peaks.
    Calculates how many human regions are still open in the mouse liver.
    
    NOTE: Update the paths below to match your own directory structure.
    """
    #Input is a result from HALPER
    input:
        halper_mapped = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.HALPER.narrowPeak",
        mouse_peaks = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/MouseLiver_peaks.bed"
    output:
        overlap = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/HumanLiver_to_MouseLiver/halper_liver_overlap.bed"
    params:
        # Download the script from the link https://github.com/naithru/713bioinformaticspracticum/blob/main/overlap_analysis/overlap_liver.job in your own path
        job_script = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/HumanLiver_to_MouseLiver/overlap_liver.job"
    shell:
        """
        bash {params.job_script}
        """
        
rule find_OCRs:
    """
    Identify shared and specific OCRs:
    - Cross-tissue: within species (e.g., human liver vs adrenal)
    - Cross-species: same tissue (e.g., liver human vs mouse)
    Scripts are downloaded from GitHub, download to your own path.
    """
    input:
        # cross-tissue in human example
       
        # These inputs are unzip and save in your own path as same of human liver/Adrenal ATAC data from Irene Kaplow 
        # /ocean/projects/bio230007p/ikaplow/HumanAtac/Liver/peak/idr_reproducibility/idr.conservative_peak.narrowPeak.gz and 
        # /ocean/projects/bio230007p/ikaplow/HumanAtac/AdrenalGland/peak/idr_reproducibility/idr.conservative_peak.narrowPeak.gz
        liver = "Liver_human_peaks.bed",
        adrenal = "Adrenal_human_peaks.bed",
 
        # cross-species in liver example
        
        # The input file are results from HALPER with clean the bed file:
        # Refer the link:
        # https://github.com/naithru/713bioinformaticspracticum/blob/main/Within_tissue_shared_specific_OCRs/HALPER_file_process/file_halper_output.sh
        HUMAN_MAPPED = "/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/cross-species/cross_species_liver_halper.bed",
        MOUSE_OCR ="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/mouse_liver_idr_clean.bed",
        TSS ="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/mouse_TSS_strand_clean_sorteddd.bed"   # Mouse genome TSS annotation from Irene Kaplow
       
    output:
        # Cross-tissue (human example)
        # Can refer to link of outputs for check 3 outputs:
        # https://github.com/naithru/713bioinformaticspracticum/tree/main/Within_species_shared_specific_OCRs/within_human
        shared_in_human = "step3a_human/human_shared_OCRs.bed",
        liver_specific = "step3a_human/human_liver_only_OCRs.bed",
        adrenal_specific = "step3a_human/human_adrenal_only_OCRs.bed",
        
        # Cross-species (liver example)
        # Can refer to link of outputs for check 3 outputs:
        # https://github.com/naithru/713bioinformaticspracticum/tree/main/Within_tissue_shared_specific_OCRs/cross-species-liver-OCR
        shared_in_liver = "shared_liver_OCR.bed",
        human_specific = "human_specific_liver_OCR.bed",
        mouse_specific = "mouse_specific_liver_OCR.bed"
        
    params:
        # Download the script in your own path
        
        # cross-tissue in human example
        # The link of the human_cross_tissue_script:
        # https://github.com/naithru/713bioinformaticspracticum/blob/main/Within_species_shared_specific_OCRs/step3a_human.sh
        human_cross_tissue_script = "step3a_human.sh",

        # cross-species in liver example
        # The link of the liver_cross_species_script:
        # https://github.com/naithru/713bioinformaticspracticum/blob/main/Within_tissue_shared_specific_OCRs/cross_species_liver3OCR.sh
        liver_cross_species_script = "cross_species_liver3OCR.sh"
         
    shell:
        """
        # Run human cross-tissue analysis
        bash {params.human_cross_tissue_script}

        # Run liver cross-species analysis
        bash {params.liver_cross_species_script}
        """

rule classify_elements:
    """
    Classify OCRs output as enhancers or promoters based on distance to TSS.
    Includes:
    1. Cross-tissue comparison (e.g., mouse liver vs adrenal) for each species 
    2. Cross-species comparison (e.g., human vs mouse liver) for each tissue
    """
    # Download in your own path
    input:
        # Mouse genome TSS annotation
        TSS ="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/mouse_TSS_strand_clean_sorteddd.bed"
        
        # Results from OCRs
        # Cross-tissue OCRs in human example
        shared_in_human = "step3a_human/human_shared_OCRs.bed",
        liver_specific = "step3a_human/human_liver_only_OCRs.bed",
        adrenal_specific = "step3a_human/human_adrenal_only_OCRs.bed",

        # Cross-species OCRs in liver example
        shared_in_liver = "shared_liver_OCR.bed",
        human_specific = "human_specific_liver_OCR.bed",
        mouse_specific = "mouse_specific_liver_OCR.bed"
        
    output:
        # Cross-tissue in human
        # Can refer to the link for check:
        # https://github.com/naithru/713bioinformaticspracticum/tree/main/Enhancers_and_Promoters/Enhancers_promoters_cross_tissue
        shared_enhancers_human = "region_by_TSS_distance_human_shared/shared_enhancers_2kbplus.bed",
        shared_promoters_human = "region_by_TSS_distance_human_shared/shared_promoters_2kb.bed",
        liver_only_enhancers_human = "region_by_TSS_distance_human_liver/liver_enhancers_2kbplus.bed",
        liver_only_promoters_human = "region_by_TSS_distance_human_liver/liver_promoters_2kb.bed",
        adrenal_only_enhancers_human = "region_by_TSS_distance_human_adrenal/adrenal_enhancers_2kbplus.bed",
        adrenal_only_promoters_human = "region_by_TSS_distance_human_adrenal/adrenal_promoters_2kb.bed"
        
        # Cross-species in liver
        # Can refer to the link for check:
        # https://github.com/naithru/713bioinformaticspracticum/tree/main/Enhancers_and_Promoters/Enhancer_promoters_cross_species/cross_species_liver_results
        shared_liver_enhancers = "shared_liver_enhancers.bed",
        shared_liver_promoters = "shared_liver_promoters.bed",
        mouse_specific_liver_enhancers = "mouse_specific_liver_enhancers.bed",
        mouse_specific_liver_promoters = "mouse_specific_liver_promoters.bed",
        human_specific_liver_promoters = "human_specific_liver_promoters.bed",
        human_specific_liver_enhancers = "human_specific_liver_enhancers.bed"
        
    params:
        # Download the script in your own path
        
        # cross-tissue in human example
        # The link of the human_cross_tissue_script:
        # https://github.com/naithru/713bioinformaticspracticum/blob/main/Enhancers_and_Promoters/Enhancers_promoters_cross_tissue/human3OCR.sh
        human_cross_tissue_script = "human3OCR.sh"

        # cross-species in liver example
        # The link of the cross_species_liver_promoter_enhancer_script:
        # https://github.com/naithru/713bioinformaticspracticum/blob/main/Enhancers_and_Promoters/Enhancer_promoters_cross_species/cross_species_liver_promoter_enhancer.sh
        cross_species_liver_promoter_enhancer_script = "cross_species_liver_promoter_enhancer.sh"
         
    shell:
        """
        # Run human cross-tissue promoters and enhancers analysis
        bash {params.human_cross_tissue_script}
        # Run liver cross-species promoters and enhancers analysis
        bash {params.cross_species_liver_promoter_enhancer_script}
        """

rule get_fasta:
    """
    Extract sequences from BED file using bedtools getfasta.
    """
    input:
        bed="data/regions/_{tissue}.bed",
        genome="/ocean/projects/bio230007p/zhuang13/ref/mm10.fa" for mouse or "/ocean/projects/bio230007p/zhuang13/ref/hg38.fa" for human.

    output:
        fasta="results/fasta_OCR/_{tissue}.fa"

    params:
        # Download the script in your own path
        resources:
        mem_mb=8000,
        time="2:00:00"
        # Link to script
        # https://github.com/naithru/713bioinformaticspracticum/Motif Enrichment/bed2fasta.sh

        # Example files
        ################# wait the network

    shell:
        """
        # Generate a file to store output FASTA files
        mkdir -p results/fasta_OCR
        # Run getfasta to extract sequences in FASTA file from BED file
        bedtools getfasta -fi {input.genome} -bed {input.bed} -fo {output.fasta}
        """

rule motif_enrichment:
    """
    Run MEME-ChIP for motif enrichment analysis on liver sequences.
    """
    input:
        fasta="results/fasta_OCR/{species}_{tissue}_{enhancer/promoter}.fa",
        motif_db="/ocean/projects/bio230007p/zhuang13/ref/motif_db/HOCOMOCOv11_full_MOUSE.meme" for mouse, "/ocean/projects/bio230007p/zhuang13/ref/motif_db/HOCOMOCOv11_full_HUMAN.meme" for human

    output:
        outdir=directory("results/output.outdir/memechip_{species}_{tissue}_{enhancer/promoter}")

    params:
        # Download the script in your own path
        nmotifs=2
        threads: 4
        resources:
        mem_mb=8000,
        time="24:00:00"
        # Link to script
        # https://github.com/naithru/713bioinformaticspracticum/Motif Enrichment/memechip.job
        # Example of output folder(output.outdir): [[[[Link]]]]################ wait the network

    shell:
        """
        meme-chip -oc {output.outdir} \
            -db {input.motif_db} \
            -meme-nmotifs {params.nmotifs} \
            {input.fasta}
        """


rule prepare_GREAT_input:
    """
    Prepare BED file for GREAT by keeping only the first 3 columns.
    """
    input:
        "mouse_specific_liver_OCR.bed" #The output file from cross-species liver OCR
    output:
        "results/great_input/mouse_specific_liver_OCRs_clean_3col.bed"  #Use the output file on the GREAT webtool mentioned on ReadMe
    shell:
        """
        mkdir -p results/great_input
        cut -f1-3 {input} > {output}
        echo "Prepared GREAT input: {output}"
        """

