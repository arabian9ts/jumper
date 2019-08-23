import os
import numpy as np

from keras.models import load_model

from config import *
from util.mel import *

model = None

def restore_model():
    return load_model(os.path.dirname(os.path.abspath(__file__)) + '/model/alexnet.h5')

def parse_to_label(probs):
    result = np.argmax(probs)
    return conf.labels[result]

def predict(audio_buffer):
      sound = np.array(audio_buffer[:conf.sampling_rate * conf.duration]) / 32767
      melspectrogram = sound_to_mel(conf, sound)

      if melspectrogram is not None:
          reshaped = np.reshape(melspectrogram, (1, 128, 128, 1))
          probs = model.predict(reshaped)
          label = parse_to_label(probs)
          if not label in predicted and label is not 'noise':
              print(label)

if __name__ == '__main__':
    model = restore_model()
