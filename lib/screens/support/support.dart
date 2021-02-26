import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  Support({Key key}) : super(key: key);

  @override
  _SupportState createState() {
    return _SupportState();
  }
}

class _SupportState extends State<Support> {
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
        color: Colors.green,
      ),
    );
  }
}
