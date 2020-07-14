import 'package:flutter/material.dart';
import 'package:together/page/home/home_page.dart';

class Layout extends StatefulWidget {
  Layout({Key key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(),
          ];
        },
        body: Container(
          child: HomePage(),
        ),
      ),
    );
  }
}
