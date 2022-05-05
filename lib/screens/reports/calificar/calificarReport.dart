import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/models/service.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/style.dart';

import '../../../components/starRating.dart';

class CalificarReport extends StatefulWidget {
  Service service;
   CalificarReport(this.service, {Key? key}) : super(key: key);

  // GenerateReport();

  @override
  State<CalificarReport> createState() => _CalificarReportState(service);
}

class _CalificarReportState extends State<CalificarReport> {
  String _selectedValue = "null";
  late String _comment;

  final _formKey = GlobalKey<FormState>();
  Service service;

  _CalificarReportState(this.service);

  set rating(double rating) {}

  //: super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _socket = Provider.of<ProviderSocket>(context);
    int _rating = 5;

    return Scaffold(
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
                const SizedBox(
                  height: 50.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(color: accentColor1),
                      width: size.width * .85,
                      child: DefaultTextStyle(
                          style: reportFormStyle,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Calificar Servicio",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 36.0,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                style: reportFormStyle3,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        width: 1.0,
                                      ),
                                    ),
                                    labelStyle: reportFormStyle2,
                                    labelText: "Comentario"),
                                onSaved: (value) {
                                  _comment = value.toString();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Escriba una retroalimentación del servicio";
                                  }
                                  return null;
                                },
                                maxLines: 4,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              
                              RatingBar.builder(
                                initialRating: 2.5,
                                minRating: 0.5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  _rating = (rating*2).toInt();
                                },
                              ),

                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    // key: _formKey,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 26.0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                  ),
                                  MaterialButton(
                                    //    key: _formKey,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        _socket.rateService(service, _comment, _rating);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text(
                                      "Enviar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 26.0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
 

  List<DropdownMenuItem<String>> get dropOptions {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text("Eliga una Categoría"), value: "null"),
      DropdownMenuItem(child: Text("Conectividad"), value: "conn"),
      DropdownMenuItem(child: Text("Mantenimiento"), value: "mtto"),
      DropdownMenuItem(child: Text("Otro"), value: "other"),
    ];
    return menuItems;
  }
}
