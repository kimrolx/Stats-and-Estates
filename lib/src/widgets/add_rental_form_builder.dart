import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/models/checkbox_model.dart';
import 'package:stats_and_estates/src/utils/image_picker_util.dart';
import 'package:stats_and_estates/src/widgets/button_builder.dart';
import 'package:stats_and_estates/src/widgets/checkbox_builder.dart';
import 'package:stats_and_estates/src/widgets/fields/listing_info_builder.dart';

class MyRentalForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController barangayController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController provinceController;
  final TextEditingController codeController;
  final TextEditingController priceController;
  const MyRentalForm({
    super.key,
    required this.nameController,
    required this.barangayController,
    required this.streetController,
    required this.cityController,
    required this.provinceController,
    required this.codeController,
    required this.priceController,
  });

  @override
  State<MyRentalForm> createState() => _MyRentalFormState();
}

class _MyRentalFormState extends State<MyRentalForm> {
  String _dropdownValue = 'Unit';

  String _accommodationTypeValue = 'Select Accommodation Type';

  String _availabilityValue = 'Select Availability';

  List<bool?> checkboxStates =
      List.generate(getCheckBoxItems().length, (index) => null);

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  void dropdownAccommodationType(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _accommodationTypeValue = selectedValue;
      });
    }
  }

  void dropdownAvailability(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _availabilityValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(
            'Add Rental Accomodation',
            style: TextStyle(
              fontFamily: 'DMSansBold',
              fontSize: width * 0.06,
              color: Colors.black,
            ),
          ),
          backgroundColor: backgroundColor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              CupertinoIcons.back,
              color: buttonColor,
              size: width * 0.075,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.035,
                  right: width * 0.035,
                  bottom: height * 0.025,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Gap(height * 0.015),
                        //TODO Basic Information
                        Container(
                          width: width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: userSheet,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 0.5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.035,
                              vertical: height * 0.025,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Information',
                                  style: TextStyle(
                                    fontFamily: 'DMSansBold',
                                    fontSize: width * 0.065,
                                    color: buttonColor,
                                  ),
                                ),
                                Gap(height * 0.025),
                                MyListingInfoField(
                                  controller: widget.nameController,
                                  labelText: 'Name',
                                ),
                                Gap(height * 0.02),
                                MyListingInfoField(
                                  controller: widget.barangayController,
                                  labelText: 'Barangay',
                                ),
                                Gap(height * 0.02),
                                MyListingInfoField(
                                  controller: widget.streetController,
                                  labelText: 'Street Address',
                                ),
                                Gap(height * 0.02),
                                MyListingInfoField(
                                  controller: widget.cityController,
                                  labelText: 'City',
                                ),
                                Gap(height * 0.02),
                                MyListingInfoField(
                                  controller: widget.provinceController,
                                  labelText: 'Province',
                                ),
                                Gap(height * 0.02),
                                MyListingInfoField(
                                  controller: widget.codeController,
                                  labelText: 'Zip Code',
                                ),
                                Gap(height * 0.02),
                                Row(
                                  children: [
                                    Flexible(
                                      child: MyListingInfoField(
                                        controller: widget.priceController,
                                        labelText: 'Price',
                                      ),
                                    ),
                                    Gap(width * 0.035),
                                    DropdownButton<String>(
                                      value: _dropdownValue,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: 'Unit',
                                          child: Text(
                                            'Unit',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Per Person',
                                          child: Text(
                                            'Per Person',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Biweekly',
                                          child: Text(
                                            'Biweekly',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Monthly',
                                          child: Text(
                                            'Monthly',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: dropdownCallback,
                                      style: TextStyle(
                                        fontFamily: 'DMSansMedium',
                                        fontSize: width * 0.05,
                                        color: buttonColor,
                                      ),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: buttonColor,
                                      ),
                                      underline: Container(
                                        height: 1,
                                        color: buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        //TODO Accommodation Type
                        Container(
                          width: width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: userSheet,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 0.5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.035,
                              vertical: height * 0.025,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Accommodation Type',
                                  style: TextStyle(
                                    fontFamily: 'DMSansBold',
                                    fontSize: width * 0.065,
                                    color: buttonColor,
                                  ),
                                ),
                                Gap(height * 0.02),
                                Row(
                                  children: [
                                    Gap(width * 0.035),
                                    DropdownButton<String>(
                                      value: _accommodationTypeValue,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: 'Select Accommodation Type',
                                          child: Text(
                                            'Select Accommodation Type',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Bed Spacer',
                                          child: Text(
                                            'Bed Spacer',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Studio Type',
                                          child: Text(
                                            'Studio Type',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Apartment Room',
                                          child: Text(
                                            'Apartment Room',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: dropdownAccommodationType,
                                      style: TextStyle(
                                        fontFamily: 'DMSansMedium',
                                        fontSize: width * 0.05,
                                        color: buttonColor,
                                      ),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: buttonColor,
                                      ),
                                      underline: Container(
                                        height: 1,
                                        color: buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        //TODO Amenities
                        Container(
                          width: width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: userSheet,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 0.5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Amenities',
                                  style: TextStyle(
                                    fontFamily: 'DMSansBold',
                                    fontSize: width * 0.065,
                                    color: buttonColor,
                                  ),
                                ),
                                Gap(height * 0.025),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      ((getCheckBoxItems().length + 1) / 2)
                                          .ceil(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final int startIndex = index * 2;
                                    final int endIndex = startIndex + 2;
                                    final List<CheckBoxItem> items =
                                        getCheckBoxItems().sublist(
                                      startIndex,
                                      endIndex > getCheckBoxItems().length
                                          ? null
                                          : endIndex,
                                    );
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children:
                                          items.asMap().entries.map((entry) {
                                        final int itemIndex =
                                            startIndex + entry.key;
                                        final CheckBoxItem item = entry.value;
                                        return Expanded(
                                          child: MyCheckBox(
                                            text: item.text,
                                            isChecked:
                                                checkboxStates[itemIndex] ??
                                                    false,
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                checkboxStates[itemIndex] =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        //TODO Availability
                        Container(
                          width: width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: userSheet,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 0.5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.035,
                              vertical: height * 0.025,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Availability',
                                  style: TextStyle(
                                    fontFamily: 'DMSansBold',
                                    fontSize: width * 0.065,
                                    color: buttonColor,
                                  ),
                                ),
                                Gap(height * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Gap(width * 0.035),
                                    DropdownButton<String>(
                                      value: _availabilityValue,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: 'Select Availability',
                                          child: Text(
                                            'Select Availability',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Available',
                                          child: Text(
                                            'Available',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'Occupied',
                                          child: Text(
                                            'Occupied',
                                            style: TextStyle(
                                              fontFamily: 'DMSansMedium',
                                              fontSize: width * 0.05,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: dropdownAvailability,
                                      style: TextStyle(
                                        fontFamily: 'DMSansMedium',
                                        fontSize: width * 0.05,
                                        color: buttonColor,
                                      ),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: buttonColor,
                                      ),
                                      underline: Container(
                                        height: 1,
                                        color: buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        //TODO Image Picker
                        const ImagePicker(
                          header: 'Proof of Property',
                          photoQuery:
                              'Add Photos of Property Deed or Ownership Details Here',
                        ),
                        Gap(height * 0.015),
                        const ImagePicker(
                          header: 'Property Pictures',
                          photoQuery: 'Add Photos of Property Here',
                        ),
                        Gap(height * 0.015),
                        const ImagePicker(
                          header: 'Building Permit',
                          photoQuery: 'Add Photos of Building Permit Here',
                        ),
                      ],
                    ),
                    Gap(height * 0.035),
                    MyButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Done',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePicker extends StatefulWidget {
  final String header;
  final String photoQuery;
  const ImagePicker(
      {super.key, required this.header, required this.photoQuery});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  final List<Uint8List?> _images = List.generate(3, (index) => null);

  void selectImage(int index) async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _images[index] = img;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: userSheet,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.025,
        ),
        child: Column(
          children: [
            Text(
              widget.header,
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.065,
                color: buttonColor,
              ),
            ),
            Gap(height * 0.025),
            Container(
              width: width * 0.225,
              height: height * 0.1,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: buttonColor,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  int nullIndex = _images.indexWhere((img) => img == null);
                  if (nullIndex != -1) {
                    selectImage(nullIndex);
                  } else {
                    AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                      title: const Text('Error'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.035,
                        vertical: height * 0.02,
                      ),
                      content: const Text('All image slots are filled.'),
                    );
                  }
                },
                icon: Icon(
                  CupertinoIcons.add,
                  color: buttonColor,
                  size: width * 0.07,
                ),
              ),
            ),
            Gap(height * 0.01),
            Text(
              widget.photoQuery,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.04,
                color: buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
