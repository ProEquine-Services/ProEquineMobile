import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:toastification/toastification.dart';

class RebiMessage {
  RebiMessage({
    required String msg,
    Color bgColor = Colors.green,
    Color? textColor,
    String webBgColor = 'green',
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: bgColor,
      webBgColor: webBgColor,
      textColor: textColor,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.SNACKBAR,
      webShowClose: true,
    );
  }

  RebiMessage.success({
    required String msg,
    required BuildContext context,
  }) {
    toastification.show(
      context: context,

      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text('Success'),
      description: Text(msg),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.check,color: AppColors.greenLight,),
      primaryColor: Colors.green,
      backgroundColor: AppColors.successToast,
      foregroundColor: AppColors.greenLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
          color: AppColors.greenLight,
          linearTrackColor: AppColors.successToast,
          linearMinHeight: 0.5
      ),
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );

  }

  RebiMessage.error({
    required String msg,
    required BuildContext context,
  }) {
    toastification.show(
      context: context,

      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text('Error'),
      description:Text(msg),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          // turns: animation,
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.close,color: AppColors.red,),
      primaryColor: Colors.green,
      backgroundColor: AppColors.errorToast,
      foregroundColor: AppColors.red,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: AppColors.red,
        linearTrackColor: AppColors.errorToast,
        linearMinHeight: 0.5
      ),
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            toastification.dismiss(toastItem),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }

  RebiMessage.warning({
    required String msg,
    required BuildContext context,
  }) {
    // MotionToast(
    //   description: Padding(
    //     padding: const EdgeInsets.only(left: 16.0),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Expanded(
    //           flex: 4,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const Text(
    //                 "Warning!",
    //                 textAlign: TextAlign.start,
    //                 style: TextStyle(
    //                   color: AppColors.unVerifiedText,
    //                   fontWeight: FontWeight.w700,
    //                   fontFamily: 'notosan',
    //                   fontSize: 14,
    //                 ),
    //               ),
    //               Text(
    //                 msg,
    //                 maxLines: 2,
    //                 textAlign: TextAlign.start,
    //                 style: const TextStyle(
    //                   color: AppColors.unVerifiedText,
    //                   fontFamily: 'notosan',
    //                   fontSize: 12,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 1,
    //           child: Transform.translate(
    //             offset: const Offset(10.0, 8),
    //             child: const Icon(
    //               Icons.close,
    //               color: AppColors.unVerifiedText,
    //               size: 30,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   primaryColor: AppColors.unVerifiedContainer,
    //   secondaryColor: AppColors.unVerifiedText,
    //   backgroundType: BackgroundType.solid,
    //   animationType: AnimationType.fromTop,
    //   position: MotionToastPosition.values[2],
    //   height: 70,
    //   width: 350,
    //   borderRadius: 8.0,
    //   displayBorder: true,
    //   displaySideBar: false,
    //   animationCurve: Curves.linear,
    // ).show(context);

      // MotionToast(
      //   description: Padding(
      //     padding: const EdgeInsets.only(left: 16.0),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Expanded(
      //           flex: 4,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text(
      //                 "Error",
      //                 textAlign: TextAlign.start,
      //                 style: TextStyle(
      //                   color: AppColors.red,
      //                   fontWeight: FontWeight.w700,
      //                   fontFamily: 'notosan',
      //                   fontSize: 14,
      //                 ),
      //               ),
      //               Text(
      //                 msg,
      //                 maxLines: 2,
      //                 textAlign: TextAlign.start,
      //                 style: const TextStyle(
      //                   color: AppColors.red,
      //                   fontFamily: 'notosan',
      //                   fontSize: 12,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         Expanded(
      //           flex: 1,
      //           child: Transform.translate(
      //             offset: const Offset(10.0, 3),
      //             child: const Icon(
      //               Icons.close,
      //               color: Colors.red,
      //               size: 25,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   primaryColor: AppColors.errorToast,
      //   secondaryColor: AppColors.red,
      //   backgroundType: BackgroundType.solid,
      //   animationType: AnimationType.fromTop,
      //   position: MotionToastPosition.values[2],
      //   height: 70,
      //   width: 350,
      //   borderRadius: 8.0,
      //   displayBorder: true,
      //   displaySideBar: false,
      //   animationCurve: Curves.linear,
      // ).show(context);

      toastification.show(
        context: context,

        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text('Warning'),
        description: Text(msg),
        alignment: Alignment.topRight,
        direction: TextDirection.ltr,
        animationDuration: const Duration(milliseconds: 300),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            // turns: animation,
            opacity: animation,
            child: child,
          );
        },
        icon: const Icon(Icons.warning,color: AppColors.unVerifiedText,),
        primaryColor: Colors.green,
        backgroundColor: AppColors.unVerifiedContainer,
        foregroundColor: AppColors.unVerifiedText,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 16,
            offset: Offset(0, 16),
            spreadRadius: 0,
          )
        ],
        showProgressBar: true,
        progressBarTheme: const ProgressIndicatorThemeData(
            color: AppColors.unVerifiedText,
            linearTrackColor: AppColors.unVerifiedContainer,
            linearMinHeight: 0.5
        ),
        closeButtonShowType: CloseButtonShowType.onHover,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        callbacks: ToastificationCallbacks(
          onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
          onCloseButtonTap: (toastItem) =>
              print('Toast ${toastItem.id} close button tapped'),
          onAutoCompleteCompleted: (toastItem) =>
              print('Toast ${toastItem.id} auto complete completed'),
          onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
        ),
      );

  }
}
