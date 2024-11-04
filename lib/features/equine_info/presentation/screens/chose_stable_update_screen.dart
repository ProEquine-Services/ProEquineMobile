import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/features/equine_info/presentation/screens/update_main_stable_screen.dart';
import 'package:proequine_dev/features/equine_info/presentation/screens/update_secondary_stable_screen.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';
import '../../domain/equine_info_cubit.dart';
import 'add_secondary_stable_screen.dart';

class ChooseUpdateStableScreen extends StatefulWidget {
  final int userId;

  const ChooseUpdateStableScreen({super.key, required this.userId});

  @override
  State<ChooseUpdateStableScreen> createState() =>
      _ChooseUpdateStableScreenState();
}

class _ChooseUpdateStableScreenState extends State<ChooseUpdateStableScreen> {
  EquineInfoCubit cubit = EquineInfoCubit();

  bool isThereAdd = true;

  @override
  void initState() {
    Print("user id is ${widget.userId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Stables",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: isThereAdd,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            if (isThereAdd) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddSecondaryStableScreen()));
            } else {}
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
            bloc: cubit..getUserStables(widget.userId),
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetUserStablesLoading) {
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingCircularWidget(),
                    )
                  ],
                );
              }
              if (state is GetUserStablesSuccessful) {
                if (state.model!.rows!.isEmpty) {
                  isThereAdd = false;
                  return const Center(
                      child: Text(
                    "Waiting for confirm",
                    style: AppStyles.profileBlackTitles,
                  ));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Main Stable",
                        style: AppStyles.profileTitles,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          int mainStableIndex = state.model!.rows!.indexWhere((stable) => stable.isMainStable == true);
                          if (mainStableIndex != -1) {
                            Print("Index of main priority stable: $mainStableIndex");
                          } else {
                            Print("No stable with 'main' priority found.");
                          }
                          return ProfileTwoLineListTile(
                            title: state.model!.rows![mainStableIndex].stable!.name,
                            subTitle:
                                'UAE, ${state.model!.rows![mainStableIndex].stable!.emirate}',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateMainStableScreen(
                                            stableId: state
                                                .model!.rows![mainStableIndex].stableId!,
                                            mainStable: state.model!
                                                .rows![mainStableIndex].stable!.name!,
                                          )));
                            },
                            ableToEdit: true,
                          );
                        }),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    state.model!.rows!.length > 1
                        ? Transform.translate(
                            offset: Offset(0.0, -2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text(
                                    "Secondary Stable",
                                    style: AppStyles.profileTitles,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.model!.rows!.length - 1,
                                    itemBuilder: (context, index) {
                                      List secondaryStables = state.model!.rows!.where((stable) => stable.isMainStable == false).toList();
                                      return ProfileTwoLineListTile(
                                        title: secondaryStables[index]
                                            .stable!.name!,
                                        subTitle:
                                            'UAE, ${secondaryStables[index].stable!.emirate ?? ''}',
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DeleteSecondaryStableScreen(
                                                        personStableId: secondaryStables[index]
                                                            .id!,
                                                        secondaryStable: secondaryStables[index]
                                                            .stable!
                                                            .name!,
                                                      )));
                                        },
                                        ableToEdit: true,
                                      );
                                    }),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              } else if (state is GetUserStablesError) {
                return CustomErrorWidget(
                    errorMessage: state.message!,
                    onRetry: () {
                      cubit.getUserStables(widget.userId);
                    });
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
