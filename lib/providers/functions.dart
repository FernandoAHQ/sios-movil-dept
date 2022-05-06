import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/providers/providerServices.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/providers/providerUserData.dart';

import '../screens/login/loginScreen.dart';
import '../screens/reports/generateReport.dart';
import '../screens/reports/heroRoute.dart';

class Functions{

   static void logout(BuildContext context){
                  context.read<ProviderUserData>().logout();
                  context.read<ProviderSocket>().disconnectFromServer();
                  context.read<ProviderServices>().resetServices();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }

  static void home(BuildContext context){
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static createReport(BuildContext context){
    Navigator.of(context).push(HeroRoute(builder: ((context) {
            return const GenerateReport();
          })));
        }
  
}