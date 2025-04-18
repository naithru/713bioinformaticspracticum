def count_lines(file_path):
    with open(file_path) as f:
        return sum(1 for _ in f)

total = count_lines("human_liver_peaks.bed")
overlap = count_lines("shared_liver_to_adrenal.bed")

percent = (overlap / total) * 100 if total else 0
print(f"Human Liver → Adrenal overlap: {percent:.2f}%")

with open("overlap_result_liver_to_adrenal.txt", "w") as f:
    f.write(f"Human Liver → Adrenal overlap: {percent:.2f}%\n")
