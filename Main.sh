rule all:
    input:
        "results/enhancers_promoters/classified_peaks.bed",
        "results/motif_enrichment/fimo.tsv",
        "results/GREAT_input/great_ready.bed"

rule halLiftover_mapping:
# We do mapping from Human to Mouse to do overlap analysis in mouse coordinates.
# Mapping of liver example
    input:
        "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.narrowPeak"
    output:
        "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.HALPER.narrowPeak"
    params:
        species_source = "Human",
        species_target = "Mouse",
        hal_file = "/ocean/projects/bio230007p/ikaplow/Alignments/10plusway-master.hal",
        work_dir = "/ocean/projects/bio230007p/jzhao15/project/map_results/Liver_results/HumanLiver_to_MouseLiver"
    shell:
        """
        bash halper_map_peak_orthologs.sh \
            -b {input} \
            -o {params.work_dir} \
            -s {params.species_source} \
            -t {params.species_target} \
            -c {params.hal_file}
        """

rule overlap_analysis_liver:
    input:
        halper_mapped = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/HumanLiver_to_MouseLiver/idr.conservative_peak.HumanToMouse.HALPER.narrowPeak",
        mouse_peaks = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/MouseLiver_peaks.bed"
    output:
        overlap = "/ocean/projects/bio230007p/rammohan/project/map_results/Liver_results/HumanLiver_to_MouseLiver/halper_liver_overlap.bed"
    shell:
        """
        bedtools intersect -a {input.halper_mapped} -b {input.mouse_peaks} -wa > {output.overlap}
        """

rule classify_elements:
    input:
        "results/overlap/overlap_peaks.bed"
    output:
        "results/enhancers_promoters/classified_peaks.bed"
    shell:
        "bash scripts/classify_elements.sh {input} {output}"

rule motif_enrichment:
    input:
        "results/enhancers_promoters/classified_peaks.bed"
    output:
        "results/motif_enrichment/fimo.tsv"
    shell:
        "bash scripts/run_motif_analysis.sh {input} {output}"

rule prepare_GREAT_input:
    input:
        "results/enhancers_promoters/classified_peaks.bed"
    output:
        "results/GREAT_input/great_ready.bed"
    shell:
        "bash scripts/prepare_great_input.sh {input} {output}"

