import 'package:flutter/material.dart';
import 'package:together/layout/home/bottom_app_bar_shape.dart';
import 'package:together/layout/home/home_drawer.dart';
import 'package:together/page/home/home_page.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key key}) : super(key: key);

  final double drawerWidth = 240.0;

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  ScrollController _scrollController;
  double scrollOffset = 0.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      value: 1.0,
      duration: Duration(milliseconds: 0),
    );
    _scrollController = ScrollController(
      initialScrollOffset: widget.drawerWidth,
    );
    _scrollController.addListener(() {
      if (_scrollController.offset <= 0) {
        if (scrollOffset != 1.0) {
          setState(() {
            scrollOffset = 1.0;
            try {
              // widget.drawerIsOpen(true);
            } catch (_) {}
          });
        }
        _animationController.animateTo(
          0.0,
          duration: Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
        );
      } else if (_scrollController.offset > 0 &&
          _scrollController.offset < widget.drawerWidth) {
        _animationController.animateTo(
          (_scrollController.offset * 100 / (widget.drawerWidth)) / 100,
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
        );
      } else if (_scrollController.offset <= widget.drawerWidth) {
        if (scrollOffset != 0.0) {
          setState(() {
            scrollOffset = 0.0;
            try {
              // widget.drawerIsOpen(false);
            } catch (_) {}
          });
        }
        _animationController.animateTo(
          1.0,
          duration: Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.jumpTo(
        widget.drawerWidth,
      ),
    );
    super.initState();
  }

  void handleDrawer() {
    if (_scrollController.offset != 0.0) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      _scrollController.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: Row(
          children: <Widget>[
            Container(
              width: widget.drawerWidth,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget child) {
                  // Make [child] stable when scrolling.
                  return Transform(
                    transform: Matrix4.translationValues(
                      _scrollController.offset,
                      0.0,
                      0.0,
                    ),
                    child: child,
                  );
                },
                child: HomeDrawer(),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: scrollOffset == 1 ? handleDrawer : null,
                child: IgnorePointer(
                  ignoring: scrollOffset == 1,
                  child: Scaffold(
                    body: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            actions: <Widget>[
                              AspectRatio(
                                aspectRatio: 1.0,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ],
                            forceElevated: true,
                            title: Text('title'),
                            centerTitle: true,
                            leading: IconButton(
                              icon: AnimatedIcon(
                                icon: AnimatedIcons.arrow_menu,
                                progress: _animationController,
                              ),
                              onPressed: handleDrawer,
                            ),
                          ),
                        ];
                      },
                      body: HomePage(),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.add),
                    ),
                    extendBody: true,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButtonAnimator:
                        FloatingActionButtonAnimator.scaling,
                    bottomNavigationBar: BottomAppBar(
                      clipBehavior: Clip.antiAlias,
                      shape: BottomAppBarShape(),
                      elevation: 8,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
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
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.dashboard),
                            ),
                            fit: FlexFit.tight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
