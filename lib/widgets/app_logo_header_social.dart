import 'package:betta/utils/utils.dart';
import 'package:flutter/material.dart';

class AppLogoHeaderSocial extends StatefulWidget {
  @override
  _AppLogoHeaderSocialState createState() => _AppLogoHeaderSocialState();
}

class _AppLogoHeaderSocialState extends State<AppLogoHeaderSocial> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('follow_us')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Image.asset('assets/icons/facebook-black.png',
                      height: 24),
                  title: Text("Dr.Betta Thailand - by Kidde"),
                ),
                ListTile(
                  leading: Image.asset('assets/icons/instagram-black.png',
                      height: 24),
                  title: Text("dr.bettathailand"),
                ),
                ListTile(
                  leading:
                      Image.asset('assets/icons/line-black.png', height: 24),
                  title: Text("@dr.bettath⁣"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Translate.of(context).translate('close')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMyDialog,
      child: Container(
        width: 90,
        color: Color(0x00000000),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child:
                  Image.asset('assets/images/logo-kidde-white.png', height: 48),
            )),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/facebook-black.png', height: 24),
                Image.asset('assets/icons/instagram-black.png', height: 24),
                Image.asset('assets/icons/line-black.png', height: 24)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
