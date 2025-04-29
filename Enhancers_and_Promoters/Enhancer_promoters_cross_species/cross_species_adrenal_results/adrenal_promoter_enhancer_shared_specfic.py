import matplotlib.pyplot as plt
import numpy as np

# Promoter/enhancer annotation completed for Adrenal. Results of enhancer and promoter in adrenal shared and specific species.
# [Shared Adrenal OCRs]
#   Promoters: 90823
#   Enhancers: 6515
# [Human-specific Adrenal OCRs]
#   Promoters: 15682
#   Enhancers: 32999
# [Mouse-specific Adrenal OCRs]
#   Promoters: 14334
#   Enhancers: 15221

# Data for Adrenal
categories = ['Shared', 'Human-specific', 'Mouse-specific']
promoter_counts = [90823, 15682, 14334]
enhancer_counts = [6515, 32999, 15221]

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
ax.set_title('Promoter and Enhancer Counts across Shared and Specific species in Adrenal OCRs')
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
plt.savefig('cross_species_adrenal_promoter_enhancer_counts.png', dpi=300)
plt.show()
