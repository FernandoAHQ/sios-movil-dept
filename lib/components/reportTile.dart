
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sios_v1/components/statusLabel.dart';
import 'package:sios_v1/style.dart';

enum ReportPriority {
  Urgent,
}

enum ReportState { Progreso, Asignado, Completado, Cancelado }

class ReportTile extends StatelessWidget {

  String blueIcon = "assets/icons/status/Blue-Status-Icon.png";
  String orangeIcon = "assets/icons/status/Orange-Status-Icon.png";
  String greenIcon = "assets/icons/status/Green-Status-Icon.png";
  String redIcon = "assets/icons/status/Red-Status-Icon.png";
  

  late String _title, _subtitle;
  late  String _time;
  String _reportState;

  late Widget label;

  late String icon;

  ReportTile(this._title, this._subtitle, this._time, this._reportState,
      {Key? key}){

        _title = _title.length > 20 ? _title.substring(0, 15) +'...' : _title;
        _subtitle = _subtitle.length > 22 ? _subtitle.substring(0, 20)+'...' : _subtitle;
       // _time = 

         
      }
      //: super(key: key);

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color.fromARGB(255, 202, 202, 202)))
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
            child: SizedBox(
              width: size.width*.5,
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: h2Style,
                  ),
                  Text(
                    _subtitle,
                    style: h3Style,
                  ),
                  Text(
                  _time
                    ,
                    style: h4Style,
                  ),
                ],
              ),
            ),
          ),
          StatusLabel(state: _reportState, width: size.width*.35)
   
        ],
      ),
    );
  }

 

}
