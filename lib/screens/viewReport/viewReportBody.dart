import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/components/reportTile.dart';
import 'package:sios_v1/components/statusLabel.dart';
import 'package:sios_v1/main.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/models/service.dart';
import 'package:sios_v1/style.dart';

import '../../env.dart';
import '../../providers/providerUserData.dart';
import '../reports/calificar/calificarReport.dart';
import '../reports/calificar/editarReport.dart';
import '../reports/generateReport.dart';
import '../reports/heroRoute.dart';

class ViewReportBody extends StatefulWidget {



  final Service _service;
  const ViewReportBody(this._service);



  @override
  State<ViewReportBody> createState() => _ViewReportBodyState(_service);
}

class _ViewReportBodyState extends State<ViewReportBody> {
    final Service _service;
  _ViewReportBodyState(this._service);


  
  



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
                        padding: const EdgeInsets.all(0),
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
    
    Report _report = _service.getReport();

    
    String _time = _service.createdAt.toString();
    if(_time.length > 12) _time = _time.substring(0, 10);
    return SizedBox(
      width: _size.width * 0.8,
      child: Column(
        
        children:  [
           
                    Text(_report.title!, style: h1Style,
                    overflow: TextOverflow.fade),
  
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
            //  const SizedBox(width: 50.0),
              StatusLabel(state: _service.status),
            ],
          ),
          const SizedBox(height: 30.0,),
          Expanded(
            child: Container(
              width: _size.width * .8,
              child: SingleChildScrollView(
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Descripción:", style: descStyle,),
                    Text(_report.description!, style: h3Style,),
              
                    const SizedBox(height: 30.0,),
              
                    _service.report.isAssigned! ? Column(
                      children: [
                        const Text("Asignado a:", style: descStyle),
                    const SizedBox(height: 10.0,),
                     Row(
                      children: [
                           ClipRRect(
                              child: FadeInImage.assetNetwork(
                                 width: 50,
                                 height: 50,
                                 image: urlBase + "/api/images/users/" +  _service.asignedTo!.imgUrl.toString(),//context.read<ProviderUserData>().data.user?.image ?? "",
                                 placeholder: 'assets/images/profilePlaceholder.png',
                               ),
                              borderRadius: BorderRadius.circular(50),
                           ),
                          const SizedBox(width: 15.0,),
                           Text(_service.asignedTo!.name ?? "", style: h3Style,)
                      ],
                    ),
                      ],
                    ) : const SizedBox(height: 25.0,),

                    
                    
                  ],
                  
                ),
              ),
            ),
          ),

        

         _service.status == 'Terminado' ? 
                  ElevatedButton(onPressed: ()=>calificar(_service), 
                    
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
                  : SizedBox(),

                  !_report.isAssigned !? ElevatedButton(onPressed: () => editar(_report), 
                    
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
                    child: const Text("Editar Servicio", style: buttonStyle,),
                  ): SizedBox()
                  
        ],
      ),
    );
  }
 

void calificar(Service service){
 
          Navigator.of(context).push(HeroRoute(builder: ((context) {
              return  CalificarReport(service);
          })));
        
}
void editar(Report rep){
 
          Navigator.of(context).push(HeroRoute(builder: ((context) {
              return  EditReport(rep);
          })));
        
}

}

