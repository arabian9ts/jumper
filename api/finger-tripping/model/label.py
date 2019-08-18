import numpy as np
from config import *

def parse_to_label(probs):
    result = np.argmax(probs)
    return conf.labels[result]
