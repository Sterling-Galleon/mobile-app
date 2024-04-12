// ignore_for_file: file_names, must_be_immutable, camel_case_types, annotate_overrides, prefer_const_constructors

import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../main.dart';

class clsImagePreview extends StatefulWidget {
  String strURl;
  List<dynamic>? strImageUrl;

  clsImagePreview({super.key, required this.strURl, required this.strImageUrl});

  @override
  State<clsImagePreview> createState() => _clsImagePreviewState();
}

class _clsImagePreviewState extends State<clsImagePreview> {
  int intSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "Images",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          PinchZoom(
            resetDuration: const Duration(milliseconds: 100),
            maxScale: 2.5,
            child: Image.network(widget.strURl.toString()),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      if (intSelectedIndex == 0) {
                        return;
                      }
                      intSelectedIndex = intSelectedIndex - 1;

                      widget.strURl = widget.strImageUrl![intSelectedIndex];
                      setState(() {});
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(clsDimensConstants.douDp5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ))),
                InkWell(
                    onTap: () {
                      if (intSelectedIndex == widget.strImageUrl!.length - 1) {
                        return;
                      }
                      intSelectedIndex = intSelectedIndex + 1;

                      widget.strURl = widget.strImageUrl![intSelectedIndex];
                      setState(() {});
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(clsDimensConstants.douDp5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
