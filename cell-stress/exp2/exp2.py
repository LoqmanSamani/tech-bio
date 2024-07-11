import pandas as pd
import numpy as np

counted_cells = pd.DataFrame({
    "Location": ["Top Left", "Top Right", "Bottom Left", "Bottom Right", "Average"],
    "First Count": [35, 25, 25, 27, np.mean([35, 25, 25, 27])],
    "Second Count": [35, 26, 21, 24, np.mean([35, 26, 21, 24])],
    "Third Count": [42, 19, 21, 24, np.mean([42, 19, 21, 24])],
    "Fourth Count": [24, 22, 30, 29, np.mean([24, 22, 30, 29])],
    "Fifth Count": [29, 27, 18, 21, np.mean([29, 27, 18, 21])]
})

