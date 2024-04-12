// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:collection/collection.dart';
import 'package:ecommerce/constants/clsCommonWidget.dart';
import 'package:ecommerce/models/clsBarangayModel.dart';
import 'package:ecommerce/models/clsCityModel.dart';
import 'package:ecommerce/models/clsStateModel.dart';
import 'package:ecommerce/models/shipping_address_model.dart';
import 'package:ecommerce/pages/clsCartPageUI.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';

class ShpippingInfoView extends StatefulWidget {
  ShpippingInfoView({super.key, required this.shippingInfoModel});
  ShippingInfoModel shippingInfoModel;

  @override
  State<ShpippingInfoView> createState() => _ShpippingInfoViewState();
}

class _ShpippingInfoViewState extends State<ShpippingInfoView> {
  List<String> shippingDropDownItems = [
    "Pickup at Galleon Office",
    "Pickup at LBC Office",
    "Ship to Billing Address",
    "Input Shipping Address"
  ];
  int selectedIndex = 2;
  bool checkboxEnabled = false;
  List<clsStateModal> lstclsStateModal = <clsStateModal>[];
  clsStateModal? selectedStateModel;
  clsCityModel? selectedCityModel;
  clsBarangayModel? selectedBarangayModel;
  List<clsCityModel> lstclsCityModel = <clsCityModel>[];
  List<clsBarangayModel> lstclsBarangayModel = <clsBarangayModel>[];
  List<ShippingAddressModel> shippingAddressModelList =
      <ShippingAddressModel>[];
  clsStateModal? selectedState;
  String? selectCity;
  ShippingAddressModel? selectedAddress;
  List<ShippingAddressModel> shippingFilterAddressModelList =
      <ShippingAddressModel>[];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      getStateList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Material(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
              isExpanded: true,
              value: selectedIndex,
              items: shippingDropDownItems.mapIndexed((index, e) {
                return DropdownMenuItem(
                  value: index,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                selectedIndex = value as int;
                switch (selectedIndex) {
                  case 0:
                    widget.shippingInfoModel.shippingMethodEnum =
                        ShippingMethodEnum.GalleonOffice;
                    break;
                  case 1:
                    widget.shippingInfoModel.shippingMethodEnum =
                        ShippingMethodEnum.LbcOffice;
                    break;
                  case 2:
                    widget.shippingInfoModel.shippingMethodEnum =
                        ShippingMethodEnum.BillingAddress;
                    break;
                  case 3:
                    widget.shippingInfoModel.shippingMethodEnum =
                        ShippingMethodEnum.InputShippingAddress;
                    break;
                }
                setState(() {});
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _body(),
          ],
        ),
      )),
    );
  }

  _body() {
    if (selectedIndex == 0) {
      return Column(
        children: [
          Row(
            children: [
              const Text("Name of Person\nwho will pickup: *"),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    widget.shippingInfoModel.shippingName = value;
                  },
                  decoration:
                      const InputDecoration(hintText: "Separate names with /"),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Checkbox(
                  value: checkboxEnabled,
                  onChanged: (value) {
                    checkboxEnabled = value ?? false;
                    setState(() {});
                  }),
              const Text("Release Item/s ONLY to the above names")
            ],
          )
        ],
      );
    } else if (selectedIndex == 1) {
      return Column(
        children: [
          const Center(
            child: Text(
              "LBC Shipping Info",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          _rowItem(
              labelText: "Shipping Name: *",
              hintText: "Separate names with /",
              onChanged: (value) {
                widget.shippingInfoModel.shippingName = value;
              }),
          _rowItem(
              labelText: "Email*",
              hintText: "Email",
              onChanged: (value) {
                widget.shippingInfoModel.shippingEmail = value;
              }),
          _rowItem(
              labelText: "Phone*",
              hintText: "Phone",
              onChanged: (value) {
                widget.shippingInfoModel.phoneNo = value;
              }),
          const SizedBox(
            height: 30,
          ),
          const Center(
              child: Text(
            "LBC Branch Locator",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )),
          Row(
            children: [
              const SizedBox(
                width: 50,
                child: Text("Region"),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButton(
                    isExpanded: true,
                    value: selectedState,
                    hint: const Text("Select Region"),
                    items: lstclsStateModal.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.provincesName ?? ""),
                      );
                    }).toList(),
                    onChanged: (value) {
                      shippingAddressModelList.clear();
                      selectCity = null;
                      shippingFilterAddressModelList.clear();
                      selectedAddress = null;
                      setState(() {});
                      ShowLoader(context);
                      selectedState = value as clsStateModal;
                      clsApiCallMethods.GetAddressByRegion(
                              regionName: selectedState?.provincesName ?? "")
                          .then((value) {
                        if (value.data != null && value.data is List) {
                          for (var item in value.data) {
                            shippingAddressModelList
                                .add(ShippingAddressModel.fromJson(item));
                          }
                          setState(() {});
                        }
                        CancelLoader(context);
                      });

                      widget.shippingInfoModel.regionName =
                          selectedState?.provincesName ?? "";
                      setState(() {});
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
                child: Text("City"),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButton(
                    isExpanded: true,
                    value: selectCity,
                    hint: const Text("Select City"),
                    items: shippingAddressModelList.map((e) {
                      return DropdownMenuItem(
                        value: e.branchCity,
                        child: Text(e.branchCity ?? ""),
                      );
                    }).toList(),
                    onChanged: (value) {
                      shippingFilterAddressModelList.clear();
                      selectedAddress = null;
                      setState(() {});
                      selectCity = value as String;
                      for (ShippingAddressModel item
                          in shippingAddressModelList) {
                        if (item.branchCity == value) {
                          shippingFilterAddressModelList.add(item);
                        }
                      }
                      setState(() {});
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
                child: Text("Address"),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButton(
                    isExpanded: true,
                    value: selectedAddress,
                    hint: const Text("Select Address"),
                    items: shippingFilterAddressModelList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.branchAddress ?? ""),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedAddress = value as ShippingAddressModel;
                      widget.shippingInfoModel.lbcAddress =
                          selectedAddress?.branchAddress ?? "";
                      setState(() {});
                    }),
              ),
            ],
          )
        ],
      );
    } else if (selectedIndex == 3) {
      return Column(
        children: [
          _rowItem(
              labelText: "Full Name: *",
              hintText: "Separate names with /",
              onChanged: (value) {
                widget.shippingInfoModel.shippingName = value;
              }),
          _rowItem(
              labelText: "Email: *",
              hintText: "Email",
              onChanged: (value) {
                widget.shippingInfoModel.shippingEmail = value;
              }),
          _rowItem(
              labelText: "Phone: *",
              hintText: "Phone",
              onChanged: (value) {
                widget.shippingInfoModel.phoneNo = value;
              }),
          _rowItem(
              labelText: "Secondary Phone:",
              hintText: "Secondary Phone",
              onChanged: (value) {}),
          _rowItem(
              labelText: "Street Address: *",
              hintText: "Street Address",
              onChanged: (value) {
                widget.shippingInfoModel.streetAddress = value;
              }),
          _rowItem(
              labelText: "Country: *",
              hintText: "Philippines",
              enabled: false,
              onChanged: (value) {}),
          _dropdownItem(
              labelText: "Province: *",
              hintText: "Province",
              items: lstclsStateModal.map((e) {
                return DropdownMenuItem<clsStateModal>(
                  value: e,
                  child: Text(e.provincesName ?? ""),
                );
              }).toList(),
              selectedValue: selectedStateModel,
              onChanged: (value) {
                clsStateModal _value = value as clsStateModal;
                selectedStateModel = _value;
                selectedCityModel = null;
                selectedBarangayModel = null;
                lstclsCityModel.clear();
                lstclsBarangayModel.clear();
                widget.shippingInfoModel.province = _value.provincesName;
                widget.shippingInfoModel.regionName = _value.provincesName;
                getCityList(strStateId: _value.provincesId!);
                setState(() {});
              }),
          _dropdownItem(
              labelText: "City: *",
              hintText: "City",
              items: lstclsCityModel.map((e) {
                return DropdownMenuItem<clsCityModel>(
                  value: e,
                  child: Text(e.citiesName ?? ""),
                );
              }).toList(),
              selectedValue: selectedCityModel,
              onChanged: (value) {
                selectedCityModel = value as clsCityModel;
                selectedBarangayModel = null;
                lstclsBarangayModel.clear();
                widget.shippingInfoModel.city = selectedCityModel!.citiesName;
                getBarangayList(strCityId: selectedCityModel!.citiesId!);
                setState(() {});
              }),
          _dropdownItem(
              labelText: "Barangay: *",
              hintText: "Barangay",
              items: lstclsBarangayModel.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.barangayName ?? ""),
                );
              }).toList(),
              selectedValue: selectedBarangayModel,
              onChanged: (value) {
                selectedBarangayModel = value as clsBarangayModel;
                widget.shippingInfoModel.barangay =
                    selectedBarangayModel!.barangayName;
                setState(() {});
              }),
          _rowItem(
              labelText: "Zip Code: *",
              hintText: "Zip Code",
              onChanged: (value) {
                widget.shippingInfoModel.zipCode = value;
              }),
        ],
      );
    }

    return const SizedBox();
  }

  getCityList({required String strStateId}) {
    ShowLoader(context);
    clsApiCallMethods.getCityList(strStateId: strStateId).then((value) {
      CancelLoader(context);
      if (value.error == "true") {
      } else {
        lstclsCityModel = List<clsCityModel>.from(
            value.data.map((e) => clsCityModel.fromJson(e)));
        setState(() {});
      }
    });
  }

  getBarangayList({required String strCityId}) {
    ShowLoader(context);
    clsApiCallMethods.getBarangayList(strCityId: strCityId).then((value) {
      CancelLoader(context);
      if (value.error == "true") {
      } else {
        if (value.data != null) {
          lstclsBarangayModel.clear();
          lstclsBarangayModel.addAll(List<clsBarangayModel>.from(
              value.data.map((e) => clsBarangayModel.fromJson(e))));
          setState(() {});
        }
      }
    });
  }

  getStateList() {
    ShowLoader(context);
    clsApiCallMethods.getStateList().then((value) {
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
          lstclsStateModal = List<clsStateModal>.from(
              value.data.map((e) => clsStateModal.fromJson(e)));
          // if(lstclsStateModal.length>0){
          //   getCityList(strStateId: lstclsStateModal[1].provincesId.toString());
          // }

          setState(() {});
        }
      }
    });
  }

  Widget _dropdownItem({
    String labelText = "",
    String hintText = "",
    bool enabled = true,
    List<DropdownMenuItem<Object?>>? items,
    Function(Object?)? onChanged,
    Object? selectedValue,
  }) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.28,
          child: Text(labelText),
        ),
        Expanded(
            child: DropdownButton<Object?>(
          hint: Text(hintText),
          isExpanded: true,
          value: selectedValue,
          items: items,
          onChanged: onChanged,
        ))
      ],
    );
  }

  Widget _rowItem(
      {String labelText = "",
      String hintText = "",
      bool enabled = true,
      Function(String)? onChanged}) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.28,
          child: Text(labelText),
        ),
        Expanded(
          child: TextField(
            onChanged: onChanged,
            enabled: enabled,
            decoration: InputDecoration(hintText: hintText),
          ),
        )
      ],
    );
  }
}
