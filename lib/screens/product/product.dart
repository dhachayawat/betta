import 'package:betta/api/api.dart';
import 'package:betta/configs/language.dart';
import 'package:betta/models/model.dart';
import 'package:betta/models/screen_models/screen_models.dart';
import 'package:betta/screens/product/product_card_time.dart';
import 'package:flutter/services.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
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
  bool _checkMaterialGLASS = false;
  bool _checkMaterialPLASTIC = false;
  bool _checkMaterialPPSU = false;
  bool _checkMaterialPP = false;

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

  Widget _optionSeries() {
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
                  "(5)",
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
                  "(5)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionProductType() {
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
                  "(5)",
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
                  "(50)",
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
                  "(5)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionType() {
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
                  "(5)",
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
                  "(50)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionProductSize() {
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
                  "(5)",
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
                  "(5)",
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
                  "(5)",
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
                  "(5)",
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
                  "(5)",
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
                  "(5)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionMaterial() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _checkMaterialGLASS = !_checkMaterialGLASS;
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
                        value: _checkMaterialGLASS,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('glass')),
                    ],
                  ),
                ),
                Text(
                  "(5)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _checkMaterialPLASTIC = !_checkMaterialPLASTIC;
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
                        value: _checkMaterialPLASTIC,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('plastic')),
                    ],
                  ),
                ),
                Text(
                  "(5)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _checkMaterialPPSU = !_checkMaterialPPSU;
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
                        value: _checkMaterialPPSU,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('ppsu')),
                    ],
                  ),
                ),
                Text(
                  "(5)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _checkMaterialPP = !_checkMaterialPP;
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
                        value: _checkMaterialPP,
                        onChanged: (bool value) {},
                      ),
                      Text(Translate.of(context).translate('pp')),
                    ],
                  ),
                ),
                Text(
                  "(5)",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sideBarFilter() {
    return Container(
      alignment: Alignment.topLeft,
      // color: Colors.grey,
      width: 240,
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
                            width: 80,
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
                            width: 16,
                            color: Colors.black38,
                          ),
                          Container(
                            width: 80,
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
                        child: _optionProductType(),
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
                  child: _optionSeries(),
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
                          child: _optionType(),
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
                        child: _optionProductSize(),
                      ))
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
                        child: _optionMaterial(),
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
                            child: _renderGroup(),
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
                          child: Image.asset(
                              'assets/images/logo-kidde-white.png',
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
                            Image.asset('assets/icons/line-black.png',
                                height: 32)
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
                    Visibility(visible: _onFilter, child: _sideBarFilter()),
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
