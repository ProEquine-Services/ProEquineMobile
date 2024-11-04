import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/Printer.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/user/presentation/screens/role_screen.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';
import '../widgets/selectable_type_container.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final UserCubit cubit = UserCubit();
  List<bool> _isInterestsSelected = [];
  String? interest;
  int? selectedInterestId;
  String? userType;

  @override
  void initState() {
    _isInterestsSelected = List<bool>.generate(20, (counter) => false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              RegistrationHeader(isThereBackButton: false),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  children: [

                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //       "This can be anything you like and can be changed later, chose your Main discipline and role.",
                    //       style: AppStyles.descriptions),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("What are you interested in",
                          style: AppStyles.mainTitle2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      itemCount: 9,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 8,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 1),
                      itemBuilder: (context, index) {
                        return SelectableTypeContainer(
                          label: interests[index],
                          index: index,
                          isSelected: _isInterestsSelected[index],
                          onSelected: (bool value) {
                            _handleSelected(index, value, _isInterestsSelected);
                            interest = interests[index];
                            selectedInterestId=index +1 ;
                            Print("Selected type $interest");
                            Print("Selected type id $selectedInterestId");
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: RebiButton(
                    backgroundColor: interest != null
                        ? AppColors.yellow
                        : AppColors.formsLabel,
                    onPressed: () {
                      if (interest != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RoleScreen(
                                    selectedMainInterest: selectedInterestId!)));
                      } else {
                        RebiMessage.error(
                            msg: 'Select your interests.',
                            context: context);
                      }
                    },
                    child:  Text("Next", style: AppStyles.buttonStyle,),
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _handleSelected(int index, bool value, var isSelected) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = false;
      }
      isSelected[index] = value;
    });
  }
}
