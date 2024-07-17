
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/divider.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../widgets/contact_support_widget.dart';
import '../widgets/payment_card.dart';
import 'main_wallet_screen.dart';

class FailedPaymentScreen extends StatelessWidget {
  final String paymentTime;
  final String paymentAmount;

  const FailedPaymentScreen(
      {Key? key,
        required this.paymentTime,
        required this.paymentAmount})
      : super(key: key);

  String formatDateTime(String dateTimeString) {
    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object
    String formattedDateTime = DateFormat('d MMM - h:mm a').format(dateTime);

    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              PaymentCard(
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: SvgPicture.asset(AppIcons.failedPayment)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Deposit Failed!'.tra,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF474747),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            "Time".tra,
                            style: const TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                          formatDateTime(DateTime.now().toString()),
                            style: const TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding),
                        child: CustomDivider(),
                      ),
                      // const DashesLineWidget(color: AppColors.lightGrey),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Amount".tra,
                            style: const TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$paymentAmount AED',
                            style: const TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ContactSupportWidget(),
              const Spacer(),
              RebiButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainWalletScreen()));
                  },
                  child: Text("Wallet".tra)),
              const SizedBox(
                height: 15,
              ),
              RebiButton(
                  isBackButton: true,
                  backgroundColor: AppColors.backgroundColorLight,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavigation(
                              selectedIndex: 0,
                            )));
                  },
                  child: Text("Home".tra,style: const TextStyle(color: AppColors.gold),)),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
