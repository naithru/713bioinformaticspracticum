#!/bin/bash
module load bedtools

# Code for mouse OCR: shared,liver only,adrenal only bed files to find promoters and enhancers.

# === Path settings ===
WORKDIR="/ocean/projects/bio230007p/jzhao15/project/enhancer_promoters"
OCRDIR="/ocean/projects/bio230007p/jzhao15/project/step3a/step3a_mouse"
TSS="$WORKDIR/mouse_TSS_strand_sorted.bed"

# === Shared OCRs ===
SHARED="$OCRDIR/mouse_shared_OCRs_clean.bed"
OUT_SHARED="$WORKDIR/region_by_TSS_distance_mouse_shared"
mkdir -p $OUT_SHARED

bedtools closest -a $SHARED -b $TSS -D a > $OUT_SHARED/mouse_shared_OCR_with_TSS_distance.bed
awk '($NF >= -2000 && $NF <= 2000)' $OUT_SHARED/mouse_shared_OCR_with_TSS_distance.bed > $OUT_SHARED/mouse_shared_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $OUT_SHARED/mouse_shared_OCR_with_TSS_distance.bed > $OUT_SHARED/mouse_shared_enhancers_2kbplus.bed

echo "[Mouse-Shared] Promoter count: $(wc -l < $OUT_SHARED/mouse_shared_promoters_2kb.bed)"
echo "[Mouse-Shared] Enhancer count: $(wc -l < $OUT_SHARED/mouse_shared_enhancers_2kbplus.bed)"

# === Liver-only OCRs ===
LIVER="$OCRDIR/mouse_liver_only_OCRs_clean.bed"
OUT_LIVER="$WORKDIR/region_by_TSS_distance_mouse_liver"
mkdir -p $OUT_LIVER

bedtools closest -a $LIVER -b $TSS -D a > $OUT_LIVER/mouse_liver_OCR_with_TSS_distance.bed
awk '($NF >= -2000 && $NF <= 2000)' $OUT_LIVER/mouse_liver_OCR_with_TSS_distance.bed > $OUT_LIVER/mouse_liver_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $OUT_LIVER/mouse_liver_OCR_with_TSS_distance.bed > $OUT_LIVER/mouse_liver_enhancers_2kbplus.bed

echo "[Mouse-Liver] Promoter count: $(wc -l < $OUT_LIVER/mouse_liver_promoters_2kb.bed)"
echo "[Mouse-Liver] Enhancer count: $(wc -l < $OUT_LIVER/mouse_liver_enhancers_2kbplus.bed)"

# === Adrenal-only OCRs ===
ADRENAL="$OCRDIR/mouse_adrenal_only_OCRs_clean.bed"
OUT_ADRENAL="$WORKDIR/region_by_TSS_distance_mouse_adrenal"
mkdir -p $OUT_ADRENAL

bedtools closest -a $ADRENAL -b $TSS -D a > $OUT_ADRENAL/mouse_adrenal_OCR_with_TSS_distance.bed
awk '($NF >= -2000 && $NF <= 2000)' $OUT_ADRENAL/mouse_adrenal_OCR_with_TSS_distance.bed > $OUT_ADRENAL/mouse_adrenal_promoters_2kb.bed
awk '($NF < -2000 || $NF > 2000)' $OUT_ADRENAL/mouse_adrenal_OCR_with_TSS_distance.bed > $OUT_ADRENAL/mouse_adrenal_enhancers_2kbplus.bed

echo "[Mouse-Adrenal] Promoter count: $(wc -l < $OUT_ADRENAL/mouse_adrenal_promoters_2kb.bed)"
echo "[Mouse-Adrenal] Enhancer count: $(wc -l < $OUT_ADRENAL/mouse_adrenal_enhancers_2kbplus.bed)"

echo "Mouse enhancer/promoter annotation complete."