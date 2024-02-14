import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/utils/utils.dart';

class Apptranslations extends Translations with TranslationHelper {
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'ms_MY': msMY,
      };
}
