# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
import grpc

import prediction_pb2 as prediction__pb2


class PredictionServiceStub(object):
  # missing associated documentation comment in .proto file
  pass

  def __init__(self, channel):
    """Constructor.

    Args:
      channel: A grpc.Channel.
    """
    self.Predict = channel.unary_unary(
        '/prediction.PredictionService/Predict',
        request_serializer=prediction__pb2.PredictRequest.SerializeToString,
        response_deserializer=prediction__pb2.PredictResponse.FromString,
        )


class PredictionServiceServicer(object):
  # missing associated documentation comment in .proto file
  pass

  def Predict(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')


def add_PredictionServiceServicer_to_server(servicer, server):
  rpc_method_handlers = {
      'Predict': grpc.unary_unary_rpc_method_handler(
          servicer.Predict,
          request_deserializer=prediction__pb2.PredictRequest.FromString,
          response_serializer=prediction__pb2.PredictResponse.SerializeToString,
      ),
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'prediction.PredictionService', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))
