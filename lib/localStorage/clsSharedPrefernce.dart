// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

class clsSharedPrefernce {
  static SharedPreferences? objSharedPrefs;
  static Init() async {
    objSharedPrefs ??= await SharedPreferences.getInstance();
  }

  static ClearRecords_SharedPrefernces() async {
    objSharedPrefs!.clear();
  }
}
