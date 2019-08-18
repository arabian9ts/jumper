//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: prediction.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Dispatch
import Foundation
import SwiftGRPC
import SwiftProtobuf

internal protocol Prediction_PredictionServicePredictCall: ClientCallClientStreaming {
  /// Send a message to the stream. Nonblocking.
  func send(_ message: Prediction_PredictRequest, completion: @escaping (Error?) -> Void) throws
  /// Do not call this directly, call `send()` in the protocol extension below instead.
  func _send(_ message: Prediction_PredictRequest, timeout: DispatchTime) throws

  /// Call this to close the connection and wait for a response. Blocking.
  func closeAndReceive() throws -> Prediction_PredictResponse
  /// Call this to close the connection and wait for a response. Nonblocking.
  func closeAndReceive(completion: @escaping (ResultOrRPCError<Prediction_PredictResponse>) -> Void) throws
}

internal extension Prediction_PredictionServicePredictCall {
  /// Send a message to the stream and wait for the send operation to finish. Blocking.
  func send(_ message: Prediction_PredictRequest, timeout: DispatchTime = .distantFuture) throws { try self._send(message, timeout: timeout) }
}

fileprivate final class Prediction_PredictionServicePredictCallBase: ClientCallClientStreamingBase<Prediction_PredictRequest, Prediction_PredictResponse>, Prediction_PredictionServicePredictCall {
  override class var method: String { return "/prediction.PredictionService/Predict" }
}


/// Instantiate Prediction_PredictionServiceServiceClient, then call methods of this protocol to make API calls.
internal protocol Prediction_PredictionServiceService: ServiceClient {
  /// Asynchronous. Client-streaming.
  /// Use methods on the returned object to stream messages and
  /// to close the connection and wait for a final response.
  func predict(metadata customMetadata: Metadata, completion: ((CallResult) -> Void)?) throws -> Prediction_PredictionServicePredictCall

}

internal extension Prediction_PredictionServiceService {
  /// Asynchronous. Client-streaming.
  func predict(completion: ((CallResult) -> Void)?) throws -> Prediction_PredictionServicePredictCall {
    return try self.predict(metadata: self.metadata, completion: completion)
  }

}

internal final class Prediction_PredictionServiceServiceClient: ServiceClientBase, Prediction_PredictionServiceService {
  /// Asynchronous. Client-streaming.
  /// Use methods on the returned object to stream messages and
  /// to close the connection and wait for a final response.
  internal func predict(metadata customMetadata: Metadata, completion: ((CallResult) -> Void)?) throws -> Prediction_PredictionServicePredictCall {
    return try Prediction_PredictionServicePredictCallBase(channel)
      .start(metadata: customMetadata, completion: completion)
  }

}

/// To build a server, implement a class that conforms to this protocol.
/// If one of the methods returning `ServerStatus?` returns nil,
/// it is expected that you have already returned a status to the client by means of `session.close`.
internal protocol Prediction_PredictionServiceProvider: ServiceProvider {
  func predict(session: Prediction_PredictionServicePredictSession) throws -> Prediction_PredictResponse?
}

extension Prediction_PredictionServiceProvider {
  internal var serviceName: String { return "prediction.PredictionService" }

  /// Determines and calls the appropriate request handler, depending on the request's method.
  /// Throws `HandleMethodError.unknownMethod` for methods not handled by this service.
  internal func handleMethod(_ method: String, handler: Handler) throws -> ServerStatus? {
    switch method {
    case "/prediction.PredictionService/Predict":
      return try Prediction_PredictionServicePredictSessionBase(
        handler: handler,
        providerBlock: { try self.predict(session: $0 as! Prediction_PredictionServicePredictSessionBase) })
          .run()
    default:
      throw HandleMethodError.unknownMethod
    }
  }
}

internal protocol Prediction_PredictionServicePredictSession: ServerSessionClientStreaming {
  /// Do not call this directly, call `receive()` in the protocol extension below instead.
  func _receive(timeout: DispatchTime) throws -> Prediction_PredictRequest?
  /// Call this to wait for a result. Nonblocking.
  func receive(completion: @escaping (ResultOrRPCError<Prediction_PredictRequest?>) -> Void) throws

  /// Exactly one of these two methods should be called if and only if your request handler returns nil;
  /// otherwise SwiftGRPC will take care of sending the response and status for you.
  /// Close the connection and send a single result. Non-blocking.
  func sendAndClose(response: Prediction_PredictResponse, status: ServerStatus, completion: (() -> Void)?) throws
  /// Close the connection and send an error. Non-blocking.
  /// Use this method if you encountered an error that makes it impossible to send a response.
  /// Accordingly, it does not make sense to call this method with a status of `.ok`.
  func sendErrorAndClose(status: ServerStatus, completion: (() -> Void)?) throws
}

internal extension Prediction_PredictionServicePredictSession {
  /// Call this to wait for a result. Blocking.
  func receive(timeout: DispatchTime = .distantFuture) throws -> Prediction_PredictRequest? { return try self._receive(timeout: timeout) }
}

fileprivate final class Prediction_PredictionServicePredictSessionBase: ServerSessionClientStreamingBase<Prediction_PredictRequest, Prediction_PredictResponse>, Prediction_PredictionServicePredictSession {}

