PROTO_DIR_CLIENT = app/finger-tripping/grpc
PROTO_DIR_SERVER = api/finger-tripping/grpc

.PHONY: protoc
protoc:
	@make protoc_client
	@make protoc_server

.PHONY: protoc_client
protoc_client:
	protoc prediction.proto \
	--swift_out=$(PROTO_DIR_CLIENT) \
  --swiftgrpc_out=$(PROTO_DIR_CLIENT)

.PHONY: protoc_server
protoc_server:
	protoc prediction.proto \
	--python_out=$(PROTO_DIR_SERVER)
