
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
  Color? get barrierColor => Colors.black54;

@override
  bool get opaque=>false;

  @override
  bool get barrierDismissible=>true;

  @override
  String? get barrierLabel => "";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
 }