import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/widgets/linked_payment_methods_builder.dart';
import 'package:stats_and_estates/src/widgets/payment_methods_builder.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'All Payment Methods',
          style: TextStyle(
            fontFamily: 'DMSansBold',
            fontSize: width * 0.05,
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
            CupertinoIcons.arrow_left,
            color: buttonColor,
            size: width * 0.075,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: height * 0.015,
          bottom: height * 0.045,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Currently Linked',
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.045,
              ),
            ),
            Gap(height * 0.01),
            const MyLinkedMethods(
              logo: 'assets/images/GCash_logo.png',
              account: '09122347127',
            ),
            Gap(height * 0.015),
            const MyLinkedMethods(
              logo: 'assets/images/Mastercard_2019_logo.png',
              account: '6453',
            ),
            Gap(height * 0.035),
            Text(
              'Add Methods',
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.045,
              ),
            ),
            Gap(height * 0.01),
            const MyPaymentMethods(
              logo: 'assets/images/Maya_logo.png',
              scale: 0.5,
            ),
            Gap(height * 0.015),
            const MyPaymentMethods(
              logo: 'assets/images/PayPal 1.png',
              scale: 1.0,
            ),
            Gap(height * 0.015),
            const MyPaymentMethods(
              logo: 'assets/images/Visa_Inc._logo 1.png',
              scale: 1.0,
            ),
            Gap(height * 0.015),
          ],
        ),
      ),
    );
  }
}
