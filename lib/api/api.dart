import 'dart:async';

import 'package:betta/models/model.dart';
import 'package:betta/utils/utils.dart';

class Api {
  ///Get Product List
  static Future<dynamic> getProduct() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/product_list.json");
    return ResultApiModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
