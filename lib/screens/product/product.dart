import 'package:betta/api/api.dart';
import 'package:betta/configs/language.dart';
import 'package:betta/models/model.dart';
import 'package:betta/models/screen_models/screen_models.dart';
import 'package:betta/screens/product/product_card_time.dart';
import 'package:betta/screens/product/product_sliver_app_bar.dart';
import 'package:betta/utils/utils.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  Product({Key key}) : super(key: key);

  @override
  _ProductState createState() {
    return _ProductState();
  }
}

class _ProductState extends State<Product> {
  ProductListPageModel _productPage;
  Locale _languageSelected = AppLanguage.defaultLanguage;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getProduct();
    if (result.success) {
      setState(() {
        _productPage = ProductListPageModel.fromJson(result.data);
      });
    }
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     elevation: 3,
        //     leadingWidth: 110,
        //     leading: Container(
        //         child: Image.asset('assets/images/logo-betta.png', width: 120)),
        //     actions: []),
        body: Column(
      children: [
        Container(
          height: 140,
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
                              height: 56)),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                            'Dummy ${index % 2 == 0 ? "Card" : ""}')),
                                  ),
                                ),
                                Container(
                                  // alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 5),
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color:
                                        index == 1 ? Colors.blue : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ),
              Container(
                width: 110,
                // color: Colors.amber,
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: Image.asset('assets/images/logo-kidde-white.png',
                          height: 56),
                    )),
                    Divider(
                      color: Colors.grey,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/icons/facebook-black.png',
                            height: 32),
                        Image.asset('assets/icons/instagram-black.png',
                            height: 32),
                        Image.asset('assets/icons/line-black.png', height: 32)
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromRGBO(243, 241, 242, 1),
            child: Row(
              children: [
                Container(
                  // color: Colors.grey,
                  width: 240,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_drop_down),
                            Text(Translate.of(context).translate('price'))
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Divider()),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_drop_down),
                            Text(Translate.of(context).translate('series'))
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Divider()),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_drop_down),
                            Text(Translate.of(context).translate('type'))
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Divider()),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_drop_down),
                            Text(Translate.of(context).translate('size'))
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Divider()),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_drop_down),
                            Text(Translate.of(context).translate('material'))
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Divider())
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  // color: Colors.green,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: _buildProductCard(),
                ))
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildProductCard() {
    if (_productPage?.list == null) {
      return Center();
    }
    Locale myLocale = Localizations.localeOf(context);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 0.7,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final item = _productPage.list[index];
          return ProductCardItem(item: item, local: myLocale);
        },
        itemCount: _productPage.list.length);
  }
}
