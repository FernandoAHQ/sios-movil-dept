import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/constants.dart';
import 'package:sios_v1/models/authData.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:sios_v1/screens/reports/generateReport.dart';
import 'package:sios_v1/screens/home/homescreenbody.dart';
import 'package:sios_v1/screens/login/loginScreen.dart';
import 'package:sios_v1/screens/reports/heroRoute.dart';
import 'package:sios_v1/screens/viewReport/viewReportBody.dart';
import 'package:sios_v1/style.dart';

import '../../components/navBar.dart';
import '../../models/service.dart';

class ViewReport extends StatefulWidget {
  late Service _service;
  ViewReport(this._service);

  @override
  State<ViewReport> createState() => _ViewReportState(_service);
}

class _ViewReportState extends State<ViewReport> {
  late BuildContext _context;
  late Service service;
  _ViewReportState(this.service);
  
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
     // final providerUser = Provider.of<ProviderUserData>(context, listen: false);
    
     // context.read<ProviderSocket>().connectToServer(context);
    });

    //Future.delayed(Duration.).then((value) => _context.read<ProviderSocket>().connect());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: mainColor,
   
       appBar: AppBar(
        backgroundColor: mainColor,
        shape: const Border(bottom: BorderSide(color: mainColor, width: 4)),
        elevation: 0,
      ),
      drawer: const NavBar(),
      body: ViewReportBody(service),
    );
  }
 
}
