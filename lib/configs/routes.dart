import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:betta/screens/screen.dart';

class Routes {
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String productDetail = "/productDetail";
  static const String productDetailTab = "ProductDetailTab";
  static const String searchHistory = "/searchHistory";
  static const String category = "/category";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String contactUs = "/contactUs";
  static const String chat = "/chat";
  static const String aboutUs = "/aboutUs";
  static const String gallery = "/gallery";
  static const String photoPreview = "/photoPreview";
  static const String themeSetting = "/themeSetting";
  static const String listProduct = "/listProduct";
  static const String filter = "/filter";
  static const String review = "/review";
  static const String writeReview = "/writeReview";
  static const String location = "/location";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String chooseLocation = "/chooseLocation";

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case changeLanguage:
        return MaterialPageRoute(
          builder: (context) {
            return LanguageSetting();
          },
        );

      case themeSetting:
        return MaterialPageRoute(
          builder: (context) {
            return ThemeSetting();
          },
        );

      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return Setting();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
