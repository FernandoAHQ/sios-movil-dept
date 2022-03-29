import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/providers/providerServices.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:sios_v1/screens/reports/generateReport.dart';
import 'package:sios_v1/screens/loading/loadingBody.dart';
import 'package:flutter/services.dart';
import 'package:sios_v1/screens/login/loginScreen.dart';
import 'package:sios_v1/screens/viewReport/viewReport.dart';
//https://sios-server.herokuapp.com
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderUserData>(
            create: (context) => ProviderUserData()),
        ChangeNotifierProvider<ProviderSocket>(
            create: (context) => ProviderSocket()),        
        ChangeNotifierProvider<ProviderServices>(
            create: (context) => ProviderServices()),
      ],
      child: MaterialApp(
        title: 'SIOS V1',
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: const LoadingScreen(),
      ),
    );
  }
}
