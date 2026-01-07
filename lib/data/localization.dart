// ignore_for_file: non_constant_identifier_names

import 'package:supaeromoon_webcontrol/data/notifiers.dart';

final Map<String, String> en_EN = {
  "title": "Supaeromoon WebControl",
  "backend_unavailable": "Backend unavailable",
  "in_control": "Control Active",
  "not_in_control": "Busy",
  "request_control": "Request Control",
  "release_control": "Release Control",
  "controller_controls": "Controller",
  "simplified_controls": "Simplified",
  "switch_arm_movement_mode": "Switch Arm/Movement mode WIP",
  "toggle_grip": "Toggle grip WIP",
  "move_arm_in_view": "Arm in view WIP",
  "move_arm_above_sample_container": "Arm above container WIP",
  "soft_stop": "Soft stop",
  "emergency_stop": "Emergency stop",
  "confirm_estop_title": "Confirm Emergency stop dialog",
  "confirm_estop_body": "Confirm Emergency stop?",
  "cancel": "Cancel",
  "confirm": "Confirm",
};

final Map<String, String> fr_FR = {
  "title": "Supaeromoon WebControl",
  "backend_unavailable": "Backend indisponible",
  "in_control": "Contrôle Actif",
  "not_in_control": "Occupé",
  "request_control": "Demander le contrôle",
  "release_control": "Libérer le contrôle",
  "controller_controls": "Manette",
  "simplified_controls": "Simplifié",
  "switch_arm_movement_mode": "Changer mode Bras/Déplacement WIP",
  "toggle_grip": "Actionner la pince WIP",
  "move_arm_in_view": "Bouger le bras en vue WIP",
  "move_arm_above_sample_container": "Bras au-dessus du conteneur WIP",
  "soft_stop": "Arrêt progressif",
  "emergency_stop": "Arrêt d'urgence",
  "confirm_estop_title": "Confirmation de l'arrêt d'urgence",
  "confirm_estop_body": "Confirmer l'arrêt d'urgence?",
  "cancel": "Annuler",
  "confirm": "Confirmer",
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
    // return _localization[_lang]?[label] ?? label;
    final String? res = _localization[_lang]?[label]; // TODO until loc is established
    if(res == null){
      print("Missing localization for label $label and lang $_lang");
      return label;
    }
    return res;
  }
}