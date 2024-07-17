// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:proequine/core/constants/constants.dart';
// import 'package:proequine/core/constants/images/app_images.dart';
// import 'package:proequine/core/utils/extensions.dart';
// import 'package:proequine/core/utils/rebi_message.dart';
// import 'package:proequine/core/widgets/loading_widget.dart';
// import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/colors/app_colors.dart';
// import '../../../../core/constants/routes/routes.dart';
// import '../../../../core/constants/thems/app_styles.dart';
// import '../../../../core/utils/validator.dart';
// import '../../../../core/widgets/custom_header.dart';
//
// import '../../../../core/widgets/rebi_button.dart';
// import '../../../../core/widgets/rebi_input.dart';
// import 'package:intl/date_symbol_data_local.dart';
//
// import '../../data/basic_account_management_route.dart';
//
// class BioScreen extends StatefulWidget {
//   const BioScreen({super.key});
//
//   @override
//   State<BioScreen> createState() => _BioScreenState();
// }
//
// class _BioScreenState extends State<BioScreen> {
//   late final TextEditingController bio;
//   late final TextEditingController instagramLink;
//   late final TextEditingController facebookLink;
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? selectedGender;
//   String? selectedState;
//   ManageAccountCubit cubit = ManageAccountCubit();
//
//   @override
//   void initState() {
//     initializeDateFormatting();
//     bio = TextEditingController();
//     instagramLink = TextEditingController();
//     facebookLink = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     bio.dispose();
//     instagramLink.dispose();
//     cubit.close();
//     facebookLink.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(20.h),
//         child: CustomHeader(
//           title: "Bio & Social",
//           isThereBackButton: true,
//           isThereChangeWithNavigate: false,
//           isThereThirdOption: false,
//         ),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraint) {
//             return Form(
//               key: _formKey,
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraint.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: kPadding),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 7),
//                               child: RebiInput(
//                                 hintText: 'Bio'.tra,
//                                 controller: bio,
//                                 keyboardType: TextInputType.text,
//                                 textInputAction: TextInputAction.done,
//                                 isOptional: false,
//                                 color: AppColors.formsLabel,
//                                 readOnly: false,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 13),
//                                 obscureText: false,
//                                 validator: (value) {
//                                   return Validator.requiredValidator(bio.text);
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 7),
//                               child: RebiInput(
//                                 hintText: 'Instagram'.tra,
//                                 controller: instagramLink,
//                                 prefixIcon:
//                                     SvgPicture.asset(AppIcons.instagramIcon),
//                                 keyboardType: TextInputType.text,
//                                 textInputAction: TextInputAction.done,
//                                 isOptional: false,
//                                 color: AppColors.formsLabel,
//                                 readOnly: false,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 13),
//                                 obscureText: false,
//                                 validator: (value) {
//                                   return Validator.requiredValidator(
//                                       instagramLink.text);
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 7),
//                               child: RebiInput(
//                                 hintText: 'Facebook'.tra,
//                                 controller: facebookLink,
//                                 keyboardType: TextInputType.text,
//                                 textInputAction: TextInputAction.done,
//                                 prefixIcon:
//                                     SvgPicture.asset(AppIcons.facebookIcon),
//                                 isOptional: false,
//                                 color: AppColors.formsLabel,
//                                 readOnly: false,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 13),
//                                 obscureText: false,
//                                 validator: (value) {
//                                   return Validator.requiredValidator(
//                                       facebookLink.text);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.all(kPadding),
//                         child: BlocConsumer<ManageAccountCubit,
//                             ManageAccountState>(
//                           bloc: cubit,
//                           listener: (context, state) {
//                             if (state is AddBioError) {
//                               RebiMessage.error(
//                                   msg: state.message!, context: context);
//                             } else if (state is AddBioSuccessful) {
//                               Navigator.pushReplacementNamed(
//                                   context, successScreen,
//                                   arguments: BasicAccountManagementRoute(
//                                       type: 'manageAccount',
//                                       title: state.message!));
//                             }
//                           },
//                           builder: (context, state) {
//                             if (state is AddBioLoading) {
//                               return const LoadingCircularWidget();
//                             }
//                             return RebiButton(
//                               onPressed: () {
//                                 if(instagramLink.text.isNotEmpty || facebookLink.text.isNotEmpty){
//                                   addBio();
//                                 }else{
//                                   RebiMessage.warning(msg: "Please add something", context: context);
//                                 }
//                               },
//                               child:  Text(
//                                 "Add",
//                                 style: AppStyles.buttonStyle,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   addBio() {
//     // cubit.addBio(AddBioRequestModel(bio: bio.text, socialMediaAccountDTOs: [
//     //   SocialMediaAccountDTOs(
//     //     socialMediaAccountName: "Instagram",
//     //     socialMediaUserName: instagramLink.text,
//     //   ),
//     //   SocialMediaAccountDTOs(
//     //     socialMediaAccountName: "Facebook",
//     //     socialMediaUserName: facebookLink.text,
//     //   ),
//     // ]));
//   }
// }
