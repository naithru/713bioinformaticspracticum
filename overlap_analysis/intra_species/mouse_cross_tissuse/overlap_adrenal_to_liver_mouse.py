def count_lines(file_path):
    with open(file_path) as f:
        return sum(1 for _ in f)

# File paths
all_adrenal = "mouse_adrenal_peaks.bed"
overlap_adrenal = "overlapping_adrenal_to_liver_mouse.bed"

# Count lines
total = count_lines(all_adrenal)
overlapping = count_lines(overlap_adrenal)

# Calculate percentage
percent = (overlapping / total) * 100 if total else 0

# Output
print(f"Mouse Adrenal → Liver overlap: {percent:.2f}%")
