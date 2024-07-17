// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:proequine/core/constants/constants.dart';
// import 'package:proequine/core/constants/routes/routes.dart';
// import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
// import 'package:proequine/core/widgets/rebi_button.dart';
// import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
//
// import 'package:proequine/features/manage_account/presentation/screens/change_password_screen.dart';
// import 'package:proequine/features/manage_account/presentation/screens/update_email_screen.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/colors/app_colors.dart';
// import '../../../../core/widgets/custom_header.dart';
// import '../../../../core/widgets/header_text.dart';
// import '../../../../core/widgets/rebi_input.dart';
//
// class AccountInfoScreen extends StatefulWidget {
//   bool isUpdatedSuccessfully = false;
//
//   AccountInfoScreen({super.key, this.isUpdatedSuccessfully = false});
//
//   @override
//   State<AccountInfoScreen> createState() => _AccountInfoScreenState();
// }
//
// class _AccountInfoScreenState extends State<AccountInfoScreen> {
//   final TextEditingController _currentPassword = TextEditingController();
//
//   final TextEditingController _preferences = TextEditingController();
//
//   final TextEditingController _discipline = TextEditingController();
//
//   final TextEditingController name = TextEditingController();
//
//   final TextEditingController email = TextEditingController();
//
//   final TextEditingController phone = TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   ManageAccountCubit cubit = ManageAccountCubit();
//   String? updatedEmail;
//   DateTime? currentBackPressTime;
//
//   Future<bool> onWillPop() {
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > const Duration(seconds: 0)) {
//       currentBackPressTime = now;
//       return Future.value(true);
//     }
//     return Future.value(true);
//   }
//
//   @override
//   void initState() {
//     cubit.getUser(AppSharedPreferences.userPhoneNumber);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     name.dispose();
//     email.dispose();
//     phone.dispose();
//     _currentPassword.dispose();
//     _discipline.dispose();
//     _preferences.dispose();
//     cubit.close();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     widget.isUpdatedSuccessfully =
//         ModalRoute.of(context)?.settings.arguments as bool;
//
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(20.0.h),
//           child: CustomHeader(
//             title: "Profile",
//             isThereChangeWithNavigate: true,
//             isThereBackButton: true,
//             onPressBack: () {
//               if (widget.isUpdatedSuccessfully) {
//                 Navigator.pop(context, email.text);
//                 Navigator.pop(context, email.text);
//               } else {
//                 Navigator.pop(context, email.text);
//               }
//             },
//           ),
//         ),
//         body: LayoutBuilder(builder: (context, constraint) {
//           return BlocConsumer<ManageAccountCubit, ManageAccountState>(
//             bloc: cubit,
//             listener: (context, state) {
//               if (state is GetUserSuccessful) {
//                 updatedEmail = state.responseModel!.email!;
//               }
//             },
//             builder: (context, state) {
//               if (state is GetUserLoading) {
//                 // return const AccountInfoLoading(
//                 //   isLoading: true,
//                 // );
//               } else if (state is GetUserSuccessful) {
//                 return Form(
//                   key: _formKey,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: kPadding),
//                     child: SingleChildScrollView(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                             minHeight: constraint.maxHeight - 50.0),
//                         child: IntrinsicHeight(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               HeaderText("", "Account Information", true),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 7),
//                                 child: RebiInput(
//                                   hintText: state.responseModel!.fullName!,
//                                   hintStyle:
//                                       const TextStyle(color: AppColors.grey),
//                                   controller: name,
//                                   isItDisable: true,
//                                   keyboardType: TextInputType.name,
//                                   textInputAction: TextInputAction.done,
//                                   autoValidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   isOptional: false,
//                                   color: AppColors.formsLabel,
//                                   readOnly: true,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 13),
//                                   obscureText: false,
//                                   validator: (value) {
//                                     return;
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 7),
//                                 child: RebiInput(
//                                   hintText: state.responseModel!.email!,
//                                   hintStyle:
//                                       const TextStyle(color: AppColors.white),
//                                   controller: email,
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         settings:
//                                             RouteSettings(name: updatedEmail),
//                                         builder: (context) => UpdateEmailScreen(
//                                           previousEmail:
//                                               state.responseModel!.email!,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   keyboardType: TextInputType.emailAddress,
//                                   textInputAction: TextInputAction.done,
//                                   autoValidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   isOptional: false,
//                                   color: AppColors.formsLabel,
//                                   readOnly: true,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 13),
//                                   obscureText: false,
//                                   validator: (value) {
//                                     return;
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 7),
//                                 child: RebiInput(
//                                   hintText: state.responseModel!.phoneNumber!,
//                                   hintStyle:
//                                       const TextStyle(color: AppColors.white),
//                                   onTap: () {
//                                     Navigator.pushNamed(context, updatePhone);
//                                   },
//                                   controller: phone,
//                                   keyboardType: TextInputType.phone,
//                                   textInputAction: TextInputAction.done,
//                                   autoValidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   isOptional: false,
//                                   color: AppColors.formsLabel,
//                                   readOnly: true,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 13),
//                                   obscureText: false,
//                                   validator: (value) {
//                                     return;
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 7),
//                                 child: RebiInput(
//                                   hintText: state.responseModel!.userType,
//                                   controller: _preferences,
//                                   hintStyle:
//                                       const TextStyle(color: AppColors.grey),
//                                   keyboardType: TextInputType.name,
//                                   textInputAction: TextInputAction.done,
//                                   autoValidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   isOptional: false,
//                                   isItDisable: true,
//                                   color: AppColors.formsLabel,
//                                   readOnly: true,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 13),
//                                   obscureText: false,
//                                   validator: (value) {
//                                     return;
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 7),
//                                 child: RebiInput(
//                                   hintText: state.responseModel!.discipline,
//                                   hintStyle:
//                                       const TextStyle(color: AppColors.grey),
//                                   onTap: () {},
//                                   isItDisable: true,
//                                   controller: _discipline,
//                                   keyboardType: TextInputType.name,
//                                   textInputAction: TextInputAction.done,
//                                   autoValidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   isOptional: false,
//                                   color: AppColors.formsLabel,
//                                   readOnly: true,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 13),
//                                   obscureText: false,
//                                   validator: (value) {
//                                     return;
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 14),
//                                 child: RebiButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ChangePasswordScreen())).then(
//                                         (value) => cubit.getUser(
//                                             AppSharedPreferences
//                                                 .userPhoneNumber));
//                                   },
//                                   child: const Text(
//                                     "Reset Password",
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }
//               return Container();
//             },
//           );
//         }),
//       ),
//     );
//   }
// }
