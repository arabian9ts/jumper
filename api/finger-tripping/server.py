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
from model.label import *


_ONE_DAY_IN_SECONDS = 60 * 60 * 24

def restore_model():
    return load_model(os.path.dirname(os.path.abspath(__file__)) + '/model/alexnet.h5')

class RoutePredictServicer(PredictionServiceServicer):
    def __init__(self):
        restore_model()

    def Predict(self, request, response):
        print("Predict Called : %s" % datetime.now())
        sound = np.array(request.magnitudes[:conf.sampling_rate * conf.duration]) / 32767
        melspectrogram = sound_to_mel(conf, sound)

        if melspectrogram is not None:
            reshaped = np.reshape(melspectrogram, (1, 128, 128, 1))
            probs = model.predict(reshaped)
            label = parse_to_label(probs)
        else:
            label = parse_to_label(0)

        # レスポンスを返す時はreturnするだけで良い
        return PredictResponse(
            label=label
        )


# サーバーの実行
def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    add_PredictionServiceServicer_to_server(
        RoutePredictServicer(), server)
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
