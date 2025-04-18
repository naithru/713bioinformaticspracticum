def count_lines(file_path):
    with open(file_path) as f:
        return sum(1 for _ in f)

# File paths
all_liver = "mouse_liver_peaks.bed"
overlap_liver = "overlapping_liver_to_adrenal_mouse.bed"

# Count lines
total = count_lines(all_liver)
overlapping = count_lines(overlap_liver)

# Calculate percentage
percent = (overlapping / total) * 100 if total else 0

# Output
print(f"Mouse Liver → Adrenal overlap: {percent:.2f}%")
