import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../support/presentation/widgets/support_loading_shimmer.dart';
import '../../data/new_place_response_model.dart';
import '../../data/user_places_response_model.dart';
import '../../domain/cubits/home_cubit.dart';
import '../widgets/user_place_widget.dart';
import 'add_new_place_screen.dart';
import 'edit_place_screen.dart';

class UserPlacesScreen extends StatefulWidget {
  final String category;

  const UserPlacesScreen({super.key, required this.category});

  @override
  State<UserPlacesScreen> createState() => _UserPlacesScreenState();
}

class _UserPlacesScreenState extends State<UserPlacesScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getUserPlaces(limit: 1000);
    super.initState();
  }

  HomeCubit cubit = HomeCubit();

  bool selected = false;
  int? selectedIndex;
  AddNewPlaceResponseModel? result;
  UserPlace? userPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "My Places",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Add',
          onPressThirdOption: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddNewPlaceScreen(category: widget.category),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: context.read<HomeCubit>(),
          builder: (context, state) {
            if (state is GetUserPlacesSuccessfully) {
              if (state.count == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Center(child: SvgPicture.asset(AppIcons.emptyPlaces)),
                      const SizedBox(
                        height: 150,
                      ),
                      const Text(
                        'Easily manage your destinations by saving your places',
                        style: TextStyle(
                          color: Color(0xFF232F39),
                          fontSize: 28.26,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.94,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: selected ? 65.0.h : 85.0.h,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.count,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = true;
                                  selectedIndex = index;
                                  userPlace = state.places[index];

                                  result = AddNewPlaceResponseModel(
                                    name: state.places[index].name,
                                    id: state.places[index].id,
                                  );
                                });
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding, vertical: 5),
                                  child: UserPlaceWidget(
                                    selected: selectedIndex == index,
                                    placeDescription:
                                        state.places[index].desc ?? '',
                                    placeTitle: state.places[index].name!,
                                  )),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: selected,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 10),
                            child: RebiButton(
                                onPressed: () {
                                  Navigator.pop(context, result);
                                },
                                child: const Text(
                                  "Choose",
                                  style: AppStyles.buttonStyle,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 10),
                            child: RebiButton(
                              isBackButton: true,
                              onPressed: () {
                                setState(() {
                                  selected=false;
                                  selectedIndex=null;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPlaceScreen(
                                            name: userPlace!.name!,
                                            category: userPlace?.category??'Normal',
                                            placeId: userPlace!.id!,
                                            lat: userPlace!.lat!,
                                            lng: userPlace!.lng!)));
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(color: AppColors.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                );
              }
            }
            if (state is GetUserPlacesError) {
              return CustomErrorWidget(onRetry: () {
                BlocProvider.of<HomeCubit>(context).getUserPlaces(limit: 100);
              });
            } else if (state is GetUserPlacesLoading) {
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
