import 'package:flutter/material.dart';
import 'package:betta/screens/screen.dart';
import 'package:betta/utils/utils.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainNavigation extends StatefulWidget {
  MainNavigation({Key key}) : super(key: key);

  @override
  _MainNavigationState createState() {
    return _MainNavigationState();
  }
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  var _bottomNavIndex = 0; //default index of first screen

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  final _labelMenu = <String>['product', 'story', 'store', 'support'];

  final iconList = <IconData>[
    Icons.shopping_cart,
    Icons.description,
    Icons.store,
    Icons.explore,
  ];

  @override
  void initState() {
    _fcmHandle();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
    super.initState();
  }

  ///Support Notification listen
  void _fcmHandle() async {
    await Future.delayed(Duration(seconds: 2));
  }

  ///On change tab bottom menu
  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  ///List bottom menu
  List<BottomNavigationBarItem> _bottomBarItem(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: Translate.of(context).translate('home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark),
        label: Translate.of(context).translate('wish_list'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: Translate.of(context).translate('message'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: Translate.of(context).translate('notification'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: Translate.of(context).translate('account'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Home(),
          Home(),
          Home(),
          Home(),
          Home(),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.home,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _bottomNavIndex = 4;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 80,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color =
              isActive ? Theme.of(context).textSelectionColor : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 32,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(Translate.of(context).translate(_labelMenu[index]),
                    style: TextStyle(color: color)),
              )
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: Colors.greenAccent,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => _onItemTapped(index),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: _bottomBarItem(context),
      //   currentIndex: _selectedIndex,
      //   type: BottomNavigationBarType.fixed,
      //   unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      //   selectedItemColor: Theme.of(context).primaryColor,
      //   showUnselectedLabels: true,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
