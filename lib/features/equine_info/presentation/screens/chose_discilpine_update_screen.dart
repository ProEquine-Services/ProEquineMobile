import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/features/equine_info/presentation/screens/update_secondary_discipline_screen.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/profile_two_lines_list_tile.dart';
import '../../domain/equine_info_cubit.dart';
import 'add_secondary_discipline_screen.dart';

class ChooseDisciplineScreen extends StatefulWidget {
  final int userId;

  const ChooseDisciplineScreen({super.key, required this.userId});

  @override
  State<ChooseDisciplineScreen> createState() => _ChooseDisciplineScreenState();
}

class _ChooseDisciplineScreenState extends State<ChooseDisciplineScreen> {
  EquineInfoCubit cubit = EquineInfoCubit();

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Discipline",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AddSecondaryDisciplineScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
            bloc: cubit..getUserDiscipline(widget.userId),
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetUserDisciplineLoading) {
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
              if (state is GetUserDisciplineSuccessful) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Main Discipline",
                        style: AppStyles.profileTitles,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // int mainDisciplineIndex = state.model!.rows!
                          //     .indexWhere(
                          //         (stable) => stable.disciplinePriority == "Main");
                          // if (mainDisciplineIndex != -1) {
                          //   Print(
                          //       "Index of main priority discipline: $mainDisciplineIndex");
                          // } else {
                          //   Print("No discipline with 'main' priority found.");
                          // }
                          return ProfileTwoLineListTile(
                            title: state.model!.rows![index].discipline!.title,
                            subTitle: "",
                            // subTitle:
                            //     "National id: ${state.model!.rows![index].discipline!.code ?? "Not Applicable"} \nFei ID: ${state.model!.rows![index].discipline! ?? "Not Applicable"} ",
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             UpdateMainDiscipline(
                              //               userDiscipline: state
                              //                   .model!
                              //                   .rows![index]
                              //                   .discipline!
                              //                   .title!,
                              //             )));
                            },
                            ableToEdit: true,
                          );
                        }),
                    state.model!.rows!.length > 1
                        ? Transform.translate(
                            offset: Offset(0.0, -2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text(
                                    "Secondary Discipline",
                                    style: AppStyles.profileTitles,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        state.model!.rows!.length - 1,
                                    itemBuilder: (context, index) {
                                      // List secondaryDisciplines = state
                                      //     .model!.disciplines!
                                      //     .where((discipline) =>
                                      //         discipline.disciplinePriority ==
                                      //         "Secondary")
                                      //     .toList();

                                      return ProfileTwoLineListTile(
                                        title:state
                                            .model!
                                            .rows![index+1]
                                            .discipline!
                                            .title!,

                                        subTitle: "",
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => UpdateSecondaryDisciplineScreen(
                                                      disciplineId:
                                                      state
                                                          .model!
                                                          .rows![index+1]
                                                          .discipline!.id!
                                                              .toString(),
                                                      secondaryDiscipline:
                                                      state
                                                          .model!
                                                          .rows![index+1]
                                                          .discipline!
                                                              .title!)));
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
              } else if (state is GetUserDisciplineError) {
                return CustomErrorWidget(
                    errorMessage: state.message!, onRetry: () {});
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
