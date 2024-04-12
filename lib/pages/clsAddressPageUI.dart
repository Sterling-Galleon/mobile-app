// ignore_for_file: file_names, must_be_immutable, camel_case_types, non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, void_checks

import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/models/clsAddressesModel.dart';
import 'package:ecommerce/models/clsCityModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/clsCommonWidget.dart';
import '../main.dart';
import '../models/clsBarangayModel.dart';
import '../models/clsStateModel.dart';

class clsAddressPageUI extends StatefulWidget {
  clsAddresssModel? objaddressmodel;
  clsAddressPageUI({super.key, this.objaddressmodel});

  @override
  State<clsAddressPageUI> createState() => _clsAddressPageUIState();
}

class _clsAddressPageUIState extends State<clsAddressPageUI> {
  List<clsStateModal> lstclsStateModal = <clsStateModal>[];
  clsStateModal objclsStateModal = clsStateModal();
  List<clsCityModel> lstclsCityModel = <clsCityModel>[];
  clsCityModel objclsCityModel = clsCityModel();
  List<clsBarangayModel> lstclsBarangayModel = <clsBarangayModel>[];
  clsBarangayModel objclsBarangayModel = clsBarangayModel();
  String strStatename = "Select";
  String strCityname = "Select";
  String strBarangayname = "Select";

  TextEditingController mobilenoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countrynameController = TextEditingController();
  TextEditingController addressnameController = TextEditingController();
  TextEditingController addressstreetController = TextEditingController();
  TextEditingController addressstreet2Controller = TextEditingController();
  TextEditingController addressPhoneController = TextEditingController();
  TextEditingController addressPhone2Controller = TextEditingController();

  @override
  void initState() {
    lstclsStateModal.add(clsStateModal(
        provincesId: "0",
        provincesName: "Select",
        provincesRegion: "",
        region: null));
    lstclsCityModel.add(
        clsCityModel(citiesId: "0", citiesName: "Select", citiesProvinces: ""));
    lstclsBarangayModel.add(clsBarangayModel(barangayName: "Select"));
    objclsStateModal = lstclsStateModal[0];
    objclsCityModel = lstclsCityModel[0];
    objclsBarangayModel = lstclsBarangayModel[0];
    countrynameController.text = "Philippines";

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getStateList();
    });
    super.initState();
  }

  getStateList() {
    ShowLoader(context);
    clsApiCallMethods.getStateList().then((value) {
      lstclsCityModel.clear();
      lstclsCityModel.add(clsCityModel(
          citiesId: "0", citiesName: "Select", citiesProvinces: ""));
      objclsCityModel = lstclsCityModel[0];
      CancelLoader(context);
      if (value.error == "true") {
        lstclsCityModel.clear();
        lstclsCityModel.add(clsCityModel(
            citiesId: "0", citiesName: "Select", citiesProvinces: ""));
        objclsCityModel = lstclsCityModel[0];
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
          lstclsStateModal = List<clsStateModal>.from(
              value.data.map((e) => clsStateModal.fromJson(e)));
          if (lstclsStateModal.isNotEmpty) {
            getCityList(strStateId: lstclsStateModal[1].provincesId.toString());
          }
          setState(() {});
        }
      }
    });
  }

  getCityList({required String strStateId}) {
    ShowLoader(context);
    clsApiCallMethods.getCityList(strStateId: strStateId).then((value) {
      lstclsBarangayModel.clear();
      lstclsBarangayModel.add(clsBarangayModel(barangayName: "Select"));
      objclsBarangayModel = lstclsBarangayModel[0];

      CancelLoader(context);
      if (value.error == "true") {
        lstclsBarangayModel.clear();
        lstclsBarangayModel.add(clsBarangayModel(barangayName: "Select"));
        objclsBarangayModel = lstclsBarangayModel[0];
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
          lstclsBarangayModel.clear();
          lstclsBarangayModel.add(clsBarangayModel(barangayName: "Select"));
          objclsBarangayModel = lstclsBarangayModel[0];
          lstclsCityModel = List<clsCityModel>.from(
              value.data.map((e) => clsCityModel.fromJson(e)));
          if (lstclsCityModel.isNotEmpty) {
            getBarangayList(strCityId: lstclsCityModel[0].citiesId.toString());
          }
          setState(() {});
        } else {
          lstclsBarangayModel.clear();
          lstclsBarangayModel.add(clsBarangayModel(barangayName: "Select"));
          objclsBarangayModel = lstclsBarangayModel[0];
        }
      }
    });
  }

  getBarangayList({required String strCityId}) {
    ShowLoader(context);
    clsApiCallMethods.getBarangayList(strCityId: strCityId).then((value) {
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
          lstclsBarangayModel.clear();
          lstclsBarangayModel.add(clsBarangayModel(barangayName: "Select"));
          objclsBarangayModel = lstclsBarangayModel[0];
          lstclsBarangayModel.addAll(List<clsBarangayModel>.from(
              value.data.map((e) => clsBarangayModel.fromJson(e))));
          setState(() {});
        } else {
          lstclsBarangayModel.clear();
          lstclsBarangayModel.add(clsBarangayModel(barangayName: "Select"));
          objclsBarangayModel = lstclsBarangayModel[0];
        }
      }
    });
  }

  SaveAddress() {
    Map<String, String> objMap = {
      "address_name": addressnameController.value.text,
      "address_street": addressstreetController.value.text,
      "address_street2": addressstreet2Controller.value.text,
      "address_city": objclsCityModel.citiesName.toString(),
      "address_state": objclsStateModal.provincesName.toString(),
      "address_barangay": objclsBarangayModel.barangayName.toString(),
      "address_country": countrynameController.value.text,
      "address_postal": pincodeController.value.text,
      "address_phone": addressPhoneController.value.text,
      "address_phone2": addressPhone2Controller.value.text,
      "address_mobile": mobilenoController.value.text,
      "address_email": emailController.value.text,
    };
    ShowLoader(context);
    clsApiCallMethods.SaveAddress(objMap).then((value) {
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
        } else {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: true);
        }
      } else {
        if (value.messages.length != 0) {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: true);
        }
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Add new Address",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: addressnameController,
                        maxLength: 100,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Biller Name'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: emailController,
                        maxLength: 100,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Email'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: addressPhoneController,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp("[0-9]"),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Primary Phone'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: addressPhone2Controller,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp("[0-9]"),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Secondary Phone'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: countrynameController,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Country'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        DropdownSearch<clsStateModal>(
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem!.provincesName.toString(),
                          ),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            objclsStateModal = value;
                            strStatename = value.provincesName.toString();
                            lstclsCityModel.clear();
                            lstclsCityModel.add(clsCityModel(
                                citiesId: "0",
                                citiesName: "Select",
                                citiesProvinces: ""));
                            objclsCityModel = lstclsCityModel[0];
                            setState(() {});
                            getCityList(
                                strStateId: value.provincesId.toString());
                          },
                          items: lstclsStateModal,
                          selectedItem: objclsStateModal,
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 200),
                          left: 10,
                          top: -10,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(left: 3),
                              color: Colors.white,
                              child: Text('Region'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        DropdownSearch<clsCityModel>(
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem!.citiesName.toString(),
                          ),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            objclsCityModel = value;
                            strCityname = value.citiesName.toString();
                            getBarangayList(
                                strCityId: value.citiesId.toString());
                          },
                          items: lstclsCityModel,
                          selectedItem: objclsCityModel,
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 200),
                          left: 10,
                          top: -10,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(left: 3),
                              color: Colors.white,
                              child: Text('City'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    DropdownSearch<clsBarangayModel>(
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem!.barangayName.toString(),
                      ),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        objclsBarangayModel = value;
                        strBarangayname = value.barangayName.toString();
                      },
                      items: lstclsBarangayModel,
                      selectedItem: objclsBarangayModel,
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Barangay'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: addressstreetController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('House/Bldg.#, Lot, Blk'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: addressstreet2Controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Street Address'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: mobilenoController,
                        maxLength: 11,
                        // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp("[0-9]"),
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('Mobile Number'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: pincodeController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp("[0-9]"),
                          ),
                        ],
                        maxLength: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 10,
                      top: -10,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          color: Colors.white,
                          child: Text('ZipCode'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          String _ErrorMsg = '';
          if (addressnameController.value.text.isEmpty) {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Biller Name ';
          }
          if (mobilenoController.value.text.isEmpty) {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Mobile No ';
          }
          if (emailController.value.text.isEmpty) {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Email Id ';
          }
          if (addressPhoneController.value.text.isEmpty) {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Phone No ';
          }
          if (addressstreetController.value.text.isEmpty) {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Street Name ';
          }
          if (pincodeController.value.text.isEmpty) {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Pin Code ';
          }
          if (countrynameController.value.text.isEmpty) {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Country ';
          }
          if (objclsStateModal.provincesName == "Select") {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Province ';
          }
          if (objclsCityModel.citiesName == "Select") {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'City ';
          }
          if (objclsBarangayModel.barangayName == "Select") {
            if (_ErrorMsg != '') {
              _ErrorMsg += ",";
            }
            _ErrorMsg += 'Barangay ';
          }
          if (_ErrorMsg != '') {
            _ErrorMsg += " are Mandatory";
          }
          if (_ErrorMsg != '') {
            return ShowSnackbar(strMessage: _ErrorMsg, showheading: true);
          } else {
            if (mobilenoController.value.text.length < 10 ||
                mobilenoController.value.text.length > 11) {
              return ShowSnackbar(
                  strMessage: "Please Enter Valid Mobile Number",
                  showheading: true);
            }
            if (addressPhoneController.value.text.length < 10 ||
                addressPhoneController.value.text.length > 11) {
              return ShowSnackbar(
                  strMessage: "Please Enter Valid Phone Number",
                  showheading: true);
            }
            // if (addressPhone2Controller.value.text.length < 10 ||
            //     addressPhone2Controller.value.text.length > 11) {
            //   return ShowSnackbar(
            //       strMessage: "Please Enter Valid Phone Number",
            //       showheading: true);
            // }
            if (!emailController.value.text.contains("@") ||
                !emailController.value.text.contains(".")) {
              return ShowSnackbar(
                  strMessage: "Please Enter Valid Email Id", showheading: true);
            }
            SaveAddress();
          }
        },
        child:Padding(
            padding: const EdgeInsets.only(left:10,right:10,bottom: 20),
          child:Container(
              height: 45,
              width: 150,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                      Radius.circular(clsDimensConstants.douDp5)),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor
                  ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SAVE THIS ADDRESS & CONTINUE",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              )) ,
        ),
      ),
    );
  }
}
