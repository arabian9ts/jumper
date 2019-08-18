from grpc.tools import protoc

protoc.main(
    (
        '',
        '-I.',
        '--python_out=api/finger-tripping',
        '--grpc_python_out=api/finger-tripping',
        './prediction.proto',
    )   
)
