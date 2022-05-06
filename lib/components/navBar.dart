import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/components/menuItem.dart';
import 'package:sios_v1/providers/functions.dart';
import 'package:sios_v1/style.dart';

import '../providers/providerUserData.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: mainColor,
     child: Column(
       children: [
         const SizedBox(height: 50,),
        Container(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: FadeInImage.assetNetwork(
                  width: 60,
                  height: 60,
                  image:
                      context.read<ProviderUserData>().data.user?.image ?? "",
                  placeholder: 'assets/images/profilePlaceholder.png',
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
             
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
          MenuItem(title: "Inicio", icon: Icons.home, callback: ()=>Functions.home(context)),
          MenuItem(title: "Crear Reporte", icon: Icons.report_problem, callback: ()=>Functions.createReport(context)),
          MenuItem(title: "Ajustes", icon: Icons.settings, callback: ()=>{}),
          MenuItem(title: "Cerrar Session", icon: Icons.logout, callback: ()=>{Functions.logout(context)}),

       ],
     ),
    );
  }
}