import 'dart:async';

import 'package:betta/blocs/bloc.dart';
import 'package:betta/configs/config.dart';
import 'package:betta/utils/other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  VideoPlayerController _videoPlayerController;
  CarouselController _carouselController = CarouselController();
  int _maxPhoto = 8;
  bool _onVideo = false;

  Future<void> initializePlayer() async {}

  List<String> _album = [];

  @override
  void initState() {
    _languageBloc = BlocProvider.of<LanguageBloc>(context);
    _videoPlayerController =
        VideoPlayerController.asset('assets/video/betta-video-1.mp4');

    _videoPlayerController.addListener(_detectVideo);
    _videoPlayerController.setLooping(false);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    // _delayPlay();
    _setAlbum();
    super.initState();
  }

  _setAlbum() {
    for (int i = 1; i < _maxPhoto; i++) {
      _album.add('assets/images/cover/betta_0${i.toString()}.png');
    }
    setState(() {});
  }

  _detectVideo() {
    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      print("จบแล้ว");
      this._carouselController.jumpToPage(0);
      this.setState(() {
        _onVideo = false;
      });
    }
    // Timer.run(() {
    //   setState(() {
    //     _position = _videoPlayerController.value.position;
    //   });
    // });
    // setState(() {
    //   _duration = _videoPlayerController.value.duration;
    // });
    // if (_duration?.compareTo(_position) == 0 ||
    //     _duration?.compareTo(_position) == -1) {
    //   print("จบแล้ว");
    //   setState(() {
    //     _onVideo = false;
    //   });
    // }
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
  void dispose() async {
    await _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    double iconSize = 64;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    height: height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      print(index.toString() + " " + _onVideo.toString());
                      if (index == _maxPhoto - 2 && !_onVideo) {
                        Future.delayed(const Duration(milliseconds: 3000), () {
                          _videoPlayerController.seekTo(Duration.zero);
                          _videoPlayerController.play();
                          setState(() {
                            _onVideo = true;
                          });
                        });
                      }
                    }),
                items: _album
                    .map((item) => Container(
                          child: Center(
                              child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            height: height,
                          )),
                        ))
                    .toList()),
            Visibility(
                visible: _onVideo, child: VideoPlayer(_videoPlayerController)),
            Visibility(
                visible: _onVideo,
                child: _ControlsOverlay(controller: _videoPlayerController)),
            Visibility(
              visible: _onVideo,
              child: VideoProgressIndicator(_videoPlayerController,
                  allowScrubbing: true),
            ),
            Visibility(
                visible: _onVideo,
                child: Positioned(
                  top: (height) / 2 - 40 - iconSize, // ลบ 60 ้header - 48 ขนาด
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      _videoPlayerController.pause();
                      _carouselController.jumpToPage(_maxPhoto - 2);
                      setState(() {
                        _onVideo = false;
                      });
                    },
                    child: Container(
                      // color: Colors.amber,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: iconSize,
                      ),
                    ),
                  ),
                )),
            Visibility(
                visible: _onVideo,
                child: Positioned(
                  top: (height) / 2 - 40 - iconSize, // ลบ 60 ้header - 48 ขนาด
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      _videoPlayerController.pause();
                      _carouselController.jumpToPage(0);
                      setState(() {
                        _onVideo = false;
                      });
                    },
                    child: Container(
                      // color: Colors.amber,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: iconSize,
                      ),
                    ),
                  ),
                ))
          ],
        ),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/cover/betta_01.png'),
        //     fit: BoxFit.cover,
        //   ),
        // )
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        )
      ],
    );
  }
}
