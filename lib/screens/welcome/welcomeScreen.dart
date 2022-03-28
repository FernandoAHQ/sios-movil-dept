import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/constants.dart';
import 'package:sios_v1/providers/providerSockets.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:sios_v1/screens/home/homescreen.dart';
import 'package:sios_v1/screens/login/loginScreen.dart';
import 'package:sios_v1/style.dart';

class WelcomeScreen extends StatelessWidget {
  String _user = "";

  // const WelcomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<ProviderUserData>(context);
    final socketProvider = Provider.of<ProviderSocket>(context);

    _user = "";
    _user = providerUser.data.user?.name as String;

    return Scaffold(
      body: createBody(context, _user),
    );
  }

  Widget createBody(BuildContext context, String user) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
          // color: Colors.red,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "¡Bienvenido, " + user + "!",
              style: loginHeadStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: SizedBox(
              child: MaterialButton(
                onPressed: () => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()))
                },
                child: const Text(
                  "Ok :3",
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
