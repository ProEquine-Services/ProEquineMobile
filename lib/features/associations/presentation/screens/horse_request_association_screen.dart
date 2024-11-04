import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../horses/data/get_user_horses_response_model.dart';
import '../../../horses/presentation/screens/edit_horse_screen.dart';
import '../../../horses/presentation/widgets/horse_card_document_widget.dart';
import '../../data/associate_horse_request_model.dart';
import '../../domain/associations_cubit.dart';
import '../widgets/associate_horse_details_widget.dart';
import '../widgets/requests_association_widget.dart';

class HorseInvitesAssociations extends StatefulWidget {
  final String horseId;
  final Horse horseList;

  const HorseInvitesAssociations(
      {super.key, required this.horseId, required this.horseList});

  @override
  State<HorseInvitesAssociations> createState() =>
      _HorseInvitesAssociationsState();
}

class _HorseInvitesAssociationsState extends State<HorseInvitesAssociations> {
  final TextEditingController? userName = TextEditingController();
  final TextEditingController? peIdController = TextEditingController();
  final TextEditingController? associationType = TextEditingController();
  List<DropdownMenuItem<String>> role = [
    const DropdownMenuItem(
      value: "Owner",
      child: Text("Owner"),
    ),
    const DropdownMenuItem(
      value: "Rider",
      child: Text("Rider"),
    ),
    const DropdownMenuItem(
      value: "Groom",
      child: Text("Groom"),
    ),
    const DropdownMenuItem(
      value: "Trainer",
      child: Text("Trainer"),
    ),
  ];
  String? selectedRole;

  AssociationsCubit cubit = AssociationsCubit();
  bool isUsernameVisible = true;

  @override
  void initState() {
    context
        .read<AssociationsCubit>()
        .getRequestsAssociations(int.parse(widget.horseId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<AssociationsCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "${widget.horseList.name} Association",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            showGlobalBottomSheet(
                context: context,
                title: "${widget.horseList.name} Association",
                content: StatefulBuilder(builder: (context, setState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Row(
                          children: [
                            const Text(
                              'Association By: Username',
                              style: TextStyle(
                                  color: AppColors.blackLight,
                                  fontWeight: FontWeight.w400),
                            ),
                            Switch(
                              value: isUsernameVisible,
                              activeColor: AppColors.yellow,
                              onChanged: (newValue) {
                                Print(newValue);
                                setState(() {
                                  isUsernameVisible = newValue;
                                });
                              },
                            ),
                            const Text(' PEID'),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !isUsernameVisible,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: RebiInput(
                            hintText: 'Username'.tra,
                            controller: userName,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            isOptional: false,
                            color: AppColors.formsLabel,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {
                              peIdController!.text = '';
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isUsernameVisible,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: RebiInput(
                            hintText: 'PEID'.tra,
                            controller: peIdController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            isOptional: false,
                            color: AppColors.formsLabel,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {
                              setState(() {
                                userName!.text = '';
                              });
                            },
                          ),
                        ),
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: DropDownWidget(
                            items: role,
                            selected: selectedRole,
                            onChanged: (role1) {
                              setState(() {
                                selectedRole = role1;
                                Print('selected role $selectedRole');
                              });
                            },
                            validator: (value) {
                              // return Validator.requiredValidator(selectedNumber);
                            },
                            hint: 'Association Type',
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer(
                          bloc: cubit,
                          builder: (context, state) {
                            if (state is AssociateHorseLoading) {
                              return const LoadingCircularWidget();
                            }
                            return RebiButton(
                              onPressed: () {
                                if(selectedRole != null) {
                                  if (isUsernameVisible) {
                                    _onPressAdd(
                                        int.parse(peIdController!.text));
                                  } else {
                                    _onPressAdd(0);
                                  }
                                }
                              },
                              child: const Text(
                                "Submit",
                                style: AppStyles.buttonStyle,
                              ),
                            );
                          },
                          listener: (context, state) {
                            if (state is AssociateHorseSuccessfully) {
                              myCubit.getRequestsAssociations(
                                  int.parse(widget.horseId));
                              Navigator.pop(context);
                            } else if (state is AssociateHorseError) {
                              RebiMessage.error(
                                  msg: state.message!, context: context);
                            }
                          })
                    ],
                  );
                }));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () async {
                    String? userId = await SecureStorage().getUserId();
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditHorseScreen(
                                    userId: int.parse(userId!),
                                    horse: widget.horseList,
                                  )));
                    }
                  },
                  child: HorseCardDocumentWidget(
                    fromOut: false,
                    placeOfBirth: widget.horseList.placeOfBirth!,
                    age: widget.horseList.age.toString(),
                    gender: widget.horseList.gender!,
                    breed: widget.horseList.breed!,
                    horseName: widget.horseList.name!,
                    discipline: widget.horseList.discipline!.title!,
                    isVerified: widget.horseList.isVerified!,
                    horseStable: widget.horseList.stable!.name!,
                    horseStatus: widget.horseList.status!,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Associations",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              BlocBuilder<AssociationsCubit, AssociationsState>(
                builder: (context, state) {
                  if (state is GetRequestsAssociationsSuccessfully) {
                    if (state.model.count == 0) {
                      return const Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'Your horse has no Invites',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF8B9299),
                                fontSize: 20,
                                fontFamily: 'notosan',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.model.count,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                                onTap: () {
                                  final int associationId =
                                      state.model.rows![index].id!;
                                  showGlobalBottomSheet(
                                      context: context,
                                      title:
                                          "${state.model.rows![index].horse!.name!} Association",
                                      content: Column(
                                        children: [
                                          AssociateHorseDetailsWidget(
                                              title: "Stable",
                                              value: state.model.rows![index]
                                                      .horse!.stable?.name ??
                                                  ''),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Associated By",
                                              value: state.model.rows![index]
                                                  .fUser!.firstName!),
                                          const CustomDivider(),
                                          AssociateHorseDetailsWidget(
                                              title: "Associated Role",
                                              value: state
                                                  .model.rows![index].type!),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          BlocConsumer<AssociationsCubit,
                                              AssociationsState>(
                                            bloc: cubit,
                                            listener: (context, state) {
                                              if (state
                                                  is CancelAssociateHorseSuccessfully) {
                                                RebiMessage.success(
                                                    msg: state.message,
                                                    context: context);
                                                myCubit.getRequestsAssociations(
                                                    int.parse(widget.horseId));
                                                Navigator.pop(context);
                                              } else if (state
                                                  is CancelAssociateHorseError) {
                                                RebiMessage.error(
                                                    msg: state.message!,
                                                    context: context);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is CancelAssociateHorseLoading) {
                                                return const LoadingCircularWidget(
                                                  isDeleteButton: true,
                                                );
                                              }
                                              return GestureDetector(
                                                onTap: () {
                                                  onPressCancel(associationId);
                                                },
                                                child: const Text(
                                                  'Disassociate',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFF0000),
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: RequestAssociateWidget(
                                    role: state.model.rows![index].type,
                                    title: state
                                        .model.rows![index].tUser!.userName!,
                                    status: state.model.rows![index].status,
                                  ),
                                ),
                              ));
                    }
                  } else if (state is GetRequestsAssociationsError) {
                    return CustomErrorWidget(onRetry: () {
                      cubit.getRequestsAssociations(int.parse(widget.horseId));
                    });
                  } else if (state is GetRequestsAssociationsLoading) {
                    return const LoadingCircularWidget();
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _onPressAdd(int peId) {
    cubit.createHorseAssociation(AssociateHorseRequestModel(
      horseId: int.parse(widget.horseId),
      peId: peId,
      userName: userName!.text,
      type: selectedRole,
    ));
  }

  onPressCancel(int id) {
    cubit.cancelHorseAssociation(id);
  }
}
