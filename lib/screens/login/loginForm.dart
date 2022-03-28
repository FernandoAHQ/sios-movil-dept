import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/constants.dart';
import 'package:flutter/services.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:sios_v1/screens/welcome/welcomeScreen.dart';
import 'package:sios_v1/style.dart';
//import 'package:sios_v1/services/services.dart' as service;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // ignore: unused_field
  late String _user;
  // ignore: unused_field
  late String _password;

  late bool _passwordVisible;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      //context.read<ProviderSocket>().disconnect();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final providerUser = Provider.of<ProviderUserData>(context);
    bool _isLoading = providerUser.isLoading;

    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,

        children: [
          SizedBox(height: size.height * .2),
          Image.asset(
            "assets/images/logo.png",
            height: size.height * .3,
          ),
          const Text(
            "¡Bienvenido!",
            style: TextStyle(
                fontSize: 32, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Inicia sesión para continuar",
            style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 87, 87, 87),
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Container(
            child: TextFormField(
              style: const TextStyle(fontSize: 24, color: mainColor),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 4,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: const InputDecoration(
                  hintText: "Usuario",
                  icon: Icon(
                    Icons.person,
                    color: accentColor1,
                  ),
                  border: InputBorder.none),
              onSaved: (value) {
                _user = value.toString();
              },
              validator: (value) {
                if (value!.isEmpty || value.length != 4) {
                  return "Usuario Invalido";
                } else {
                  return null;
                }
              },
              textInputAction: TextInputAction.next,
            ),
            width: MediaQuery.of(context).size.width * .85,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: accentColorLight,
              borderRadius: BorderRadius.circular(29),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Container(
            child: TextFormField(
              style: const TextStyle(fontSize: 24, color: mainColor),
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                  hintText: "Contraseña",
                  icon: const Icon(
                    Icons.lock,
                    color: accentColor1,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                        print(_passwordVisible);
                      });
                    },
                  ),
                  border: InputBorder.none),
              onSaved: (value) {
                _password = value.toString();
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Contraseña Invalida";
                } else {
                  return null;
                }
              },
            ),
            width: MediaQuery.of(context).size.width * .85,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: accentColorLight,
              borderRadius: BorderRadius.circular(29),
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: SizedBox(
              child: MaterialButton(
                onPressed: () async => {
                  if (_formKey.currentState!.validate())
                    {
                      _formKey.currentState!.save(),
                      print(_user + ", " + _password + "\n"),
                      if (!providerUser.isLoading)
                        {
                          if (await providerUser.authUser(_user, _password))
                            {
                              print("PASSED"),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen()))
                            }
                          else
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Datos Incorrectos"),
                              ))
                            }
                        }
                    }
                },
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0),
                      ),
                color: accentColor1,
              ),
              width: MediaQuery.of(context).size.width * .85,
              height: MediaQuery.of(context).size.height * .07,
            ),
          ),
        ],
      ),
    );
  }
}
