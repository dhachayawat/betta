import 'package:flutter/material.dart';
import 'package:betta/configs/config.dart';
import 'package:betta/models/model.dart';
import 'package:betta/models/screen_models/screen_models.dart';
import 'package:betta/screens/home/home_category_item.dart';
import 'package:betta/screens/home/home_category_list.dart';
import 'package:betta/screens/home/home_sliver_app_bar.dart';
import 'package:betta/utils/utils.dart';
import 'package:betta/widgets/widget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: ,
        title: Text(Translate.of(context).translate('change_language')),
      ),
      body: Container(
        alignment: Alignment.center,
      ),
    );
  }
}
