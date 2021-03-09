import 'package:betta/blocs/bloc.dart';
import 'package:betta/configs/config.dart';
import 'package:betta/utils/other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

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

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    _languageBloc = BlocProvider.of<LanguageBloc>(context);
    _videoPlayerController =
        VideoPlayerController.asset('assets/video/betta-video-1.mp4');

    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    // _delayPlay();
    super.initState();
  }

  _delayPlay() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      _videoPlayerController.play();
    });
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
              VideoPlayer(_videoPlayerController),
              // ClosedCaption(text: _videoPlayerController.value.caption.text),
              _ControlsOverlay(controller: _videoPlayerController),
              VideoProgressIndicator(_videoPlayerController,
                  allowScrubbing: true),
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cover/betta_01.png'),
              fit: BoxFit.cover,
            ),
          )),
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
