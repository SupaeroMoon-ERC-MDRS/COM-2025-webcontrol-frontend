// ignore_for_file: non_constant_identifier_names

import 'package:supaeromoon_webcontrol/data/notifiers.dart';

final Map<String, String> en_EN = {
  
};

final Map<String, String> fr_FR = {
  
};

abstract class Loc{
  static final Map<String, Map<String, String>> _localization = {
    "en_EN": en_EN,
    "fr_FR": fr_FR
  };

  static String _lang = "NONE";
  static List<String> get languages => _localization.keys.toList();
  static String get selected => _lang;

  static BlankNotifier notifier = BlankNotifier(null);

  static bool setLanguage(final String language){
    if(_localization.containsKey(language)){
      _lang = language;
      notifier.update();
      return true;
    }
    return false;
  }

  static String get(final String label){
    return _localization[_lang]?[label] ?? label;
  }
}