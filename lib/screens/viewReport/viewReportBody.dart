import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/components/reportTile.dart';
import 'package:sios_v1/main.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/style.dart';

import '../../providers/providerUserData.dart';
import '../reports/calificar/calificarReport.dart';
import '../reports/generateReport.dart';
import '../reports/heroRoute.dart';

class ViewReportBody extends StatefulWidget {



  final Report _report;
  const ViewReportBody(this._report);



  @override
  State<ViewReportBody> createState() => _ViewReportBodyState(_report);
}

class _ViewReportBodyState extends State<ViewReportBody> {
    final Report _report;
  _ViewReportBodyState(this._report);


  
  


  //  String profilePic = providerUser.data.user != null ? providerUser.data.user!.image: "";

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
 
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: mainColor,
        border: Border(
            top: BorderSide(width: 6.0, color: mainColor),

        ),
      ),
      child: Column(children: [
        const SizedBox(height: 15.0),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
            
              // Column(
              //   // mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,

              //   children: [
              //     const Text("Hola",
              //           style: TextStyle(color: Colors.white, fontSize: 18)),
                  
              //     Text(
              //       context.read<ProviderUserData>().data.user?.name ?? "",
              //       style: headStyle,
              //     )
              //   ],
              // )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
                  height: 80,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                       // width: size.width,
                        padding: const EdgeInsets.all(2),
                      //  decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.black, width: 2))),
                        child: buildReportView(size)
                      ),
                      
                    ],
                  ))),
        ),
        
      ]),
    );
  }

  Widget buildReportView(Size _size){
    
    String _desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sed imperdiet nunc. Nulla in diam sed orci aliquet commodo. Praesent molestie sed neque at bibendum. Curabitur ut sollicitudin justo. In hendrerit eros quam, at luctus tortor dictum sed. Maecenas non dui sapien. Quisque vitae quam sed tellus laoreet euismod sed non ex. Proin at enim vitae purus ultricies volutpat at sed magna. Donec lacinia aliquet libero vitae gravida. Nulla lorem libero, pulvinar id molestie quis, semper ut nisl. Aliquam venenatis tincidunt sapien id lobortis. Donec ac ultrices nulla, ac ultricies eros. Quisque placerat ex id dignissim lobortis. Quisque enim purus, fermentum quis ligula in, vestibulum vulputate ante. Nunc ex mauris, porttitor in molestie sed, interdum quis nibh.";
    
    String _time = _report.createdAt.toString();
    if(_time.length > 12) _time = _time.substring(0, 10);
    return SizedBox(
      width: _size.width * 0.8,
      child: Column(
        
        children:  [
           
                    Text(_report.title!, style: h1Style,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
  
          const SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(_report.category!, style: h3Style,),
                   Text(_time,  overflow: TextOverflow.ellipsis, style: h4Style,),
                ],
              ),
              const SizedBox(width: 50.0),
              buildProgressLabel(),
            ],
          ),
          const SizedBox(height: 30.0,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Descripción:", style: descStyle,),
                    Text(_report.description!, style: h3Style,),
              
                    const SizedBox(height: 30.0,),
              
                    true ? Column(
                      children: [
                        const Text("Asignado a:", style: descStyle),
                    const SizedBox(height: 10.0,),
                     Row(
                      children: [
                           ClipRRect(
                              child: FadeInImage.assetNetwork(
                                 width: 50,
                                 height: 50,
                                 image: "https://preview.redd.it/v0caqchbtn741.jpg?auto=webp&s=c5d05662a039c031f50032e22a7c77dfcf1bfddc",//context.read<ProviderUserData>().data.user?.image ?? "",
                                 placeholder: 'assets/images/profilePlaceholder.png',
                               ),
                              borderRadius: BorderRadius.circular(50),
                           ),
                          const SizedBox(width: 15.0,),
                          const Text("Niña Tucan #5", style: h3Style,)
                      ],
                    ),
                      ],
                    ) : const SizedBox(height: 25.0,),

                    
                    
                  ],
                  
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: calificar, 
                    
                    style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            mainColor
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              //side: BorderSide(color: Colors.red)
                            )
                          )
                        ),
                    child: const Text("Calificar Servicio", style: buttonStyle,),
                  )
        ],
      ),
    );
  }

    Widget buildProgressLabel(){
        return 
          ClipRRect(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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

void calificar(){
 
          Navigator.of(context).push(HeroRoute(builder: ((context) {
              return const CalificarReport();
          })));
        
}

}

