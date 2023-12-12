import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/utils/image_picker_util.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  String _categoryValue = 'Select a Category';

  void dropdownAvailability(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _categoryValue = selectedValue;
      });
    }
  }

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

    Widget textFieldBuilder(String header, int minLines, String hintText) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                fontFamily: 'DMSansMedium',
                fontSize: width * 0.045,
              ),
            ),
            Gap(height * 0.005),
            TextFormField(
              minLines: minLines,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Colors.black45,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        );

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
          backgroundColor: backgroundColor,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              size: width * 0.075,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: buttonColor,
          ),
          title: Text(
            'User Support',
            style: TextStyle(
              fontFamily: 'DMSansBold',
              fontSize: width * 0.065,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                bottom: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(height * 0.02),
                  Text(
                    'Category*',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.045,
                    ),
                  ),
                  Gap(height * 0.005),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 2,
                          offset: const Offset(0, 0.5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: DropdownButton<String>(
                        value: _categoryValue,
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Select a Category',
                            child: Text(
                              'Select a Category',
                              style: TextStyle(
                                fontFamily: 'DMSansMedium',
                                fontSize: width * 0.05,
                                color: buttonColor,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'User Profile',
                            child: Text(
                              'User Profile',
                              style: TextStyle(
                                fontFamily: 'DMSansMedium',
                                fontSize: width * 0.05,
                                color: buttonColor,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'User Behavior',
                            child: Text(
                              'User Behavior',
                              style: TextStyle(
                                fontFamily: 'DMSansMedium',
                                fontSize: width * 0.05,
                                color: buttonColor,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Bug Reports',
                            child: Text(
                              'Bug Reports',
                              style: TextStyle(
                                fontFamily: 'DMSansMedium',
                                fontSize: width * 0.05,
                                color: buttonColor,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'In-app Communications',
                            child: Text(
                              'In-app Communications',
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
                    ),
                  ),
                  Gap(height * 0.02),
                  textFieldBuilder(
                      'Summary*', 1, 'A brief summary of the issue'),
                  Gap(height * 0.02),
                  textFieldBuilder('When did this issue occur?*', 1, ''),
                  Gap(height * 0.02),
                  textFieldBuilder('Description*', 3,
                      'Provide more details regarding this issue'),
                  Gap(height * 0.02),
                  textFieldBuilder('Email/Phone*', 1, ''),
                  Gap(height * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attachments*',
                        style: TextStyle(
                          fontFamily: 'DMSansMedium',
                          fontSize: width * 0.045,
                        ),
                      ),
                      Gap(height * 0.005),
                      GestureDetector(
                        onTap: () {
                          int nullIndex =
                              _images.indexWhere((img) => img == null);
                          if (nullIndex != -1) {
                            selectImage(nullIndex);
                          }
                        },
                        child: Container(
                          width: width,
                          height: height * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Click Here to Attach Files',
                              style: TextStyle(
                                fontFamily: 'DMSansMedium',
                                fontSize: width * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(height * 0.025),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const SubmitReportDialog(),
                            );
                          },
                          child: Text(
                            'Submit Report',
                            style: TextStyle(
                              fontFamily: 'DMSansMedium',
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitReportDialog extends StatefulWidget {
  const SubmitReportDialog({super.key});

  @override
  State<SubmitReportDialog> createState() => _SubmitReportDialogState();
}

class _SubmitReportDialogState extends State<SubmitReportDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(
          color: splashColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Report submitted!',
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(height * 0.02),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.045,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
