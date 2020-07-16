import 'package:flutter/material.dart';
import 'package:together/layout/bottom_app_bar_shape.dart';
import 'package:together/page/home/home_page.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverList(delegate: SliverChildListDelegate([])),
            SliverAppBar(
              elevation: 4,
              forceElevated: true,
              title: Text('title'),
              centerTitle: true,
              leading: Icon(Icons.menu),
            ),
          ];
        },
        body: Container(
          child: HomePage(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: BottomAppBarShape(),
        elevation: 8,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.home),
                    Text('home')
                  ],
                ),
              ),
              fit: FlexFit.tight,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.dashboard),
              ),
              fit: FlexFit.tight,
            ),
          ],
        ),
      ),
    );
  }
}
