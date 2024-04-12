// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import 'dart:io';
import 'package:intl/intl.dart';

dynamic objLoader;

ShowLoader(BuildContext context) {
  objLoader ??= showDialog(
      useSafeArea: true,
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Material(
              color: Colors.transparent,
              child: LoadingGif(context),
            ));
      });
}

LoadingGif(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5), // Border radius
              child: Image.asset(
                'assets/images/img.png',
                width: 60,
              ),
            ),
          ),
          Positioned(
              left: 30,
              top: 30,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    ),
  );
}

CancelLoader(BuildContext context) {
  if (objLoader != null) {
    Navigator.pop(context);
    objLoader = null;
  }
}

ShowSnackbar({required String strMessage, required bool showheading}) {
  Get.snackbar(
    showheading ? "" : "",
    strMessage,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.orange,
    colorText: Colors.white,
  );
}

CommaSeparatedAmount(dynamic intAmount) {
  var formatter = NumberFormat('#,###,###.##');
  return formatter.format(int.parse(intAmount.toString()));
}

getDateFormat(DateTime date) {
  var dateformated =
      "${date.day >= 10 ? date.day : "0${date.day}"}-${date.month >= 10 ? date.month : "0${date.month}"}-${date.year}";
  return dateformated;
}

Widget replaceHtmlFromStrings(String strText) {
  Widget html = HtmlWidget(
    strText,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: html,
  );
}

getDropDownHeight(int count, BuildContext context) {
  var screenHeight = MediaQuery.of(context).size.height;
  if ((count + 2) * 40 - 120 > screenHeight.toInt()) {
    var height = screenHeight - 120;
    return height.toDouble();
  } else {
    var height = (count + 2) * 40;
    return height.toDouble();
  }
}

bool getFileSize(
  String filepath,
) {
  var file = File(filepath);
  final bytes = file.readAsBytesSync().lengthInBytes;
  if ((bytes / 1024) / 1024 > 1) {
    return true;
  } else {
    return false;
  }
}

bool GetDeviceSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 500) {
    return false;
  } else {
    return true;
  }
}

PopRoutingPage(BuildContext context) {
  if (MediaQuery.of(context).size.width > 500 &&
      MediaQuery.of(context).orientation == Orientation.landscape) {
    Get.back();
  }
}
