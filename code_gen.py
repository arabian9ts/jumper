from grpc.tools import protoc

protoc.main(
    (
        '',
        '-I.',
        '--python_out=api/jumper',
        '--grpc_python_out=api/jumper',
        './prediction.proto',
    )   
)
