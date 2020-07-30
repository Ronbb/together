import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 192.0,
            forceElevated: true,
            flexibleSpace: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      radius: 32,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      Text('username'),
                      SizedBox(width: 8), // Move to left a little.
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 8.0, right: 4.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4.0),
                    child: Material(
                      elevation: 1.0,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 56,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                _testItem.icon,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 16.0),
                              Text(
                                _testItem.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.blue[800]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: 5,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: AboutListTile(
                child: Text(
                  'About Together',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _testItem = HomeDrawListItem(
  label: "Label",
  icon: Icons.notifications_active,
);

@immutable
class HomeDrawListItem {
  final String label;
  final IconData icon;

  HomeDrawListItem({
    @required this.label,
    @required this.icon,
  });
}
