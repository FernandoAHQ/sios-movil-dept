
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class StatusLabel extends StatelessWidget {
  var width;
  String state;

  StatusLabel({required this.state, this.width});



  @override
  Widget build(BuildContext context){

    Color color;
     switch(state){
            case "not-assigned":{
              color = mainColor;
              break;
            }
            default:{ 
              color = Colors.green;
            }
          }
          
          
          return 
          ClipRRect(
            child: Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: color)),
              child:  Text(
                 state,
                 textAlign: TextAlign.center,
                style: TextStyle(color: color, fontSize: 18),
              ),
            ),
          );
  }
  
  }

