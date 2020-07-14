import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalWrapper extends StatefulWidget {
  final Widget root;
  GlobalWrapper({Key key, @required this.root}) : super(key: key);

  @override
  _GlobalWrapperState createState() => _GlobalWrapperState();
}

class _GlobalWrapperState extends State<GlobalWrapper> {
  Brightness get brightness => MediaQuery.platformBrightnessOf(context);
  Brightness get oppositeBrightness =>
      brightness == Brightness.light ? Brightness.dark : Brightness.light;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: widget.root,
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: oppositeBrightness,
      ),
    );
  }
}
