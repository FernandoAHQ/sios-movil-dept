import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/style.dart';

import '../../../components/starRating.dart';

class CalificarReport extends StatefulWidget {
  const CalificarReport({Key? key}) : super(key: key);

  // GenerateReport();

  @override
  State<CalificarReport> createState() => _CalificarReportState();
}

class _CalificarReportState extends State<CalificarReport> {
  String _selectedValue = "null";
  late String _comment;

  final _formKey = GlobalKey<FormState>();

  set rating(double rating) {}

  //: super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _socket = Provider.of<ProviderSocket>(context);

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
                      height: size.height * .4,
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
                                    labelText: "Descripión del servicio"),
                                onSaved: (value) {
                                  _comment = value.toString();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "Ingrese la Descripción del Problema";
                                  return null;
                                },
                                maxLines: 4,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              StarRating(
                                rating: 0,
                                onRatingChanged: (rating) =>
                                    setState(() => this.rating = rating),
                                color: Colors.white,
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
                                        // _socket.sendReport(title: _title, description: _description, category: _category);
                                        //_socket.sendReport(_title, _description, _category);
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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
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
