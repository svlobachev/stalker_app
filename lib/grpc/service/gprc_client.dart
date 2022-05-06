import 'package:grpc/grpc.dart';
import 'package:stalker_app/grpc/generated/proto_service.pb.dart';
import 'package:stalker_app/grpc/generated/proto_service.pbgrpc.dart';

class GRPCClient {
  void grpcClientRun() async {
    final channel = ClientChannel(
      'localhost',
      port: 6565,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        codecRegistry:
            CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );
    final stub = GreeterClient(channel);

    // final name = args.isNotEmpty ? args[0] : 'Sergei';

    try {
      var names = <String, String>{};
      names['first'] = 'partridge';
      names['second'] = 'turtledoves';
      names['fifth'] = 'golden rings';
      final response = await stub.sayHello(
        RequestMessage()..name.addAll(names),
        options: CallOptions(compression: const GzipCodec()),
      );
      print('Greeter client received: ${response.message}');
    } catch (e) {
      print('Caught error: $e');
    }
    await channel.shutdown();
  }
}
