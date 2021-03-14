import 'package:betta/api/api.dart';
import 'package:betta/models/model.dart';
import 'package:betta/models/screen_models/screen_models.dart';
import 'package:betta/screens/product/product_card_time.dart';
import 'package:flutter/services.dart';
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
  List<String> _productGroup = ["bottle", "accessories"];
  List<String> _productGroupName = ["Baby Bottle", "Accessories"];
  List<Color> _colorTab = [
    Color.fromRGBO(246, 137, 163, 1),
    Color.fromRGBO(166, 113, 159, 1)
  ];
  int _tabSelect = 0;
  int _minPrice = 0;
  int _maxPrice = 2000;
  RangeValues _currentRangeValues;
  final TextEditingController _startValueController = TextEditingController();
  final TextEditingController _endValueController = TextEditingController();
  FocusNode _focusStart = FocusNode();
  FocusNode _focusEnd = FocusNode();

  // แถบฟิลเตอร์
  bool _onFilter = true;

  // ตัวเลือก filter
  bool _onPrice = true;
  bool _onSize = false;
  bool _onSeries = false;
  bool _onType = true;
  bool _onMaterial = true;
  bool _onProductType = true;

  // ประเภทสินค้า
  bool _chkPdtBottle = false;
  bool _chkPdtBathing = false;
  bool _chkPdtMom = false;

  // ซีรี่
  bool _chkSeriesBrain = false;
  bool _chkSeriesJewel = false;

  // ประเภทขวด
  bool _chkTypeWide = false;
  bool _chkTypeSlim = false;

  // ขนาด
  bool _chkSize80 = false;
  bool _chkSize120 = false;
  bool _chkSize150 = false;
  bool _chkSize200 = false;
  bool _chkSize240 = false;
  bool _chkSize320 = false;

  // วัสดุ
  bool _chkMaterialGLASS = false;
  bool _chkMaterialPLASTIC = false;
  bool _chkMaterialPPSU = false;
  bool _chkMaterialPP = false;

  @override
  void initState() {
    _loadData();
    double max = 2000;
    _currentRangeValues = RangeValues(0, max);
    _startValueController.text = "0";
    _endValueController.text = max.round().toString();
    _focusStart.addListener(_outStart);
    _focusEnd.addListener(_outEnd);
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

  _outStart() {
    debugPrint("Focus: " + _focusStart.hasFocus.toString());
    if (!_focusStart.hasFocus) {
      var start = double.parse(_startValueController.text);
      assert(start is double);
      var end = double.parse(_endValueController.text);
      assert(end is double);
      if (start < _minPrice) {
        start = (_minPrice + 0.0);
      } else if (start > end) {
        start = end - 1;
      }
      setState(() {
        _startValueController.text = start.round().toString();
        _currentRangeValues = RangeValues(start, end);
      });
    }
  }

  _outEnd() {
    if (!_focusEnd.hasFocus) {
      var start = double.parse(_startValueController.text);
      assert(start is double);
      var end = double.parse(_endValueController.text);
      assert(end is double);
      if (end > _maxPrice) {
        end = (_maxPrice + 0.0);
      } else if (end < start) {
        end = start - 1;
      }
      setState(() {
        _endValueController.text = end.round().toString();
        _currentRangeValues = RangeValues(start, end);
      });
    }
  }

  Widget _optionSeries(int countSeriesBrain, int countSeriesJewel) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSeriesBrain = !_chkSeriesBrain;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSeriesBrain,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('brain')),
                    ],
                  ),
                ),
                Text(
                  "(${countSeriesBrain.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSeriesJewel = !_chkSeriesJewel;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSeriesJewel,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('jewel')),
                    ],
                  ),
                ),
                Text(
                  "(${countSeriesJewel.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionProductType(
      int countPdtBottle, int countPdtBathing, int countPdtMom) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _chkPdtBottle = !_chkPdtBottle;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkPdtBottle,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('baby_bottle')),
                    ],
                  ),
                ),
                Text(
                  "(${countPdtBottle.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkPdtBathing = !_chkPdtBathing;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkPdtBathing,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('bathing_goods')),
                    ],
                  ),
                ),
                Text(
                  "(${countPdtBathing.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkPdtMom = !_chkPdtMom;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkPdtMom,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('mom_items')),
                    ],
                  ),
                ),
                Text(
                  "(${countPdtMom.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionType(int countTypeWide, int countTypeSlim) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _chkTypeWide = !_chkTypeWide;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkTypeWide,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('wide_neck')),
                    ],
                  ),
                ),
                Text(
                  "(${countTypeWide.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkTypeSlim = !_chkTypeSlim;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkTypeSlim,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('slim_neck')),
                    ],
                  ),
                ),
                Text(
                  "(${countTypeSlim.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionProductSize(int countSize80, int countSize120, int countSize150,
      int countSize200, int countSize240, int countSize320) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSize80 = !_chkSize80;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSize80,
                        onChanged: (bool value) {},
                      ),
                      Text("80" + Translate.of(context).translate('ml')),
                    ],
                  ),
                ),
                Text(
                  "(${countSize80.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSize120 = !_chkSize120;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSize120,
                        onChanged: (bool value) {},
                      ),
                      Text("120" + Translate.of(context).translate('ml')),
                    ],
                  ),
                ),
                Text(
                  "(${countSize120.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSize150 = !_chkSize150;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSize150,
                        onChanged: (bool value) {},
                      ),
                      Text("150" + Translate.of(context).translate('ml')),
                    ],
                  ),
                ),
                Text(
                  "(${countSize150.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSize200 = !_chkSize200;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSize200,
                        onChanged: (bool value) {},
                      ),
                      Text("200" + Translate.of(context).translate('ml')),
                    ],
                  ),
                ),
                Text(
                  "(${countSize200.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSize240 = !_chkSize240;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSize240,
                        onChanged: (bool value) {},
                      ),
                      Text("240" + Translate.of(context).translate('ml')),
                    ],
                  ),
                ),
                Text(
                  "(${countSize240.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkSize320 = !_chkSize320;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkSize320,
                        onChanged: (bool value) {},
                      ),
                      Text("320" + Translate.of(context).translate('ml')),
                    ],
                  ),
                ),
                Text(
                  "(${countSize320.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionMaterial(int countMaterialGLASS, int countMaterialPLASTIC,
      int countMaterialPPSU, int countMaterialPP) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _chkMaterialGLASS = !_chkMaterialGLASS;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkMaterialGLASS,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('glass')),
                    ],
                  ),
                ),
                Text(
                  "(${countMaterialGLASS.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkMaterialPLASTIC = !_chkMaterialPLASTIC;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkMaterialPLASTIC,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('plastic')),
                    ],
                  ),
                ),
                Text(
                  "(${countMaterialPLASTIC.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkMaterialPPSU = !_chkMaterialPPSU;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkMaterialPPSU,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('ppsu')),
                    ],
                  ),
                ),
                Text(
                  "(${countMaterialPPSU.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _chkMaterialPP = !_chkMaterialPP;
            });
          },
          child: Container(
            color: Color(0x00000000),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: _chkMaterialPP,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('pp')),
                    ],
                  ),
                ),
                Text(
                  "(${countMaterialPP.toString()})",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderBodyProduct() {
    if (_productPage?.list == null) {
      return Center();
    }
    List<ProductModel> price = _filterDataTypeAndPrice(_productPage.list);
    print(price);
    List<ProductModel> rs = _filterData(price);

    return Expanded(
      child: Container(
        color: Color.fromRGBO(243, 241, 242, 1),
        child: Row(
          children: [
            Visibility(visible: _onFilter, child: _sideBarFilter(price)),
            Expanded(
                child: Container(
              // color: Colors.green,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: _buildProductCard(rs),
            ))
          ],
        ),
      ),
    );
  }

  Widget _sideBarFilter(List<ProductModel> product) {
    // ประเภทสินค้า
    int countPdtBottle = 0;
    int countPdtBathing = 0;
    int countPdtMom = 0;

    // ซีรี่
    int countSeriesBrain = 0;
    int countSeriesJewel = 0;

    // ประเภทขวด
    int countTypeWide = 0;
    int countTypeSlim = 0;

    // ขนาด
    int countSize80 = 0;
    int countSize120 = 0;
    int countSize150 = 0;
    int countSize200 = 0;
    int countSize240 = 0;
    int countSize320 = 0;

    // วัสดุ
    int countMaterialGLASS = 0;
    int countMaterialPLASTIC = 0;
    int countMaterialPPSU = 0;
    int countMaterialPP = 0;

    product.forEach((item) {
      if (_tabSelect == 0) {
        if (item.series == "brain") {
          countSeriesBrain++;
        } else if (item.series == "jewel") {
          countSeriesJewel++;
        }

        if (item.category == "slim") {
          countTypeSlim++;
        } else if (item.category == "wide") {
          countTypeWide++;
        }

        if (item.size.contains("80ml")) {
          countSize80++;
        } else if (item.size.contains("120ml")) {
          countSize120++;
        } else if (item.size.contains("150ml")) {
          countSize150++;
        } else if (item.size.contains("200ml")) {
          countSize200++;
        } else if (item.size.contains("240ml")) {
          countSize240++;
        } else if (item.size.contains("320ml")) {
          countSize320++;
        }

        if (item.material.contains("GLASS")) {
          countMaterialGLASS++;
        }
        if (item.material.contains("PLASTIC")) {
          countMaterialPLASTIC++;
        }
        if (item.material.contains("PPSU")) {
          countMaterialPPSU++;
        }
        if (item.material.contains("PP")) {
          countMaterialPP++;
        }
      } else {
        if (item.type.toString().split('.').last == "bottle") {
          countPdtBottle++;
        } else if (item.type.toString().split('.').last == "bathing") {
          countPdtBathing++;
        } else if (item.type.toString().split('.').last == "mom") {
          countPdtMom++;
        }

        if (item.series == "brain") {
          countSeriesBrain++;
        } else if (item.series == "jewel") {
          countSeriesJewel++;
        }
      }
    });

    return Container(
      alignment: Alignment.topLeft,
      // color: Colors.grey,
      width: 180,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _onPrice = !_onPrice;
                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 16),
                alignment: Alignment.centerLeft,
                color: Color(0x00000000),
                child: Row(
                  children: [
                    Icon(_onPrice ? Icons.arrow_drop_down : Icons.arrow_right),
                    Text(Translate.of(context).translate('price'))
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _onPrice,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70,
                            child: TextFormField(
                              focusNode: _focusStart,
                              cursorColor: Theme.of(context).primaryColor,
                              controller: _startValueController,
                              style: TextStyle(fontSize: 14),
                              autocorrect: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                              ],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 8,
                            color: Colors.black38,
                          ),
                          Container(
                            width: 70,
                            child: TextFormField(
                              focusNode: _focusEnd,
                              cursorColor: Theme.of(context).primaryColor,
                              controller: _endValueController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                              ],
                              style: TextStyle(fontSize: 14),
                              autocorrect: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                          )
                        ],
                      ),
                    ),
                    RangeSlider(
                      values: _currentRangeValues,
                      min: 0,
                      max: _maxPrice.toDouble(),
                      divisions: _maxPrice,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Color.fromRGBO(95, 183, 164, 0.4),
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                          _startValueController.text =
                              values.start.round().toString();
                          _endValueController.text =
                              values.end.round().toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _tabSelect == 1,
              child: Container(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Divider()),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _onProductType = !_onProductType;
                        });
                      },
                      child: Container(
                        color: Color(0x00000000),
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(_onProductType
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right),
                            Text(
                                Translate.of(context).translate('product_type'))
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _onProductType,
                      child: Container(
                        child: _optionProductType(
                            countPdtBottle, countPdtBathing, countPdtMom),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Divider()),
            GestureDetector(
              onTap: () {
                setState(() {
                  _onSeries = !_onSeries;
                });
              },
              child: Container(
                color: Color(0x00000000),
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Icon(_onSeries ? Icons.arrow_drop_down : Icons.arrow_right),
                    Text(Translate.of(context).translate('series'))
                  ],
                ),
              ),
            ),
            Visibility(
                visible: _onSeries,
                child: Container(
                  child: _optionSeries(countSeriesBrain, countSeriesJewel),
                )),
            Visibility(
                visible: _tabSelect == 0,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Divider()),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _onType = !_onType;
                        });
                      },
                      child: Container(
                        color: Color(0x00000000),
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(_onType
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right),
                            Text(Translate.of(context).translate('type'))
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _onType,
                        child: Container(
                          child: _optionType(countTypeWide, countTypeSlim),
                        ))
                  ],
                )),
            Visibility(
              visible: _tabSelect == 0,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Divider()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _onSize = !_onSize;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      color: Color(0x00000000),
                      child: Row(
                        children: [
                          Icon(_onSize
                              ? Icons.arrow_drop_down
                              : Icons.arrow_right),
                          Text(Translate.of(context).translate('size'))
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _onSize,
                      child: Container(
                          child: _optionProductSize(
                              countSize80,
                              countSize120,
                              countSize150,
                              countSize200,
                              countSize240,
                              countSize320)))
                ],
              ),
            ),
            Visibility(
              visible: _tabSelect == 0,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Divider()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _onMaterial = !_onMaterial;
                      });
                    },
                    child: Container(
                      color: Color(0x00000000),
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(_onMaterial
                              ? Icons.arrow_drop_down
                              : Icons.arrow_right),
                          Text(Translate.of(context).translate('material'))
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _onMaterial,
                      child: Container(
                        child: _optionMaterial(
                            countMaterialGLASS,
                            countMaterialPLASTIC,
                            countMaterialPPSU,
                            countMaterialPP),
                      ))
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
    );
  }

  @override
  void dispose() async {
    super.dispose();
  }

  Widget _renderGroup() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _productGroup.length,
      itemBuilder: (BuildContext context, int index) => Container(
        margin: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tabSelect = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _colorTab[index],
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    '${_productGroupName[index]}',
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 5),
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: index == _tabSelect ? _colorTab[index] : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<ProductModel> _filterDataTypeAndPrice(List<ProductModel> data) {
    List<ProductModel> lists = [];
    String typeIndex = "";
    if (_tabSelect == 0) {
      typeIndex = "bottle";
    } else {
      typeIndex = "accessories";
    }

    // แบ่งประเภทสินค้า และช่วงราคา
    lists = data
        .where((f) =>
            f.type.toString().split('.').last == typeIndex &&
            (f.price >= _currentRangeValues.start.round() &&
                f.price <= _currentRangeValues.end.round()))
        .toList();

    return lists;
  }

  List<ProductModel> _filterData(List<ProductModel> lists) {
    List<String> series = [];
    List<String> type = [];
    List<String> size = [];
    List<String> material = [];
    List<String> productType = [];

    // ซีรี่
    if (_chkSeriesBrain) {
      series.add("brain");
    }
    if (_chkSeriesJewel) {
      series.add("jewel");
    }

    if (series.length > 0) {
      lists =
          lists.where((f) => series.contains(f.series.toLowerCase())).toList();
    }

    if (_tabSelect == 0) {
      // ถ้าเป็นขวดนม

      // ประเภท
      if (_chkTypeSlim) {
        type.add("slim");
      }
      if (_chkTypeWide) {
        type.add("wide");
      }
      if (type.length > 0) {
        lists = lists
            .where((f) => type.contains(f.category.toLowerCase()))
            .toList();
      }

      // ขนาด
      if (_chkSize80) {
        size.add("80ml");
      }
      if (_chkSize120) {
        size.add("120ml");
      }
      if (_chkSize150) {
        size.add("150ml");
      }
      if (_chkSize200) {
        size.add("200ml");
      }
      if (_chkSize240) {
        size.add("240ml");
      }
      if (_chkSize320) {
        size.add("320ml");
      }

      if (size.length > 0) {
        lists = lists.where((f) => compareSize(f.size, size)).toList();
      }

      // วัสดุ
      if (_chkMaterialGLASS) {
        material.add("GLASS");
      }
      if (_chkMaterialPLASTIC) {
        material.add("PLASTIC");
      }
      if (_chkMaterialPPSU) {
        material.add("PPSU");
      }
      if (_chkMaterialPP) {
        material.add("PP");
      }

      if (material.length > 0) {
        lists =
            lists.where((f) => compareMaterial(material, f.material)).toList();
      }
    } else {
      // ประเภท
      if (_chkPdtBottle) {
        productType.add("bottle");
      }
      if (_chkPdtBathing) {
        productType.add("bathing");
      }
      if (_chkPdtBathing) {
        productType.add("mom");
      }
      if (productType.length > 0) {
        lists = lists
            .where(
                (f) => productType.contains(f.type.toString().split('.').last))
            .toList();
      }

      // ซีรี่
      if (_chkSeriesBrain) {
        series.add("brain");
      }
      if (_chkSeriesJewel) {
        series.add("jewel");
      }

      if (series.length > 0) {
        lists = lists
            .where((f) => series.contains(f.series.toLowerCase()))
            .toList();
      }
    }

    return lists;
  }

  bool compareSize(List<dynamic> array1, List<dynamic> array2) {
    List<dynamic> rs = array1
        .where((item) => array2.contains(item.toString().toLowerCase()))
        .toList();
    if (rs.length > 0) {
      return true;
    }
    return false;
  }

  bool compareMaterial(List<dynamic> array1, List<dynamic> array2) {
    List<dynamic> rs = array1
        .where((item) => array2.contains(item.toString().toUpperCase()))
        .toList();
    if (rs.length > 0) {
      return true;
    }
    return false;
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
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          backgroundColor: Color.fromRGBO(244, 209, 205, 1),
          child: Icon(
            !_onFilter ? Icons.filter_alt : Icons.open_in_full,
            color: Color.fromRGBO(112, 85, 151, 1),
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _onFilter = !_onFilter;
            });
          },
        ),
        body: Column(
          children: [
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
                            child: _renderGroup(),
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    width: 90,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          child: Image.asset(
                              'assets/images/logo-kidde-white.png',
                              height: 48),
                        )),
                        Divider(
                          color: Colors.grey,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/icons/facebook-black.png',
                                height: 24),
                            Image.asset('assets/icons/instagram-black.png',
                                height: 24),
                            Image.asset('assets/icons/line-black.png',
                                height: 24)
                          ],
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _renderBodyProduct(),

            // Expanded(
            //   child: Container(
            //     color: Color.fromRGBO(243, 241, 242, 1),
            //     child: Row(
            //       children: [
            //         Visibility(visible: _onFilter, child: _sideBarFilter()),
            //         Expanded(
            //             child: Container(
            //           // color: Colors.green,
            //           padding: EdgeInsets.only(left: 10, right: 10),
            //           child: _buildProductCard(),
            //         ))
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ));
  }

  Widget _buildProductCard(List<ProductModel> rs) {
    Locale myLocale = Localizations.localeOf(context);
    return rs.length > 0
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              childAspectRatio: 0.9,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = rs[index];
              return ProductCardItem(item: item, local: myLocale);
            },
            itemCount: rs.length)
        : Container(
            alignment: Alignment.center,
            child: Text(
              Translate.of(context).translate('product_not_match'),
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ));
  }
}
