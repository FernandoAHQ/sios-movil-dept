import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/components/reportTile.dart';
import 'package:sios_v1/main.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/providers/providerServices.dart';
import 'package:sios_v1/services/httpService.dart';
import 'package:sios_v1/style.dart';

import '../../models/service.dart';
import '../../providers/providerUserData.dart';
import '../reports/generateReport.dart';
import '../viewReport/viewReport.dart';

class HomeScreenBody extends StatelessWidget {
   HomeScreenBody({Key? key}) : super(key: key);




  //  String profilePic = providerUser.data.user != null ? providerUser.data.user!.image: "";



  @override
  Widget build(BuildContext context) {

    final reportProvider = Provider.of<ProviderServices>(context);
    //int _notificationCounter = ;

    print(reportProvider.getServices().length);

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: mainColor,
        border: Border(
            top: BorderSide(width: 6.0, color: mainColor),

        ),
      ),
      child: Column(children: [
        const SizedBox(height: 15.0),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: FadeInImage.assetNetwork(
                  width: 60,
                  height: 60,
//                  image: "https://preview.redd.it/v0caqchbtn741.jpg?auto=webp&s=c5d05662a039c031f50032e22a7c77dfcf1bfddc",
                  image: context.read<ProviderUserData>().data.user?.image ?? "",
                  placeholder: 'assets/images/profilePlaceholder.png',
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text("Hola",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  
                  Text(
                    context.read<ProviderUserData>().data.user?.name ?? "",
                    style: headStyle,
                  ),
                   Text(
                    context.read<ProviderUserData>().data.department?.name ?? "",
                    style: h4Style,
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
            child: Container(
                padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
                height: 80,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.black, width: 2))),
                      child: const Text(
                        "Hoy",
                        style: h2Style,
                      ),
                    ),
                    Text(
                      reportProvider.getServices().length.toString(),
                      style: const TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    )
                  ],
                ))),
        Expanded(
            child: Container(
          height: 200.0,
          decoration: BoxDecoration(

              color: Colors.white,
              
              border:  Border.all(color: Colors.white, width: 10)),
          child: buildListView(context, reportProvider.getServices().length),
        )),
      ]),
    );
  }

  void viewReport(BuildContext context, Service _srv){
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewReport(_srv)),
          );
  }


  Widget buildListView(BuildContext context, int ctr) => ListView.builder(
        itemCount: ctr,
        itemBuilder: (BuildContext context, int index) {
          Service _service = context.read<ProviderServices>().getServices().elementAt(index);
          Report _report = _service.getReport();
          String? _title = _report.title;//"Report Title: " + (index+1).toString();
          String? _cat = _report.category;
          var _time = _report.createdAt!;//"Vie. 28 Feb, 2:35 pm";

          return GestureDetector(
              child: ReportTile(_title!, _cat!, _time,
              _service.status),
              onTap: ()=> viewReport(context, _service),
          );
        },
      );
}
