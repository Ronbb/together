import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key, this.selected = 0}) : super(key: key);

  final int selected;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final _menu = <HomeDrawListItem>[
    HomeDrawListItem(
      label: "Daily",
      icon: Icons.repeat,
      onTap: () {},
    ),
    HomeDrawListItem(
      label: "Plan",
      icon: Icons.outlined_flag,
      onTap: () {},
    ),
    HomeDrawListItem(
      label: "Anniversary",
      icon: Icons.redeem,
      onTap: () {},
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          buildHead(),
          SliverPadding(
            padding: EdgeInsets.only(top: 8.0, right: 4.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4.0),
                    child:
                        buildMenuItem(item: _menu[index],isSelected: index == widget.selected,),
                  );
                },
                childCount: _menu.length,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: buildAboutFooter(context),
            ),
          ),
        ],
      ),
    );
  }

  AboutListTile buildAboutFooter(BuildContext context) {
    return AboutListTile(
      child: Text(
        'About Together',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.overline,
      ),
    );
  }

  Material buildMenuItem({
    @required HomeDrawListItem item,
    @required bool isSelected,
  }) {
    return Material(
      elevation: 1.0,
      child: InkWell(
        onTap: item.onTap,
        child: Container(
          height: 56,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              Icon(
                item.icon,
                color: isSelected ? Colors.blue : Colors.blueGrey,
              ),
              SizedBox(width: 16.0),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.blue[800] : Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar buildHead() {
    return SliverAppBar(
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
    );
  }
}

@immutable
class HomeDrawListItem {
  final String label;
  final IconData icon;
  final void Function() onTap;

  const HomeDrawListItem({
    @required this.label,
    @required this.icon,
    @required this.onTap,
  });
}
