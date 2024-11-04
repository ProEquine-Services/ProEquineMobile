import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../horses/presentation/widgets/empty_horses_widget.dart';
import '../../../horses/presentation/widgets/main_horses_loading_widget.dart';
import '../../domain/associations_cubit.dart';
import '../widgets/associate_horse_details_widget.dart';
import '../widgets/invite_association_widget.dart';

class HorseRequestAssociationScreen extends StatefulWidget {
  const HorseRequestAssociationScreen({super.key});

  @override
  State<HorseRequestAssociationScreen> createState() =>
      _HorseRequestAssociationScreenState();
}

class _HorseRequestAssociationScreenState
    extends State<HorseRequestAssociationScreen> {
  @override
  void initState() {
    context.read<AssociationsCubit>().getInvitesAssociations('pending');
    super.initState();
  }

  AssociationsCubit cubit = AssociationsCubit();

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<AssociationsCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Associated Horses",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AssociationsCubit, AssociationsState>(
          // bloc: cubit,
          builder: (context, state) {
            if (state is GetInviteAssociationsSuccessfully) {
              if (state.invites.count == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: EmptyHorsesWidget(
                      associated: true,
                          associatedIcon: true,
                    ))
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    children: [
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2, // Adjust the number of columns
                          ),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.invites.count,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,),
                              child: GestureDetector(
                                onTap: () {
                                  final int associationId =
                                      state.invites.rows![index].id!;
                                  showGlobalBottomSheet(
                                      context: context,
                                      title:
                                          "${state.invites.rows![index].fUser!.firstName!} Association",
                                      content: Column(
                                        children: [
                                          AssociateHorseDetailsWidget(
                                              title: "Horse Name",
                                              value: state.invites.rows![index]
                                                  .horse!.name!),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Date of birth",
                                              value: state.invites.rows![index]
                                                  .horse!.dateOfBirth!),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Place of birth",
                                              value: state.invites.rows![index]
                                                  .horse!.placeOfBirth!),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Color",
                                              value: state.invites.rows![index]
                                                  .horse!.color!),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Bloodline",
                                              value: state.invites.rows![index]
                                                  .horse!.bloodLine!),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Discipline",
                                              value: state.invites.rows![index]
                                                      .horse!.discipline?.title ??
                                                  ''),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Stable",
                                              value: state.invites.rows![index]
                                                      .horse!.stable?.name ??
                                                  ''),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Associated By",
                                              value: '${state.invites.rows![index]
                                                  .fUser!.firstName!} - ${state.invites.rows![index]
                                                  .fUser!.id}'),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Associated Role",
                                              value: state
                                                  .invites.rows![index].type!),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          BlocConsumer<AssociationsCubit,
                                              AssociationsState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is ApproveAssociateHorseSuccessfully) {
                                                RebiMessage.success(
                                                    msg: state.message,
                                                    context: context);
                                                myCubit.getInvitesAssociations(
                                                    'pending');
                                                Navigator.pop(context);
                                              } else if (state
                                                  is ApproveAssociateHorseError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is ApproveAssociateHorseLoading) {
                                                return const LoadingCircularWidget();
                                              }
                                              return RebiButton(
                                                  onPressed: () {
                                                    onPressApprove(associationId);
                                                  },
                                                  child: Text(
                                                    "Accept",
                                                    style: AppStyles.buttonStyle,
                                                  ));
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          BlocConsumer<AssociationsCubit,
                                              AssociationsState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is RejectAssociateHorseSuccessfully) {
                                                RebiMessage.success(
                                                    msg: state.message,
                                                    context: context);
                                                myCubit.getInvitesAssociations(
                                                    'pending');
                                                Navigator.pop(context);
                                              } else if (state
                                                  is RejectAssociateHorseError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is RejectAssociateHorseLoading) {
                                                return const LoadingCircularWidget();
                                              }
                                              return GestureDetector(
                                                onTap: () {
                                                  onPressReject(associationId);
                                                },
                                                child: const Text(
                                                  'Reject',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFC48636),
                                                    fontSize: 16,
                                                    fontFamily: 'notosan',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ));
                                },
                                child: InviteAssociationWidget(
                                  associateName: state
                                      .invites.rows![index].fUser!.firstName!,
                                  associateRole: state.invites.rows![index].type!,
                                  type: state.invites.rows![index].status!,
                                  age: state.invites.rows![index].horse!.age
                                          ?.toString() ??
                                      '',
                                  gender:
                                      state.invites.rows![index].horse!.gender!,
                                  breed: state.invites.rows![index].horse!.breed!,
                                  horseName:
                                      state.invites.rows![index].horse!.name!,
                                  horsePic:
                                      state.invites.rows![index].horse!.image ??
                                          '',
                                  isVerified: true,
                                  horseStable:
                                      state.invites.rows![index].horse!.gender!,
                                  horseStatus:
                                      state.invites.rows![index].horse!.status!,
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                );
              }
            }
            if (state is GetInviteAssociationsError) {
              return CustomErrorWidget(onRetry: () {
                cubit.getInvitesAssociations('pending');
              });
            } else if (state is GetInviteAssociationsLoading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: MainHorsesLoadingWidget()),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  onPressApprove(int id) {
    cubit.approveHorseAssociation(id);
  }

  onPressReject(int id) {
    cubit.rejectHorseAssociation(id);
  }
}
