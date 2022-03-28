import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/constants.dart';
import 'package:sios_v1/models/authData.dart';
import 'package:sios_v1/providers/providerReports.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:sios_v1/screens/reports/generateReport.dart';
import 'package:sios_v1/screens/home/homescreenbody.dart';
import 'package:sios_v1/screens/login/loginScreen.dart';
import 'package:sios_v1/screens/reports/heroRoute.dart';
import 'package:sios_v1/screens/viewReport/viewReport.dart';
import 'package:sios_v1/style.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BuildContext _context;
 

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final providerUser =
          Provider.of<ProviderUserData>(context, listen: false);
      //        providerUser.resetToken();
      //      print("LOGIN FORM, TOKEN RESET");

      context.read<ProviderSocket>().connectToServer(context);
    });

    //Future.delayed(Duration.).then((value) => _context.read<ProviderSocket>().connect());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: mainColor,
      floatingActionButton: FloatingActionButton(

        onPressed: () => {
          Navigator.of(context).push(HeroRoute(builder: ((context) {
              return const GenerateReport();
          })))
          },
      backgroundColor: mainColor,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add_to_queue),
      ),
      appBar: PreferredSize(

        preferredSize: const Size.fromHeight(70),
        child: createBar(),
      ),
      //   body: Image(image:NetworkImage(providerUser.data.user?.image ?? "")),

      body:  HomeScreenBody(),
    );
  }

  AppBar createBar() {
    return AppBar(
       shape:const Border(
    bottom: BorderSide(
      color: mainColor,
      width: 4
    )
  ),
      elevation: 0,
     // bottomOpacity: 0,
     
      backgroundColor: mainColor,
      leading:  IconButton(
          icon: const Icon(
            Icons.menu,
            size: 50,
          ), 
          onPressed: () {
            
          },
          ),
      actions: [
        IconButton(
            onPressed: () => {
                  //WRITE METHOD IN PROVIDER TO LOG OUT!!!!
                  context.read<ProviderUserData>().logout(),
                  context.read<ProviderSocket>().disconnectFromServer(),
                  context.read<ProviderReports>().resetReports(),
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                },
            icon: const Icon(Icons.logout))
      ],
      
    );
  }
}