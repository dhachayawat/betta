import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:betta/blocs/language/bloc.dart';
import 'package:betta/configs/config.dart';
import 'package:betta/utils/utils.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(InitialLanguageState());

  @override
  Stream<LanguageState> mapEventToState(event) async* {
    if (event is ChangeLanguage) {
      if (event.locale == AppLanguage.defaultLanguage) {
        yield LanguageUpdated();
      } else {
        yield LanguageUpdating();
        AppLanguage.defaultLanguage = event.locale;

        ///Preference save
        UtilPreferences.setString(
          Preferences.language,
          event.locale.languageCode,
        );

        yield LanguageUpdated();
      }
    }
  }
}
