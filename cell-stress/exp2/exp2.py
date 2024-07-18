import pandas as pd
import numpy as np

counted_cells = pd.DataFrame({
    "Location": ["Top Left", "Top Right", "Bottom Left", "Bottom Right", "Average", "Experiemnt"],
    "First Count": [31, 32, 31, 34, np.mean([31, 32, 31, 34]), "Experiment 4, day1"],
    "Second Count": [29, 46, 49, 39, np.mean([29, 46, 49, 39]), "Experiment 3, day1"],
    "Third Count": [24, 22, 30, 29, np.mean([24, 22, 30, 29]), "Experiment 5, day4"],
    "Fourth Count": [35, 26, 21, 24, np.mean([35, 26, 21, 24]), "Experiment 2, day5"],
    "Fifth Count": [42, 22, 20, 24, np.mean([42,22, 20, 24]), "Experiment 3, wt, day6"],
    "Sixth Count": [36, 19, 21, 24, np.mean([36, 19, 21, 24]), "Experiment 3, dr5-ko, day6"],
    "Seventh Count": [31, 26, 25, 26, np.mean([31, 26, 25, 26]), "Experiment 7, day11"]
})



