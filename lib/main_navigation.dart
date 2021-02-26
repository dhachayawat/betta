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
  int _selectedIndex = 4;
  var _bottomNavIndex = 4; //default index of first screen

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
    double sizeFab = 60;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            IndexedStack(
              index: _bottomNavIndex,
              children: <Widget>[
                Product(),
                Story(),
                Store(),
                Support(),
                Home(),
              ],
            ),
            Positioned(
                bottom: 0,
                right: ((0.5 * MediaQuery.of(context).size.width) / 2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 85,
                        // color: const Color(0xFF0E3311).withOpacity(0.5),
                        alignment: Alignment.bottomCenter,
                        constraints: BoxConstraints(
                            maxWidth: 0.5 * MediaQuery.of(context).size.width),
                        child: Stack(
                          children: [
                            Container(
                              child: AnimatedBottomNavigationBar.builder(
                                height: 80,
                                itemCount: iconList.length,
                                tabBuilder: (int index, bool isActive) {
                                  final color = isActive
                                      ? Theme.of(context).textSelectionColor
                                      : Colors.grey;
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        iconList[index],
                                        size: 28,
                                        color: color,
                                      ),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                            Translate.of(context)
                                                .translate(_labelMenu[index]),
                                            style: TextStyle(
                                                color: color, fontSize: 14)),
                                      )
                                    ],
                                  );
                                },
                                backgroundColor: _bottomNavIndex == 4
                                    ? Color(0xFFFFFFFF).withOpacity(0.7)
                                    : Colors.white,
                                // backgroundColor: Color(0xFFFFFFFF).withOpacity(0.7),
                                activeIndex: _bottomNavIndex,
                                splashColor: Colors.greenAccent,
                                notchAndCornersAnimation: animation,
                                splashSpeedInMilliseconds: 300,
                                notchSmoothness: NotchSmoothness.defaultEdge,
                                gapLocation: GapLocation.none,
                                leftCornerRadius: 24,
                                rightCornerRadius: 24,
                                onTap: (index) => _onItemTapped(index),
                              ),
                            ),
                          ],
                        ),
                      )
                    ])),
            Positioned(
                bottom: 60,
                right: ((MediaQuery.of(context).size.width) - sizeFab) / 2,
                child: ScaleTransition(
                  scale: animation,
                  child: FloatingActionButton(
                    elevation: 3,
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
                ))
          ],
        ),
      ),
      // floatingActionButton: ScaleTransition(
      //   scale: animation,
      //   child: FloatingActionButton(
      //     elevation: 8,
      //     backgroundColor: Theme.of(context).primaryColor,
      //     child: Icon(
      //       Icons.home,
      //       color: Colors.white,
      //       size: 32,
      //     ),
      //     onPressed: () {
      //       setState(() {
      //         _bottomNavIndex = 4;
      //       });
      //     },
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar:
      //     Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      //   Container(
      //     height: 85,
      //     // color: const Color(0xFF0E3311).withOpacity(0.5),
      //     alignment: Alignment.bottomCenter,
      //     constraints: BoxConstraints(
      //         maxWidth: 0.5 * MediaQuery.of(context).size.width),
      //     child: Stack(
      //       children: [
      //         Container(
      //           child: AnimatedBottomNavigationBar.builder(
      //             height: 80,
      //             itemCount: iconList.length,
      //             tabBuilder: (int index, bool isActive) {
      //               final color = isActive
      //                   ? Theme.of(context).textSelectionColor
      //                   : Colors.grey;
      //               return Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Icon(
      //                     iconList[index],
      //                     size: 28,
      //                     color: color,
      //                   ),
      //                   const SizedBox(height: 4),
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 8),
      //                     child: Text(
      //                         Translate.of(context)
      //                             .translate(_labelMenu[index]),
      //                         style: TextStyle(color: color, fontSize: 14)),
      //                   )
      //                 ],
      //               );
      //             },
      //             backgroundColor: Colors.white,
      //             activeIndex: _bottomNavIndex,
      //             splashColor: Colors.greenAccent,
      //             notchAndCornersAnimation: animation,
      //             splashSpeedInMilliseconds: 300,
      //             notchSmoothness: NotchSmoothness.defaultEdge,
      //             gapLocation: GapLocation.none,
      //             leftCornerRadius: 24,
      //             rightCornerRadius: 24,
      //             onTap: (index) => _onItemTapped(index),
      //           ),
      //         ),
      //         Positioned(
      //             top: -30,
      //             right:
      //                 (0.5 * MediaQuery.of(context).size.width - sizeFab) / 2,
      //             child: ScaleTransition(
      //               scale: animation,
      //               child: FloatingActionButton(
      //                 elevation: 3,
      //                 backgroundColor: Theme.of(context).primaryColor,
      //                 child: Icon(
      //                   Icons.home,
      //                   color: Colors.white,
      //                   size: 32,
      //                 ),
      //                 onPressed: () {
      //                   setState(() {
      //                     _bottomNavIndex = 4;
      //                   });
      //                 },
      //               ),
      //             ))
      //       ],
      //     ),
      //   )
      // ])
    );
  }
}
