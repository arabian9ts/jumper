import grpc
from prediction_pb2 import *
from prediction_pb2_grpc import add_PredictionServiceServicer_to_server, PredictionServiceServicer, PredictionServiceStub

with grpc.insecure_channel('localhost:50051') as channel:
    stub = PredictionServiceStub(channel)
    magnitudes = [i for i in range(128)]
    request = PredictRequest(magnitudes=iter(magnitudes))
    res = stub.Predict(request)
    print(res)

