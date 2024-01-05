import 'package:get/get.dart';
import 'package:resid_plus_user/view/screen/language_change/english.dart';
import 'package:resid_plus_user/view/screen/language_change/france.dart';

class Languages extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en_US" : english,
    "fr_CA" : france
  };
}