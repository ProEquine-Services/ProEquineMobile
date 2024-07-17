
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../widgets/contact_support_widget.dart';
import '../widgets/payment_card.dart';
import 'main_wallet_screen.dart';

class PayoutSuccessScreen extends StatelessWidget {
  final String paymentTime;
  final String paymentAmount;

  const PayoutSuccessScreen(
      {Key? key, required this.paymentTime, required this.paymentAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              PaymentCard(
                content: Column(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 10, vertical: 10),
                    //   decoration: const BoxDecoration(
                    //       shape: BoxShape.circle, color: AppColors.statusText),
                    //   child: Center(
                    //       child: SvgPicture.asset(AppIcons.successPayment)),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Thank you for your withdrawal request!'.tra,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF474747),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please note that the withdrawal process may take 3-5 business days to complete. We appreciate your patience.'
                          .tra,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PaymentCard(
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Transaction Details'.tra,
                        style:  TextStyle(
                          color: AppColors.blackLight,
                          fontSize: 14.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            'Withdrawal Amount'.tra,
                            style: const TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 11.39,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '$paymentAmount AED',
                            style: const TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 14.02,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),


                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            'Withdrawal Date'.tra,
                            style: const TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 11.39,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            paymentTime,
                            style: const TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
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
                  isBackButton: true,
                  backgroundColor: AppColors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavigation(
                                  selectedIndex: 0,
                                )));
                  },
                  child: Text(
                    "Home".tra,
                    style:  TextStyle(color: AppColors.blackLight),
                  )),
              const SizedBox(
                height: 15,
              ),
              RebiButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainWalletScreen()));
                  },
                  child: Text("Wallet".tra))
            ],
          ),
        ),
      ),
    );
  }
}
