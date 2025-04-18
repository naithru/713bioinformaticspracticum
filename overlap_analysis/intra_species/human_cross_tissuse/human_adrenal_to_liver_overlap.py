def count_lines(file_path):
    with open(file_path) as f:
        return sum(1 for _ in f)

total = count_lines("human_adrenal_peaks.bed")
overlap = count_lines("shared_adrenal_to_liver.bed")

percent = (overlap / total) * 100 if total else 0
print(f"Human Adrenal → Liver overlap: {percent:.2f}%")

with open("overlap_result_adrenal_to_liver.txt", "w") as f:
    f.write(f"Human Adrenal → Liver overlap: {percent:.2f}%\n")
