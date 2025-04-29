rule all:
    input:
        "results/enhancers_promoters/classified_peaks.bed",
        "results/motif_enrichment/fimo.tsv",
        "results/GREAT_input/great_ready.bed"

rule liftover_mapping:
    input:
        "data/input_peaks.narrowPeak"
    output:
        "results/mapped/mapped_peaks.bed"
    shell:
        "bash scripts/run_halper.sh {input} {output}"

rule overlap_analysis:
    input:
        "results/mapped/mapped_peaks.bed"
    output:
        "results/overlap/overlap_peaks.bed"
    shell:
        "bedtools intersect -a {input} -b data/target_regions.bed > {output}"

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

