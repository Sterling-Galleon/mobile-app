// ignore_for_file: file_names, camel_case_types, prefer_const_constructors

import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/clsCommonWidget.dart';
import '../main.dart';
import '../models/clsCategoryModel.dart';
import '../models/clsTileCategoryModel.dart';
import 'clsProductsPageUI.dart';

class clsCategoryPageUI extends StatefulWidget {
  const clsCategoryPageUI({Key? key}) : super(key: key);

  @override
  State<clsCategoryPageUI> createState() => _clsCategoryPageUIState();
}

class _clsCategoryPageUIState extends State<clsCategoryPageUI> {
  List<clsCategoryModel> lstclsCategoryModel = <clsCategoryModel>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategoryList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Categories",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: lstclsCategoryModel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(
                      Radius.circular(clsDimensConstants.douDp5)),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).cardColor,
                    Theme.of(context).cardColor
                  ])),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          clsTileCategoryModel objclsTileCategoryModel =
                              clsTileCategoryModel();
                          objclsTileCategoryModel.categoryId =
                              lstclsCategoryModel[index].id;
                          objclsTileCategoryModel.category =
                              lstclsCategoryModel[index].name;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => clsProductPageUI(
                                        isCategory: true,
                                        keyword:
                                            lstclsCategoryModel[index].name,
                                        isCollectionApiCall: false,
                                        objclsTileCategoryModel:
                                            objclsTileCategoryModel,
                                      )));
                        },
                        child: Text(
                          lstclsCategoryModel[index].name.toString(),
                          style: GoogleFonts.montserrat(
                              fontSize: clsDimensConstants.douDp14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (lstclsCategoryModel[index].bolexpand) {
                            lstclsCategoryModel[index].bolexpand = false;
                          } else {
                            lstclsCategoryModel[index].bolexpand = true;
                          }
                          setState(() {});
                        },
                        child: Icon(
                          lstclsCategoryModel[index].bolexpand
                              ? Icons.arrow_circle_up_outlined
                              : Icons.arrow_drop_down_circle,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  if (lstclsCategoryModel[index].bolexpand &&
                      lstclsCategoryModel[index].childCategories != null)
                    returnSubCategory(
                        lstclsCategoryModel[index].childCategories!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  getCategoryList() {
    ShowLoader(context);
    clsApiCallMethods.getCategories().then((value) {
      CancelLoader(context);
      if (value.error == "true") {
        if (value.fieldValidation != null) {
          if (value.fieldValidation!.firstname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.firstname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.lastname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.lastname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.email != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.email.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.password != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.password.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.confirmPassword != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.confirmPassword.toString(),
                showheading: true);
          }
        }
      } else {
        if (value.data != null) {
          lstclsCategoryModel = List<clsCategoryModel>.from(
              value.data.map((e) => clsCategoryModel.fromJson(e)));

          setState(() {});
        }
      }
    });
  }

  returnSubCategory(List<clsCategoryModel> childCategories) {
    List<Widget> lstwidget = <Widget>[];
    if (childCategories.isNotEmpty) {
      childCategories.asMap().forEach((index, element) {
        lstwidget.add(InkWell(
          onTap: () {
            clsTileCategoryModel objclsTileCategoryModel =
                clsTileCategoryModel();
            objclsTileCategoryModel.categoryId = element.id;
            objclsTileCategoryModel.category = element.name;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => clsProductPageUI(
                          isCollectionApiCall: false,
                          objclsTileCategoryModel: objclsTileCategoryModel,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    " (${index + 1})  ${element.name}",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ));
      });
    } else {
      lstwidget.add(Text("No Data Found"));
    }

    return Column(
      children: lstwidget,
    );
  }
}
