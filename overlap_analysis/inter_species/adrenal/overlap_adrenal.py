# overlap_adrenal.py

def count_lines(file_path):
    with open(file_path) as f:
        return sum(1 for _ in f)

# File paths
halper_all = "idr.conservative_peak.HumanToMouse.HALPER.adrenal.narrowPeak"
halper_overlap = "overlapping_halper_peaks_adrenal.bed"

# Count lines
total = count_lines(halper_all)
overlapping = count_lines(halper_overlap)

# Calculate percentage
if total == 0:
    percent = 0
else:
    percent = (overlapping / total) * 100

# Output
print(f"HALPER-mapped peaks overlapping with mouse adrenal peaks: {percent:.2f}%")

# Save to file
with open("final_overlap_result_adrenal.txt", "w") as out:
    out.write(f"HALPER-mapped peaks overlapping with mouse adrenal peaks: {percent:.2f}%\n")
