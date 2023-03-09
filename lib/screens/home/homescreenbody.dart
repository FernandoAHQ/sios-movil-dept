import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/components/reportTile.dart';
import 'package:sios_v1/env.dart';
import 'package:sios_v1/main.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/providers/providerServices.dart';
import 'package:sios_v1/services/httpService.dart';
import 'package:sios_v1/style.dart';

import '../../models/service.dart';
import '../../providers/providerUserData.dart';
import '../viewReport/viewReport.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ProviderServices>(context);
    print(context.read<ProviderUserData>().data.user?.image);
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: mainColor,
        border: Border(
          top: BorderSide(width: 0, color: mainColor),
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
                  image:
                      urlBase + "/api/images/users/" + (context.read<ProviderUserData>().data.user?.image).toString(),
                  placeholder: 'assets/images/profilePlaceholder.png',
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text("Hola",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(
                    context.read<ProviderUserData>().data.user?.name ?? "",
                    style: headStyle,
                  ),
                  Text(
                    context.read<ProviderUserData>().data.department?.name ??
                        "",
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
        Expanded(
            child: Container(
                child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    height: 70.0,
                        decoration: BoxDecoration(color: Colors.white),
                    child: TabBar(
                      tabs: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Hoy",
                                style: h2Style,
                              ),
                              const SizedBox(width: 10),
                              Container(
                                alignment: AlignmentDirectional.center,
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: mainColor),
                                child: Text(
                                  reportProvider.getServices().length.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24),
                                ),
                              )
                            ]),
                        Container(
                          child: const Text(
                            "Historial",
                            style: h2Style,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      width: size.width,
                      child: TabBarView(
                        children: [
                          buildListView(context, reportProvider.getServices()),
                          buildListView(context, reportProvider.getHistory())
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        )))
      ]),
    );
  }
 

  Container buildTabBar(Size size, ProviderServices reportProvider) {
    return Container(
        padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
        height: 80,
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox());
  }

  void viewReport(BuildContext context, Service _srv) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewReport(_srv)),
    );
  }

  Widget buildListView(BuildContext context, List<dynamic> services) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (BuildContext context, int index) {
        Service _service = services.elementAt(index);
        Report _report = _service.getReport();
        String? _title =
            _report.title; //"Report Title: " + (index+1).toString();
        String? _cat = _report.category;
        var _time = _report.createdAt!; //"Vie. 28 Feb, 2:35 pm";

        return GestureDetector(
          child: ReportTile(_title!, _cat!, _time, _service.status),
          onTap: () => viewReport(context, _service),
        );
      },
    );
  }
}
