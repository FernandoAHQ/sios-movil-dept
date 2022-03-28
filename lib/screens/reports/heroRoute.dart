

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroRoute<T> extends PageRoute<T>{
  late WidgetBuilder _builder;
  HeroRoute({
    required WidgetBuilder builder,
     RouteSettings? settings,
    bool fullScreenDialogue = false,
  })  : _builder = builder,
    super(settings: settings, fullscreenDialog: fullScreenDialogue);

  @override
  // TODO: implement barrierColor
  Color? get barrierColor => Colors.black54;

@override
  bool get opaque=>false;

  @override
  bool get barrierDismissible=>true;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => "xd";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return _builder(context);
  }

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(milliseconds: 300);
  


}