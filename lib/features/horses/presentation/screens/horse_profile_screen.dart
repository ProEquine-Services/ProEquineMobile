import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../../../associations/presentation/screens/horse_request_association_screen.dart';
import '../../data/get_user_horses_response_model.dart';
import '../../domain/horse_cubit.dart';
import '../widgets/horse_card_document_widget.dart';
import 'edit_horse_screen.dart';
import 'horse_document_screen.dart';
import 'horse_verification_screen.dart';

class HorseProfileScreen extends StatefulWidget {
  final Horse response;

  const HorseProfileScreen({super.key, required this.response});

  @override
  State<HorseProfileScreen> createState() => _HorseProfileScreenState();
}

class _HorseProfileScreenState extends State<HorseProfileScreen> {
  int calculateAge(DateTime dob) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dob.year;
    int month1 = currentDate.month;
    int month2 = dob.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = dob.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    var myCubit = context.watch<HorseCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Horse Profile",
          isThereBackButton: true,
          isThereChangeWithNavigate: true,
          isThereThirdOption: false,
          onPressBack: () {
            myCubit.getAllHorses(limit: 100);
            Navigator.pop(context);
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
                                    horse: widget.response,
                                  )));
                    }
                  },
                  child: HorseCardDocumentWidget(
                    fromOut: true,
                    placeOfBirth: widget.response.placeOfBirth!,
                    age: widget.response.age.toString(),
                    gender: widget.response.gender!,
                    breed: widget.response.breed!,
                    horseName: widget.response.name!,
                    discipline: widget.response.discipline!.title!,
                    isVerified: widget.response.isVerified!,
                    horseStable: widget.response.stable?.name??'Deleted',
                    horseStatus: widget.response.status!,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0,vertical: 4),
                child: Text(
                  "Horse Services",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),
              ProfileListTileWidget(
                title: "Horse Details",
                onTap: () async {
                  String? userId = await SecureStorage().getUserId();
                  if (context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditHorseScreen(
                              userId: int.parse(userId!),
                              horse: widget.response,
                            )));
                  }
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Horse Association",
                onTap: () async {
                  // String? userId = await SecureStorage().getUserId();
                  Print(widget.response.discipline!.title);
                  if (context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HorseInvitesAssociations(
                                  horseId: widget.response.id.toString(),
                                  horseList: widget.response,
                                )));
                  }
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Horse Document",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HorseDocumentScreen(
                                horseId: widget.response.id.toString(),
                                horseList: widget.response,
                              )));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !widget.response.isVerified!,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RebiButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HorseVerificationScreen(
                                    horseId: widget.response.id!,
                                  )));
                    },
                    child: const Text(
                      "Get your horse verified",
                      style: AppStyles.buttonStyle,
                    ),
                  ),
                ),
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
}
