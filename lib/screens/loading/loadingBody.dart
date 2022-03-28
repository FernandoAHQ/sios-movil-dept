import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:sios_v1/screens/home/homescreen.dart';
import 'package:sios_v1/screens/login/loginScreen.dart';
import 'package:sios_v1/style.dart';

import '../welcome/welcomeScreen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future checkToken(ProviderUserData provider, BuildContext context) async {
    if (await provider.authToken()) {
      print("TOKEN AUTHED");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print("TOKEN NOT VALID");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final providerUser =
          Provider.of<ProviderUserData>(context, listen: false);
      checkToken(providerUser, context);
    });
  }

  // const WelcomeScreen(this._user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createBody(),
    );
  }

  @override
  Widget createBody() {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
      //  color: mainColor,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Image.asset(
            "assets/images/logo.png",
            height: size.height * .3,
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                mainColor),
          ),
        )
      ]),
    );
  }
}
