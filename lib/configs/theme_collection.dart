import 'package:flutter/material.dart';

class CollectionTheme {
  ///Get collection theme
  ///
  /// primaryLight/primaryDark/brownLight/brownDark/pinkLight/pinkDark
  static ThemeData getCollectionTheme(
      {String theme = "primaryLight", String font = "Raleway"}) {
    switch (theme) {
      default:
        return ThemeData(
          primarySwatch: MaterialColor(4294359873, {
            50: Color(0xfffef6e7),
            100: Color(0xfffdeece),
            200: Color(0xfffadc9e),
            300: Color(0xfff8cb6d),
            400: Color(0xfff6b93c),
            500: Color(0xfff3a80c),
            600: Color(0xffc38609),
            700: Color(0xff926507),
            800: Color(0xff614305),
            900: Color(0xff312202)
          }),
          fontFamily: font,
          brightness: Brightness.light,
          primaryColor: Color(0xff5FB7A4),
          primaryColorBrightness: Brightness.dark,
          primaryColorLight: Color(0xfffdeece),
          primaryColorDark: Color(0xff5FB7A),
          accentColor: Color(0xff5FB7A4),
          accentColorBrightness: Brightness.dark,
          canvasColor: Color(0xfffafafa),
          scaffoldBackgroundColor: Color(0xfffafafa),
          bottomAppBarColor: Color(0xffffffff),
          cardColor: Color(0xffffffff),
          dividerColor: Color(0x1f000000),
          highlightColor: Color(0x66bcbcbc),
          splashColor: Color(0x66c8c8c8),
          selectedRowColor: Color(0xfff5f5f5),
          unselectedWidgetColor: Color(0x61000000),
          disabledColor: Color(0x61000000),
          buttonColor: Color(0xff5FB7A4),
          toggleableActiveColor: Color(0xff5FB7A4),
          secondaryHeaderColor: Color(0xfffef6e7),
          textSelectionColor: Color(0xff5FB7A4),
          cursorColor: Color(0xff4285f4),
          textSelectionHandleColor: Color(0xff5FB7A4),
          backgroundColor: Color(0xfffadc9e),
          dialogBackgroundColor: Color(0xffffffff),
          indicatorColor: Color(0xff5FB7A4),
          hintColor: Color(0x8a000000),
          errorColor: Color(0xffd32f2f),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent,
            minWidth: 88,
            height: 48,
            padding: EdgeInsets.only(left: 16, right: 16),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xff000000),
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            buttonColor: Color(0xff5FB7A4),
            disabledColor: Color(0x61000000),
            highlightColor: Color(0x29000000),
            splashColor: Color(0x1f000000),
            focusColor: Color(0x1f000000),
            hoverColor: Color(0x0a000000),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.only(
              top: 12,
              bottom: 12,
              left: 15,
              right: 15,
            ),
          ),
          chipTheme: ChipThemeData(
            backgroundColor: Color(0x1f000000),
            brightness: Brightness.light,
            deleteIconColor: Color(0xff5FB7A4),
            disabledColor: Color(0x0c000000),
            labelPadding: EdgeInsets.only(left: 8, right: 8),
            labelStyle: TextStyle(
              fontSize: 12,
              fontFamily: font,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
            secondaryLabelStyle: TextStyle(
              fontSize: 12,
              fontFamily: font,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            secondarySelectedColor: Color(0x3df6bb41),
            selectedColor: Color(0x3df6bb41),
            shape: StadiumBorder(
              side: BorderSide(
                color: Color(0xff000000),
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.white,
          ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
    }
  }

  ///Singleton factory
  static final CollectionTheme _instance = CollectionTheme._internal();

  factory CollectionTheme() {
    return _instance;
  }

  CollectionTheme._internal();
}
