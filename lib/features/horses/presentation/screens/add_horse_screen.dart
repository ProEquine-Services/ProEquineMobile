import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/global_functions/global_statics_drop_down.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/chose_picture_bottom_sheet.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/core/widgets/user_stables_widget.dart';
import 'package:proequine/features/horses/data/add_horse_request_model.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_colors_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/pick_image.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../equine_info/presentation/widgets/disciplines_widget.dart';
import '../../../user/presentation/widgets/selectable_type_container.dart';

class AddHorseScreen extends StatefulWidget {
  final int userId;

  const AddHorseScreen({super.key, required this.userId});

  @override
  AddHorseScreenState createState() => AddHorseScreenState();
}

class AddHorseScreenState extends State<AddHorseScreen> {
  HorseCubit cubit = HorseCubit();
  File? horseImage;
  late String image;
  TextEditingController? horseName;

  var now = DateTime.now();
  final List<bool> _isGenderSelected = [false, false, false];

  late final TextEditingController discipline;
  late final TextEditingController horseColor;
  late final TextEditingController disciplineId;
  late final TextEditingController stableId;

  late final TextEditingController stable;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? horseUrl;

  @override
  void initState() {
    initializeDateFormatting();
    image = AppIcons.horse;
    horseName = TextEditingController();
    discipline = TextEditingController();
    horseColor = TextEditingController();
    disciplineId = TextEditingController();
    stableId = TextEditingController();
    stable = TextEditingController();
    super.initState();
  }

  String? selectedGender;
  String? selectedColor;
  ImageHelper imageHelper = ImageHelper();

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<HorseCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Add Horse",
          isThereBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    horseImage == null
                        ? Container(
                            height: 18.0.h,
                            width: 48.0.w,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFDFD9C9),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    AppIcons.horse,
                                    height: 30,
                                    width: 40,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    showChosePictureBottomSheet(
                                      context: context,
                                      onTapCamera: () async {
                                        final file =
                                            await imageHelper.pickImage(
                                                source: ImageSource.camera);
                                        if (file != null) {
                                          final croppedFile =
                                              await imageHelper.crop(
                                                  cropStyle: CropStyle.rectangle,
                                                  aspectRatio:
                                                      const CropAspectRatio(
                                                          ratioX: 2.0,
                                                          ratioY: 4.0),
                                                  file: file);
                                          setState(() {
                                            horseImage =
                                                File(croppedFile!.path);
                                          });
                                        }
                                        if (mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      onTapGallery: () async {
                                        final file =
                                            await imageHelper.pickImage(
                                                source: ImageSource.gallery);
                                        if (file != null) {
                                          final croppedFile =
                                              await imageHelper.crop(
                                                  cropStyle: CropStyle.rectangle,
                                                  aspectRatio:
                                                      const CropAspectRatio(
                                                          ratioX: 2.0,
                                                          ratioY: 4.0),
                                                  // maxHeight: 100,
                                                  // maxWidth: 200,
                                                  file: file);
                                          setState(() {
                                            horseImage =
                                                File(croppedFile!.path);
                                          });
                                        }
                                        if (mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      title: "Chose the horse picture",
                                    );
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: AppColors.grey,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Add a photo",
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 18.0.h,
                            width: 48.0.w,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                  image: FileImage(horseImage!),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFDFD9C9),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableTypeContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 55, vertical: 10),
                            label: 'Mare',
                            index: 0,
                            isSelected: _isGenderSelected[0],
                            onSelected: (bool value) {
                              _handleSelected(0, value, _isGenderSelected);
                              selectedGender = 'Mare';
                              Print("Selected gender $selectedGender");
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectableTypeContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            label: 'Gelding',
                            index: 1,
                            isSelected: _isGenderSelected[1],
                            onSelected: (bool value) {
                              _handleSelected(1, value, _isGenderSelected);
                              selectedGender = 'Gelding';
                              Print("Selected type $selectedGender");
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectableTypeContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            label: 'Stallion',
                            index: 2,
                            isSelected: _isGenderSelected[2],
                            onSelected: (bool value) {
                              _handleSelected(2, value, _isGenderSelected);
                              selectedGender = 'Stallion';
                              Print("Selected type $selectedGender");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: RebiInput(
                        hintText: 'Horse Name'.tra,
                        controller: horseName,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        color: AppColors.formsLabel,
                        readOnly: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(horseName?.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: HorseColorsWidget(
                        color: horseColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: DisciplinesWidget(
                        discipline: discipline,
                        disciplineId: disciplineId,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: UserStableWidget(
                        stableId: stableId,
                        stableName: stable,
                        userId: widget.userId,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocConsumer<HorseCubit, HorseState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is UploadFileSuccessful) {
                        horseUrl = state.fileUrl!.url;
                        _onPressAddHorse(horseUrl!);
                      } else if (state is UploadFileError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      }
                      if (state is AddHorseSuccessfully) {
                        RebiMessage.success(
                            msg: "Horse added successfully", context: context);
                        myCubit.getAllHorses(limit: 1000);
                        Navigator.pop(context);
                      } else if (state is AddHorseError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is AddHorseLoading ||
                          state is UploadFileLoading) {
                        return const LoadingCircularWidget();
                      }
                      return RebiButton(
                        onPressed: () {
                          if (stable.text == 'Add New Stable') {
                            RebiMessage.error(
                                msg:
                                    "Please add your stable and wait until confirm it before",
                                context: context);
                          } else if (_formKey.currentState!.validate() &&
                              selectedGender != null &&
                              horseImage != null &&
                              // placeOfBirth.text != '' &&
                              selectedColor != null &&
                              disciplineId.text.isNotEmpty &&
                              stable.text.isNotEmpty) {
                            _onPressUpload();
                          } else if (horseImage == null) {
                            _onPressAddHorse('');
                          } else {
                            RebiMessage.error(
                                msg: "Some data are missing.",
                                context: context);
                          }
                        },
                        child: Text(
                          "Add",
                          style: AppStyles.buttonStyle,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSelected(int index, bool value, var _isSelected) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = value;
    });
  }

  _onPressAddHorse(String? horseImage) {
    cubit.addHorse(
      AddHorseRequestModel(
          color: selectedColor,
          name: horseName!.text,
          gender: selectedGender,
          disciplineId: int.parse(disciplineId.text),
          stableId: int.parse(stableId.text),
          image: horseImage),
    );
  }

  _onPressUpload() {
    cubit.uploadFile(horseImage!.path.toString());
  }
}
