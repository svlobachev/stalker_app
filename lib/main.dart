import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stalker_app/grpc/service/gprc_client.dart';
import 'package:stalker_app/pages/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // var grpcClient = GRPCClient();
  // grpcClient.grpcClientRun();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'TheStalkerTxtGame',
      home: LoginPage(),
    );
  }
}
