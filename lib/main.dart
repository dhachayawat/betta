import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:betta/app.dart';
import 'package:betta/utils/utils.dart';

class AppObserver extends BlocObserver {
  ///Support Development
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    UtilLogger.log('BLOC EVENT', event);
  }

  ///Support Development
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    UtilLogger.log('BLOC TRANSITION', transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    UtilLogger.log('BLOC ERROR', error);
  }
}

void main() async {
  Bloc.observer = AppObserver();
  runApp(App());
}
