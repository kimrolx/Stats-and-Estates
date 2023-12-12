import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

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
            'Feedback & Suggestions',
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
                  Gap(height * 0.05),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'DMSansMedium',
                        fontSize: width * 0.045,
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(text: 'Got any '),
                        TextSpan(
                          text: 'feedback',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' with the use of Stats & Estates?'),
                      ],
                    ),
                  ),
                  Gap(height * 0.015),
                  TextFormField(
                    minLines: 3,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Aa',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Gap(height * 0.01),
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
                          builder: (context) =>
                              const SubmitFeedbackSuggestion(text: 'Feedback'),
                        );
                      },
                      child: Text(
                        'Submit Feedback',
                        style: TextStyle(
                          fontFamily: 'DMSansMedium',
                          fontSize: width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  Gap(height * 0.05),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'DMSansMedium',
                        fontSize: width * 0.045,
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(text: 'Got any '),
                        TextSpan(
                          text: 'suggestions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                ' you wish to let us know? Write them below.'),
                      ],
                    ),
                  ),
                  Gap(height * 0.015),
                  TextFormField(
                    minLines: 3,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Aa',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Gap(height * 0.01),
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
                          builder: (context) => const SubmitFeedbackSuggestion(
                              text: 'Suggestion'),
                        );
                      },
                      child: Text(
                        'Submit Suggestion',
                        style: TextStyle(
                          fontFamily: 'DMSansMedium',
                          fontSize: width * 0.04,
                        ),
                      ),
                    ),
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

class SubmitFeedbackSuggestion extends StatefulWidget {
  final String text;
  const SubmitFeedbackSuggestion({super.key, required this.text});

  @override
  State<SubmitFeedbackSuggestion> createState() =>
      _SubmitFeedbackSuggestionState();
}

class _SubmitFeedbackSuggestionState extends State<SubmitFeedbackSuggestion> {
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
              'Your ${widget.text} has been submitted!',
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
