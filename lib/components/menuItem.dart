
import 'package:flutter/material.dart';
import 'package:sios_v1/style.dart';

class MenuItem extends StatelessWidget {

  String title;
  Function callback;
  IconData icon;
  

  MenuItem({Key? key, required this.title, required this.callback, required this.icon}) : super(key: key) {
   
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: ()=>{callback()},
      child: Container(
        decoration: const BoxDecoration(color: accentColor1, border: Border(bottom: BorderSide(style: BorderStyle.solid, width: 1.0, color: Color.fromARGB(179, 255, 255, 255)))),
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: menuItemStyle,),
             Icon(icon, color: menuItemStyle.color,)
          ],
        ),
      ),
    );
  }
}
