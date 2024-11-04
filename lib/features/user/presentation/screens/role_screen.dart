import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/features/stables/presentation/screens/choose_stable_screen.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../data/interests_request_model.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';
import '../widgets/selectable_type_container.dart';

class RoleScreen extends StatefulWidget {
  final int selectedMainInterest;

  const RoleScreen({Key? key, required this.selectedMainInterest})
      : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final UserCubit cubit = UserCubit();
  List<String> selectedRoles = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              RegistrationHeader(isThereBackButton: true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("I'm a", style: AppStyles.mainTitle),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 1,
                      childAspectRatio: (9 / 1),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 8,
                      children: [
                        SelectableTypeContainer(
                          label: 'Rider',
                          isSelected: selectedRoles.contains('Rider'),
                          onSelected: (bool value) {
                            _handleSelected('Rider', value);
                          },
                          index: 0,
                        ),
                        SelectableTypeContainer(
                          index: 1,
                          label: 'Owner',
                          isSelected: selectedRoles.contains('Owner'),
                          onSelected: (bool value) {
                            _handleSelected('Owner', value);
                          },
                        ),
                        SelectableTypeContainer(
                          index: 2,
                          label: 'Trainer',
                          isSelected: selectedRoles.contains('Trainer'),
                          onSelected: (bool value) {
                            _handleSelected('Trainer', value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Manage my horse and request services ",
                          style: AppStyles.descriptions),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("I, As a", style: AppStyles.mainTitle),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 1,
                      childAspectRatio: (9 / 1),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 8,
                      children: [
                        SelectableTypeContainer(
                          index: 4,
                          label: 'Groom',
                          isSelected: selectedRoles.contains('Groom'),
                          onSelected: (bool value) {
                            _handleSelected('Groom', value);
                          },
                        ),
                        // SelectableTypeContainer(
                        //   index: 5,
                        //   label: 'Spectator',
                        //   isSelected: selectedRoles.contains('Spectator'),
                        //   onSelected: (bool value) {
                        //     _handleSelected('Spectator', value);
                        //   },
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "View horses assigned to me and explore ProEquine App ",
                          style: AppStyles.descriptions),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSelectTypeConsumer(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildSelectTypeConsumer() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SelectInterestsLoading) {
            return const LoadingCircularWidget();
          }
          {
            return RebiButton(
              backgroundColor: selectedRoles.isNotEmpty
                  ? AppColors.yellow
                  : AppColors.formsLabel,
              onPressed: () {
                if (selectedRoles.isNotEmpty) {
                  Print(selectedRoles);
                  Print(widget.selectedMainInterest);
                  _onPressConfirm();
                } else {
                  RebiMessage.error(
                      msg: 'Select at least 1 role', context: context);
                }
              },
              child:  Text("Next", style: AppStyles.buttonStyle,),
            );
          }
        },
        listener: (context, state) {
          if (state is SelectInterestsSuccessful) {
            AppSharedPreferences.typeSelected = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChoseStableScreen()));
          } else if (state is SelectInterestsError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
        });
  }

  _onPressConfirm() {
    return cubit
      ..interests(InterestsRequestModel(
        mainDisciplineId: widget.selectedMainInterest,
        roles: selectedRoles,
      ));
  }

  void _handleSelected(String role, bool selected) {
    setState(() {
      if (selected) {
        // If the role is already selected, remove it
        if (selectedRoles.contains(role)) {
          selectedRoles.remove(role);
        } else if (role == 'Groom' || role == 'Spectator') {
          // If Groom or Spectator is selected, deselect roles from the first section
          selectedRoles.clear();
          selectedRoles.add(role);
        } else {
          // If a role from the first section is selected, deselect Groom and Spectator
          if (selectedRoles.contains('Groom')) {
            selectedRoles.remove('Groom');
          }
          if (selectedRoles.contains('Spectator')) {
            selectedRoles.remove('Spectator');
          }
          // Add the selected role
          selectedRoles.add(role);
        }
      } else {
        // Deselect the role
        selectedRoles.remove(role);
      }
    });
  }
}
