
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateParser extends StatelessWidget {

  String blueIcon = "assets/icons/status/Blue-Status-Icon.png";
  String orangeIcon = "assets/icons/status/Orange-Status-Icon.png";
  String greenIcon = "assets/icons/status/Green-Status-Icon.png";
  String redIcon = "assets/icons/status/Red-Status-Icon.png";
  

  DateTime date;

  DateParser(this.date,
      {Key? key}){


      //: super(key: key);


}

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
            ),
          ),
          //label
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
  }

