import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/utils/Printer.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/widgets/custom_error_widget.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:proequine_dev/features/shipping/domain/shipping_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/privacy_checkbox.dart';
import '../../../home/data/shipping_service_model.dart';

class ConfirmHorsesScreen extends StatefulWidget {
  final ShippingServiceModel? serviceModel;
  final int shippingId;
  final String selectedCountry;

  const ConfirmHorsesScreen(
      {super.key,
      this.serviceModel,
      required this.selectedCountry,
      required this.shippingId});

  @override
  State<ConfirmHorsesScreen> createState() => _ConfirmHorsesScreenState();
}

class _ConfirmHorsesScreenState extends State<ConfirmHorsesScreen> {
  bool privacyValue = false;
  ShippingCubit cubit = ShippingCubit();

  @override
  void initState() {
    BlocProvider.of<ShippingCubit>(context)
        .getShippingDetails(widget.shippingId);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: dispose All Controllers with all cubits
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd/MM/yy');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Confirmation",
          isThereBackButton: false,

          // onPressBack: (){
          //   Navigator.pop(context);
          //   Navigator.pop(context);
          // },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: BlocBuilder<ShippingCubit, ShippingState>(
          builder: (context, state) {
            if (state is GetShippingSuccessfully) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      constraints: BoxConstraints(
                          minHeight: 100, minWidth: 100, maxHeight: 60.0.h),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 19),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipment Details",
                                    style: AppStyles.summaryTitleStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.serviceModel?.serviceType == 'Export'
                                        ? "Export Shipment"
                                        : "Import Shipment",
                                    style: AppStyles.summaryDesStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.serviceModel?.serviceType ==
                                                'Export'
                                            ? "UAE"
                                            : widget.selectedCountry,
                                        style: AppStyles.bookingContent,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                        AppIcons.directArrow,
                                        height: 20,
                                        width: 40,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.serviceModel?.serviceType ==
                                                'Export'
                                            ? widget.selectedCountry
                                            : "UAE",
                                        style: AppStyles.bookingContent,
                                      ),
                                      const Spacer(),
                                      Text(
                                        f.format(widget.serviceModel!
                                            .shipmentEstimatedDate),
                                        style: AppStyles.bookingContent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const CustomDivider(),
                              ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Horse ${index + 1}",
                                            style: AppStyles.summaryTitleStyle),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          state.responseModel.horses![index]
                                              .horse!.name!,
                                          style: AppStyles.bookingContent,
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const CustomDivider();
                                  },
                                  itemCount:
                                      state.responseModel.horses!.length),
                              Visibility(
                                visible: state.responseModel.notes != null
                                    ? true
                                    : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomDivider(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Notes",
                                          style: AppStyles.summaryTitleStyle,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          state.responseModel.notes!,
                                          style: AppStyles.summaryDesStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-10.0, 0.0),
                      child: PrivacyCheckBox(
                          isTherePrivacy: true,
                          value: privacyValue,
                          isItForShipping: true,
                          onChanged: (value) {
                            Print(widget.serviceModel!.serviceType);
                            setState(() {
                              privacyValue = value!;
                            });
                          }),
                    ),
                    const Spacer(),
                    BlocConsumer<ShippingCubit, ShippingState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is PushShippingError) {
                          RebiMessage.error(
                              msg: state.message!, context: context);
                        } else if (state is PushShippingSuccessfully) {
                          RebiMessage.success(
                              msg: "Request submitted successfully.",
                              context: context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomNavigation(
                                        selectedIndex: 2,
                                      )));
                        }
                      },
                      builder: (context, state) {
                        if (state is PushShippingLoading) {
                          return const LoadingCircularWidget();
                        }
                        return RebiButton(
                            backgroundColor: privacyValue
                                ? AppColors.yellow
                                : AppColors.formsHintFontLight,
                            onPressed: () {
                              _onSubmit();
                            },
                            child: Text(
                              "Submit",
                              style: AppStyles.buttonStyle,
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ]);
            } else if (state is GetShippingError) {
              return CustomErrorWidget(onRetry: () {});
            } else if (state is GetShippingLoading) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingCircularWidget(),
                ],
              );
            }
            return Container(
              color: Colors.grey,
            );
          },
        ),
      ),
    );
  }

  _onSubmit() {
    cubit.pushShipping(widget.shippingId);
  }
}
