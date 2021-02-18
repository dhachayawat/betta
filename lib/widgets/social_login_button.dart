import 'package:flutter/material.dart';

class SocialLoginBotton extends StatefulWidget {
  final Color color;
  final Widget icon;
  final Widget text;
  final onTab;
  SocialLoginBotton(
      {Key key, @required this.icon, @required this.text, this.color, this.onTab})
      : assert(icon != null && text != null),
        super(key: key);
  @override
  _SocialLoginBottonState createState() => _SocialLoginBottonState();
}

class _SocialLoginBottonState extends State<SocialLoginBotton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: widget.color != null ? widget.color : Colors.white,
          child: InkWell(
              onTap: widget.onTab, // handle your onTap here
              child: Container(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 8),
                      alignment: Alignment.centerRight,
                      child: widget.icon,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      alignment: Alignment.centerLeft,
                      child: widget.text,
                    )
                  ],
                ),
              ))),
    );
  }
}
