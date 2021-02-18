import 'package:flutter/material.dart';
import 'package:betta/screens/screen.dart';
import 'package:betta/utils/utils.dart';

class MainNavigation extends StatefulWidget {
  MainNavigation({Key key}) : super(key: key);

  @override
  _MainNavigationState createState() {
    return _MainNavigationState();
  }
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _fcmHandle();
    super.initState();
  }

  ///Support Notification listen
  void _fcmHandle() async {
    await Future.delayed(Duration(seconds: 2));
  }

  ///On change tab bottom menu
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItem(context),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
