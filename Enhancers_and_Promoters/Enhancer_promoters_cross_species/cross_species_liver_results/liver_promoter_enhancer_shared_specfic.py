import matplotlib.pyplot as plt
import numpy as np

# Promoter/enhancer annotation completed. Results from script "cross_species_liver_promoter_enhancer.sh"
# [Shared Liver OCRs]
#   Promoters: 70790
#   Enhancers: 11403
# [Human-specific Liver OCRs]
#   Promoters: 8634
#   Enhancers: 25419
# [Mouse-specific Liver OCRs]
#   Promoters: 35197
#   Enhancers: 65767

# Data of promoters and enhancer in liver shared and specific species
categories = ['Shared', 'Human-specific', 'Mouse-specific']
promoter_counts = [70790, 8634, 35197]
enhancer_counts = [11403, 25419, 65767]

# Set bar width and positions
x = np.arange(len(categories))
width = 0.35

# Create the plot
fig, ax = plt.subplots(figsize=(8, 6))

# Draw bars for promoters
rects1 = ax.bar(x - width/2, promoter_counts, width, label='Promoters')

# Draw bars for enhancers
rects2 = ax.bar(x + width/2, enhancer_counts, width, label='Enhancers')

# Add labels, title, and legend
ax.set_ylabel('Number of OCRs')
ax.set_title('Promoter and Enhancer Counts across Shared and Specific species in Liver OCRs')
ax.set_xticks(x)
ax.set_xticklabels(categories)
ax.legend()

# Function to label each bar with its height
def autolabel(rects):
    for rect in rects:
        height = rect.get_height()
        ax.annotate(f'{height}',
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 3),  # vertical offset
                    textcoords="offset points",
                    ha='center', va='bottom', fontsize=8)

# Apply labels
autolabel(rects1)
autolabel(rects2)

# Adjust layout to fit everything
fig.tight_layout()

# Save and show the figure
plt.savefig('cross_species_liver_promoter_enhancer_counts.png', dpi=300)
plt.show()