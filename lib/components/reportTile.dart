
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
  late  String _time;
  var _reportState;

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
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
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
          buildLabel(size.width*.3)
   
        ],
      ),
    );
  }

  Widget buildLabel(width){
     switch(Random().nextInt(3)){
            case 0:{
              label = buildProgressLabel(width);
              icon = blueIcon;
              break;
            }
            case 1:{
              label = buildCompleteLabel(width);
              icon = redIcon;
              break;
            }
            case 2:{
              label = buildCancelledLabel(width);
              icon = orangeIcon;
              break;
            }
          }
          return label;
  }

  Widget buildCompleteLabel(width){
        return 
          ClipRRect(
            child: Container(
              width: width,
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

  Widget buildProgressLabel(width){
        return 
          ClipRRect(
            child: Container(
              width: width,
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

  Widget buildCancelledLabel(width){
        return 
          ClipRRect(
            child: Container(
              width: width,
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
