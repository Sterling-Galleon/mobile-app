// ignore_for_file: must_be_immutable, camel_case_types, prefer_const_constructors

import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../models/clsCategoryModel.dart';
import '../models/clsTileCategoryModel.dart';
import 'clsProductsPageUI.dart';

class clsSubCatgeoryPageUI extends StatefulWidget {
  List<clsCategoryModel> lstSubclsCategoryModel = <clsCategoryModel>[];
  String strTitle = "";
  clsSubCatgeoryPageUI(
      {super.key,
      required this.lstSubclsCategoryModel,
      required this.strTitle});

  @override
  State<clsSubCatgeoryPageUI> createState() => _clsSubCatgeoryPageUIState();
}

class _clsSubCatgeoryPageUIState extends State<clsSubCatgeoryPageUI> {
  @override
  void initState() {
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
          "${widget.strTitle} Categories",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.lstSubclsCategoryModel.length,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.lstSubclsCategoryModel[index].name.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        clsTileCategoryModel objclsTileCategoryModel =
                            clsTileCategoryModel();
                        objclsTileCategoryModel.categoryId =
                            widget.lstSubclsCategoryModel[index].id;
                        objclsTileCategoryModel.category =
                            widget.lstSubclsCategoryModel[index].name;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => clsProductPageUI(
                                      isCollectionApiCall: false,
                                      objclsTileCategoryModel:
                                          objclsTileCategoryModel,
                                    )));
                      },
                      child: Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
