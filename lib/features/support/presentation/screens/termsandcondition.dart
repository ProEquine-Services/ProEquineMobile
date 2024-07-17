import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/widgets/header_text.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20.0.h),
          child: CustomHeader(
            title: "Terms&Conditions",
            isThereBackButton: false,
            onPressUp: (){

            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kPadding, vertical: kPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText("", "Privacy Policy",true),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '• At ProEquine, we are committed to protecting your privacy. This privacy policy applies to the information we collect through our website and horse transportation services.\n\n • We may collect personal information from you, such as your name, address, email address, and telephone number. We may also collect information about your horse, such as its name, breed, age, and any medical information that is relevant to its transport.\n\n • We may use your personal information for the following purposes:\n\n 1- To provide you with information about our services \n2- To process and fulfill your bookings \n3- To contact you regarding your booking or any other matter related to our services \n4- To improve the content and navigation of our website \n5- To send you occasional marketing communications, unless you have opted out of receiving such communications \n\n • We will not share your personal information with any third party except as necessary to complete your booking or as required by law. \n \n • We take reasonable precautions to protect your personal information from unauthorized access or use. However, please be aware that no method of internet transmission is completely secure.\n \n • Our website may contain links to third-party websites. We are not responsible for the privacy practices or content of these websites.\n\n • You have the right to access, correct, or delete your personal information at any time. You may also opt-out of receiving marketing communications from us by contacting us or using the unsubscribe link in our emails.\n\n • We reserve the right to make changes to this privacy policy at any time without notice. Your continued use of the website and services following any changes signifies your acceptance of the new privacy policy.\n\n • If you have any questions or concerns about this privacy policy, please contact us.\n\n • We will keep your data for as long as you are a customer of ours, and for a maximum of 3 years after.',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'notosan',
                      fontSize: 14),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ));
  }
}
