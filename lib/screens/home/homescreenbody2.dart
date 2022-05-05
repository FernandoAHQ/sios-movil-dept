
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/reportTile.dart';
import '../../models/report.dart';
import '../../models/service.dart';
import '../../providers/providerServices.dart';
import '../../style.dart';
import '../viewReport/viewReport.dart';

class HomeScreenBody2 extends StatelessWidget {
  HomeScreenBody2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ProviderServices>(context);

    Size size = MediaQuery.of(context).size;

    return Container(

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
        child: TabBar(
          tabs: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    borderRadius: BorderRadius.circular(50), color: mainColor),
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
        ));
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
