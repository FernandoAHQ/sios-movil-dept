import 'package:flutter/material.dart';
import 'package:sios_v1/screens/login/loginForm.dart';
import 'package:sios_v1/style.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/circles/circles_bottom.png",
                width: size.width * .4,
              )),
          Positioned(
            top: 0,
            child: Image.asset(
              "assets/images/circles/circles_top.png",
              width: size.width,
            ),
          ),

          //     Image.asset("assets/images/circles/circle3.png", width: size.width*40,),
          //     Image.asset("assets/images/circles/circle4.png", width: size.width*40,),
          // SizedBox(height: size.height*.1,),
          //    const Text(
          //      "MarianitApp",
          //      style: loginHeadStyle),

          //    const SizedBox(height: 10.0),

          const LoginForm()
        ]),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
