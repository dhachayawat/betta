import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  Store({Key key}) : super(key: key);

  @override
  _StoreState createState() {
    return _StoreState();
  }
}

class _StoreState extends State<Store> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          leadingWidth: 110,
          leading: Container(
              child: Image.asset('assets/images/logo-betta.png', width: 120)),
          actions: []),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
