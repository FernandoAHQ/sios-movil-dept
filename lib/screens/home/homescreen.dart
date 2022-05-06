import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/components/menu.dart';
import 'package:sios_v1/components/navBar.dart';
import 'package:sios_v1/constants.dart';
import 'package:sios_v1/models/authData.dart';
import 'package:sios_v1/providers/providerServices.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:sios_v1/screens/reports/generateReport.dart';
import 'package:sios_v1/screens/home/homescreenbody.dart';
import 'package:sios_v1/screens/login/loginScreen.dart';
import 'package:sios_v1/screens/reports/heroRoute.dart';
import 'package:sios_v1/screens/viewReport/viewReport.dart';
import 'package:sios_v1/style.dart';

import '../../providers/functions.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late BuildContext _context;
  bool menu = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final providerUser =
          Provider.of<ProviderUserData>(context, listen: false);
       final reportProvider =
          Provider.of<ProviderServices>(context, listen: false);
      reportProvider.loadCategories();
      reportProvider.loadHistory(providerUser.data.user!.sId.toString());

      context.read<ProviderSocket>().connectToServer(context);
    }); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     double appbarHeight = 70;


    return Scaffold(
      backgroundColor: mainColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Functions.createReport(context),
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_to_queue),
      ),
      appBar: AppBar(
        backgroundColor: mainColor,
        shape: const Border(bottom: BorderSide(color: mainColor, width: 4)),
        elevation: 0,
      ),
      drawer: const NavBar(),
      body: HomeScreenBody(),
    );
  }



}
