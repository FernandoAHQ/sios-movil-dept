
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late String _time;
  var _reportState;

  late Widget label;

  late String icon;

  ReportTile(this._title, this._subtitle, this._time, this._reportState,
      {Key? key}){

        _title = _title.length > 20 ? _title.substring(0, 15) +'...' : _title;
        _subtitle = _subtitle.length > 22 ? _subtitle.substring(0, 20)+'...' : _subtitle;

         var rng = Random();
          switch(rng.nextInt(3)){
            case 0:{
              label = buildProgressLabel();
              icon = blueIcon;
              break;
            }
            case 1:{
              label = buildCompleteLabel();
              icon = redIcon;
              break;
            }
            case 2:{
              label = buildCancelledLabel();
              icon = orangeIcon;
              break;
            }
          }
      }
      //: super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color.fromARGB(255, 202, 202, 202)))
      ),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                  _time,
                  style: h4Style,
                ),
              ],
            ),
          ),
          label
          // ClipRRect(
          //   child: Container(
          //     padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          //     decoration: BoxDecoration(
          //         borderRadius: const BorderRadius.all(Radius.circular(50)),
          //         border: Border.all(color: Colors.green)),
          //     child: const Text(
          //       "Terminado",
          //       style: TextStyle(color: Colors.green, fontSize: 18),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget buildCompleteLabel(){
        return 
          ClipRRect(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.green)),
              child: const Text(
                "Terminado",
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
            ),
          );
  }

  Widget buildProgressLabel(){
        return 
          ClipRRect(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.orange)),
              child: const Text(
                "En Progreso",
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
            ),
          );
  }

  Widget buildCancelledLabel(){
        return 
          ClipRRect(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.red)),
              child: const Text(
                "Cancelado",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          );
  }

}
