import 'package:flutter/material.dart';
import '../constants/colors/app_colors.dart';
import '../constants/constants.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

void showTermsBottomSheet({
  required BuildContext context,
  required String content,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
        ? AppColors.formsBackground
        : AppColors.backgroundColorLight,
    useSafeArea: false,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      return Wrap(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90,
          child: Padding(
            padding: const EdgeInsets.only(
                top: kPadding, left: kPadding, right: kPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Text('Terms&Conditions',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "notosan",
                                fontWeight: FontWeight.w600,
                                color: AppSharedPreferences.getTheme ==
                                        'ThemeCubitMode.dark'
                                    ? AppColors.white
                                    : AppColors.blackLight)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,size: 18,color: AppColors.yellow,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kPadding,
                  ),
                   Text(
                    content,
                    // '• At ProEquine, we are committed to protecting your privacy. This privacy policy applies to the information we collect through our website and horse transportation services.\n\n • We may collect personal information from you, such as your name, address, email address, and telephone number. We may also collect information about your horse, such as its name, breed, age, and any medical information that is relevant to its transport.\n\n • We may use your personal information for the following purposes:\n\n 1- To provide you with information about our services \n2- To process and fulfill your bookings \n3- To contact you regarding your booking or any other matter related to our services \n4- To improve the content and navigation of our website \n5- To send you occasional marketing communications, unless you have opted out of receiving such communications \n\n • We will not share your personal information with any third party except as necessary to complete your booking or as required by law. \n \n • We take reasonable precautions to protect your personal information from unauthorized access or use. However, please be aware that no method of internet transmission is completely secure.\n \n • Our website may contain links to third-party websites. We are not responsible for the privacy practices or content of these websites.\n\n • You have the right to access, correct, or delete your personal information at any time. You may also opt-out of receiving marketing communications from us by contacting us or using the unsubscribe link in our emails.\n\n • We reserve the right to make changes to this privacy policy at any time without notice. Your continued use of the website and services following any changes signifies your acceptance of the new privacy policy.\n\n • If you have any questions or concerns about this privacy policy, please contact us.\n\n • We will keep your data for as long as you are a customer of ours, and for a maximum of 3 years after.',
                    style: const TextStyle(
                        // color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'notosan',
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]);
    },
  );
}
