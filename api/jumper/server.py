from prediction_pb2 import *
from prediction_pb2_grpc import add_PredictionServiceServicer_to_server, PredictionServiceServicer

from concurrent import futures
from datetime import datetime
import time
import grpc

import os
import numpy as np

from keras.models import load_model

from config import *
from util.mel import *


_ONE_DAY_IN_SECONDS = 60 * 60 * 24


class RoutePredictServicer(PredictionServiceServicer):
    def __init__(self):
        self.restore_model()
        self.test_flight()

    def restore_model(self):
      self.hypre = load_model(os.path.dirname(os.path.abspath(__file__)) + '/model/alexnet.h5')

    def parse_to_label(self, probs):
        result = np.argmax(probs)
        return conf.labels[result]

    def test_flight(self):
        sound = np.array([i/44000 for i in range(44100)])
        melspectrogram = sound_to_mel(conf, sound)
        reshaped = np.reshape(melspectrogram, (1, 128, 128, 1))
        probs = self.hypre.predict(reshaped)

    def Predict(self, request_iterator, context):
        print("Predict Called : %s" % datetime.now())

        sounds = []
        for req in request_iterator:
            sounds.extend(req.sounds)

        sound = np.array(sounds[:conf.sampling_rate * conf.duration])
        sound = sound * 10
        melspectrogram = sound_to_mel(conf, sound)

        if melspectrogram is not None:
            reshaped = np.reshape(melspectrogram, (1, 128, 128, 1))
            probs = self.hypre.predict(reshaped)
            label = self.parse_to_label(probs)
        else:
            label = "none"

        return PredictResponse(label=label)

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    add_PredictionServiceServicer_to_server(RoutePredictServicer(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    print("Server Start!!")
    try:
        while True:
            time.sleep(_ONE_DAY_IN_SECONDS)
    except KeyboardInterrupt:
        server.stop(0)


if __name__ == '__main__':
    serve()
