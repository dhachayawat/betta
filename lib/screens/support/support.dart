import 'package:betta/widgets/app_logo_header_social.dart';
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
        body: Column(children: [
      Container(
        height: 110,
        color: Colors.white,
        padding: EdgeInsets.only(top: 20, left: 8, right: 8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Image.asset('assets/images/logo-betta.png',
                            height: 40)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                    ),
                  )
                ],
              )),
            ),
            AppLogoHeaderSocial()
          ],
        ),
      )
    ]));
  }
}
