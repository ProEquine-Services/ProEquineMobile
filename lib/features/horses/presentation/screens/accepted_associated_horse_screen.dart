import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../associations/data/horse_associated_requests_response_model.dart';
import '../../../associations/presentation/widgets/associate_horse_details_widget.dart';

class AssociatedHorseDetailsScreen extends StatefulWidget {
  final RequestedHorseModel ? requestedHorseModel;
  const AssociatedHorseDetailsScreen({super.key, this.requestedHorseModel});

  @override
  State<AssociatedHorseDetailsScreen> createState() => _AssociatedHorseDetailsScreenState();
}

class _AssociatedHorseDetailsScreenState extends State<AssociatedHorseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Horse Details",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),

          Container(

            margin:const EdgeInsets.symmetric(horizontal: kPadding,vertical: 0) ,
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child:Column(
              children: [
                AssociateHorseDetailsWidget(
                    title: "Horse Name",
                    value: widget.requestedHorseModel!
                        .horse!.name!),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Date of birth",
                    value: widget.requestedHorseModel!
                        .horse!.dateOfBirth!),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Place of birth",
                    value: widget.requestedHorseModel!
                        .horse!.placeOfBirth!),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Color",
                    value: widget.requestedHorseModel!
                        .horse!.color!),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Bloodline",
                    value: widget.requestedHorseModel!
                        .horse!.bloodLine!),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Discipline",
                    value: widget.requestedHorseModel!
                        .horse!.discipline?.title ??
                        ''),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Stable",
                    value: widget.requestedHorseModel!
                        .horse!.stable?.name ??
                        ''),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Associated By",
                    value: widget.requestedHorseModel!
                        .fUser!.firstName!),
                const CustomDivider(),
                AssociateHorseDetailsWidget(
                    title: "Associated Role",
                    value: widget.requestedHorseModel!.type!),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
