import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/support/domain/support_cubit.dart';
import 'package:proequine/features/support/presentation/screens/support.dart';
import 'package:proequine/features/support/presentation/widgets/support_loading_shimmer.dart';
import 'package:proequine/features/support/presentation/widgets/support_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';

class AllSupportRequestsScreen extends StatefulWidget {
  const AllSupportRequestsScreen({super.key});

  @override
  State<AllSupportRequestsScreen> createState() =>
      _AllSupportRequestsScreenState();
}

class _AllSupportRequestsScreenState extends State<AllSupportRequestsScreen> {
  @override
  void initState() {
    context.read<SupportCubit>().getAllRequests(limit: 1000);
    super.initState();
  }

  SupportCubit cubit = SupportCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Contact Support",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SupportScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SupportCubit, SupportState>(
          // bloc: cubit,
          builder: (context, state) {
            if (state is GetAllSupportSuccessful) {
              String formatDate(DateTime date) {
                // Define the date format
                final dateFormat = DateFormat("MMMM d, yyyy - hh:mm a");
                // Format the date
                final formattedDate = dateFormat.format(date);
                return formattedDate;
              }

              if (state.count == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(AppImages.emptySupportImage)),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Everything seems alright',
                      style: TextStyle(
                        color: Color(0xFF232F39),
                        fontSize: 28.26,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.05,
                        letterSpacing: -0.94,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'If not',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 11.30,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding,vertical: 20),
                      child: RebiButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const SupportScreen()));
                          },
                          child: const Text("Contact us")),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                );
              } else {

                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.count,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                showGlobalBottomSheet(
                                  context: context,
                                  title: state.responseModel[index].reference!,
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Initial info",
                                                style:
                                                    AppStyles.summaryTitleStyle,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                formatDate(DateTime.parse(state
                                                    .responseModel[index]
                                                    .createdOn!)),
                                                style:
                                                    AppStyles.summaryDesStyle,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Status",
                                                style:
                                                    AppStyles.summaryTitleStyle,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                state.responseModel[index]
                                                    .supportStatus!,
                                                style:
                                                    AppStyles.summaryDesStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const CustomDivider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state
                                                .responseModel[index].division!,
                                            style: AppStyles.summaryTitleStyle,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.responseModel[index].subject!,
                                            style: AppStyles.summaryDesStyle,
                                          ),
                                        ],
                                      ),
                                      const CustomDivider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Inquiry",
                                            style: AppStyles.summaryTitleStyle,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.responseModel[index]
                                                .supportInquiry!,
                                            style: AppStyles.summaryDesStyle,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: state.responseModel[index]
                                                    .supportResponse !=
                                                ''
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
                                                  "Response",
                                                  style: AppStyles
                                                      .summaryTitleStyle,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  state.responseModel[index]
                                                      .supportResponse!,
                                                  style:
                                                      AppStyles.summaryDesStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: SupportWidget(
                                date: formatDate(DateTime.parse(state
                                        .responseModel[index].createdOn!)),
                                status:
                                    state.responseModel[index].supportStatus ??
                                        'Pending',
                                type: state.responseModel[index].subject ??
                                    'Transport',
                                title: state.responseModel[index].division ??
                                    'Feedback',
                                reference:
                                    state.responseModel[index].reference ??
                                        'SPR09183',
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                );
              }
            }
            if (state is GetAllSupportError) {
              return CustomErrorWidget(onRetry: () {
                cubit.getAllRequests(limit: 100);
              });
            } else if (state is GetAllSupportLoading) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: SupportLoadingWidget()),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
