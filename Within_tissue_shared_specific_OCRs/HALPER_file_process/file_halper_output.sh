# File of HALPER mapping from human to mouse output to get sorted bed file for OCR analysis
cut -f1-3 idr.conservative_peak.HumanToMouse.HALPER.narrowPeak | sort -k1,1V -k2,2n > /ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/cross-species/cross_species_liver_halper.bed
cut -f1-3 idr.conservative_peak.HumanToMouse.HALPER.narrowPeak | sort -k1,1V -k2,2n > /ocean/projects/bio230007p/jzhao15/project/enhancer_promoters/cross-species/cross_species_adrenal_halper.bed
