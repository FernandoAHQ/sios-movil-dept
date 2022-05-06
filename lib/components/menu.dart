
import 'package:flutter/material.dart';
import 'package:sios_v1/components/menuItem.dart';
import 'package:sios_v1/providers/functions.dart';
import 'package:sios_v1/screens/home/homescreen.dart';
import 'package:sios_v1/style.dart';

import '../providers/functions.dart';

class Menu extends StatelessWidget {
  late Function toggleMenu;

  Menu({Key? key, required Function toggleMenu}){
    this.toggleMenu = toggleMenu;
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width*.7,
      decoration: const BoxDecoration(
        color: mainColor
      ),
      child: Column(
        children: [
         
          
        ],
      ),
    );
  }

  
}
