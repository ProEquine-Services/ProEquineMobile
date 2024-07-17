import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_header.dart';

class PrivacyCheckBox extends StatelessWidget {
  final bool? value;
  final Function(bool? val)? onChanged;
  final bool? isTherePrivacy;
  final bool isItForShipping;
  final Function? onTap;

  PrivacyCheckBox({
    super.key,
    this.onTap,
    this.value,
    this.isItForShipping = false,
    this.isTherePrivacy = false,
    this.onChanged,
  });

  String privacyUrl = 'https://www.proequine.ae/privacy-policy';

  @override
  Widget build(BuildContext context) {
    isItForShipping
        ? privacyUrl = 'https://www.proequine.ae/term-of-services'
        : 'https://www.proequine.ae/privacy-policy';
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: AppColors.formsBackground,
            primaryColor: AppColors.formsBackground,
          ),
          child: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              key: key,
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              activeColor: AppColors.yellow,
              value: value,
              onChanged: (bool? val) {
                onChanged!(val);
              },
            ),
          ),
        ),
        isTherePrivacy!
            ? RichText(
                text: TextSpan(
                  text: 'Agree with '.tra,
                  style: TextStyle(
                    fontSize: isItForShipping ? 11.5.sp : 12.5.sp,
                    fontFamily: 'nonotosan',
                    fontWeight: FontWeight.w500,
                    color:
                        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            ? Colors.white
                            : AppColors.blackLight,
                  ),
                  children: [
                    TextSpan(
                      text: isItForShipping
                          ? 'shipping policy & terms of use'.tra
                          : 'privacy policy & terms of use'.tra,
                      style: TextStyle(
                        fontSize: isItForShipping ? 11.5.sp : 12.5.sp,
                        fontFamily: 'nonotosan',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        color: AppSharedPreferences.getTheme ==
                                'ThemeCubitMode.dark'
                            ? Colors.white
                            : AppColors.blackLight,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TermsAndConditionsPage(url: privacyUrl),
                            ),
                          );
                          // pressPrivacy2();
                        },
                    )
                  ],
                ),
              )
            : RichText(
                text: TextSpan(
                  text: 'I accept receiving marketing emails'.tra,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
      ],
    );
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.proequine.ae/privacy-policy')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isAndroid) {
    } else {
      // WebView.platform=
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0.h),
        child: CustomHeader(title: 'Terms&Conditions'.tra),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
