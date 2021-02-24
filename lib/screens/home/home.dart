import 'package:betta/blocs/bloc.dart';
import 'package:betta/configs/config.dart';
import 'package:betta/utils/other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  LanguageBloc _languageBloc;
  List<Locale> _listLanguage = AppLanguage.supportLanguage;
  Locale _languageSelected = AppLanguage.defaultLanguage;

  @override
  void initState() {
    _languageBloc = BlocProvider.of<LanguageBloc>(context);
    super.initState();
  }

  Future<void> _changeLanguage() async {
    print("3333");
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _languageSelected = _languageSelected == _listLanguage[0]
          ? _listLanguage[1]
          : _listLanguage[0];
    });
    _languageBloc.add(
      ChangeLanguage(_languageSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110,
        leading: Container(
            child: Image.asset('assets/images/logo-betta.png', width: 120)),
        actions: [
          GestureDetector(
            onTap: () {
              _changeLanguage();
            },
            child: Container(
              height: 40,
              padding: EdgeInsets.only(right: 8),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      child: Text(
                        'EN',
                        style: TextStyle(
                            color: _languageSelected == _listLanguage[0]
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                          color: _languageSelected != _listLanguage[0]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                          color: _languageSelected == _listLanguage[0]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Text(
                        'TH',
                        style: TextStyle(
                            color: _languageSelected != _listLanguage[0]
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
      ),
    );
  }
}
