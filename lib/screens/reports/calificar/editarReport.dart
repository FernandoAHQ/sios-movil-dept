import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/models/report.dart';
import 'package:sios_v1/providers/providerServices.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/style.dart';

import '../../../providers/providerUserData.dart';




class EditReport extends StatefulWidget {
 // const EditReport({Key? key}) : super(key: key);
  Report report;

  EditReport(this.report, {Key? key}) : super(key: key);

  @override
  State<EditReport> createState() => _EditReportState(report);
}

class _EditReportState extends State<EditReport> {
  String _selectedValue = "null";
  late String _title, _description, _category;
  Report report;

  final _formKey = GlobalKey<FormState>();

  _EditReportState(this.report);
  
      //: super(key: key);
  @override
  Widget build(BuildContext context) {
       Size size = MediaQuery.of(context).size;
      final _socket = Provider.of<ProviderSocket>(context);
      
    return  Scaffold(
      
      backgroundColor: Colors.transparent,
      body: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: SingleChildScrollView(
             keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Form(
                      key: _formKey,
                      child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: const BoxDecoration(color: accentColor1),
                            width: size.width*.85,
                            child: DefaultTextStyle(
                              style: reportFormStyle,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.edit,
                                        color: Colors.white,
                                        size: 80.0,),
                                  const Text("Editar Reporte", style: TextStyle(fontSize: 36.0),),
                                  
                                  const SizedBox(height: 25.0,),

                                  TextFormField(
                                    initialValue: report.title,
                                    style: reportFormStyle3,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                        
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ), 
                                        errorBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ),
                                           focusedErrorBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ),
                                      
                                      labelStyle: reportFormStyle2,
                                      labelText: "Título de Reporte"
                                      
                                      ),
                                      onSaved: (value){_title = value.toString();},
                                      validator: (value){
                                        if(value == null || value.isEmpty) return "Ingrese el Título del Reporte";
                                        return null;
                                      },
                                    ),
                                  const SizedBox(height: 15.0,),
                                  TextFormField(
                                    initialValue: report.description,
                                    style: reportFormStyle3,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ), 
                                        errorBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ),
                                           focusedErrorBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ),
                                      labelStyle: reportFormStyle2,
                                      labelText: "Descripción del Problema"),
                                      onSaved: (value){_description = value.toString();},
                                      validator: (value){
                                        if(value == null || value.isEmpty) return "Ingrese la Descripción del Problema";
                                        return null;
                                      },
                                      maxLines: 10,

                                    ),    
                                  const SizedBox(height: 15.0,),

 
                                  DropdownButtonFormField(
                                        
                                        dropdownColor: mainColor,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                       //   borderRadius: BorderRadius.circular(25.0),
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ),
                                        
                                        focusedBorder: OutlineInputBorder(
                                       //   borderRadius: BorderRadius.circular(25.0),
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ), 
                                        errorBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ), 
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusColor: Colors.black,
                                        ),
                                        style: reportFormStyle2,
                                        value: _selectedValue,
                                        onSaved: (value){_category = value.toString();},
                                        onChanged: (String? newValue){
                                          setState(() {
                                            _selectedValue = newValue!;
                                          });
                                        },
                                        items: dropOptions,
                                        validator: (value){
                                        if(value == "null") return "Seleccione una categoría";
                                        return null;
                                      },
                                        ),


                                  const SizedBox(height: 15.0,),

                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       MaterialButton( 
                                        // key: _formKey,     
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancelar", style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 26.0),
                                                  ),
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(2), side: const BorderSide(color: Colors.white) ),
                                        
                                        
                                        ),

                                       MaterialButton( 
                                          onPressed: (){
                                                if (_formKey.currentState!.validate()) {
                                                  _formKey.currentState!.save();
                                                  _socket.editReport(title: _title, description: _description, category: _category, id: report.sId.toString());
                                                  int count = 0;
                                                  Navigator.of(context).popUntil((_) => count++ >= 2);
                                                }
                                        },
                                        child: const Text("Enviar", style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 26.0),
                                                  ),
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(2), side: const BorderSide(color: Colors.white), ),
                                        
                                        ),
                                     ],
                                   )                                  
                                ],
                              )
                            ),
                          ),
                    ),
                  ),
                 
              ]
                  ),
          ),
        ),
      
    );
  
  } 
List<DropdownMenuItem<String>> get dropOptions{
  List cats = context.read<ProviderServices>().getCategories();
  List<DropdownMenuItem<String>> menuItems = [];
  menuItems.add(const DropdownMenuItem(child: Text("Seleccionar"), value: "null"));
   
  for(int i = 0; i < cats.length; i++){
    menuItems.add(
      DropdownMenuItem(child: Text(cats[i].toString()), value: cats[i].toString(),)
    );
  }
  return menuItems;
}

}
