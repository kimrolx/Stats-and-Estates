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
                  textFieldBuilder('Category*', 1, 'Aa'),
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
                        child: TextFormField(
                          minLines: 3,
                          maxLines: 10,
                          readOnly: true,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Click here to attach files.',
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
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
                          onPressed: () {},
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
