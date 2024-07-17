import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/global_functions/global_statics_drop_down.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/pick_image.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/features/horses/data/get_user_horses_response_model.dart';
import 'package:proequine/features/horses/data/update_horse_request_model.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/chose_picture_bottom_sheet.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/user_stables_widget.dart';
import '../../../equine_info/presentation/widgets/disciplines_widget.dart';
import '../../../user/presentation/widgets/selectable_type_container.dart';
import '../widgets/delete_horse_bottom_sheet.dart';
import '../widgets/horse_colors_widget.dart';

class EditHorseScreen extends StatefulWidget {
  final Horse horse;
  final int userId;

  const EditHorseScreen({
    super.key,
    required this.horse,
    required this.userId,
  });

  @override
  EditHorseScreenState createState() => EditHorseScreenState();
}

class EditHorseScreenState extends State<EditHorseScreen> {
  File? horseImage;
  late String image;
  final TextEditingController? horseName = TextEditingController();
  late DateTime dateTime;

  var now = DateTime.now();
  List<bool> isGenderSelected = [false, false, false];

  String formatDate(DateTime date) {
    // Define the date format
    final dateFormat = DateFormat("MMMM d, yyyy");
    // Format the date
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController placeOfBirth = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController stable;
  late TextEditingController bloodLine;
  late TextEditingController breed;
  late TextEditingController horseColor;
  late TextEditingController horseSire;
  late TextEditingController horseDam;
  late TextEditingController horseDamSire;
  late TextEditingController horseMicroCode;
  late TextEditingController horseUELNCode;
  late TextEditingController discipline;
  late TextEditingController disciplineId;

  TextEditingController stableName = TextEditingController();
  late TextEditingController stableId;
  TextEditingController stableLocation = TextEditingController();

  String? horseUrl;

  ImageHelper imageHelper = ImageHelper();

  @override
  void initState() {
    initializeDateFormatting();

    image = AppIcons.horse;
    horseName!.text = widget.horse.name!;
    placeOfBirth.text = widget.horse.placeOfBirth!;
    if (widget.horse.isVerified == true) {
      _dateOfBirth.text = formatDate(DateTime.parse(
          widget.horse.dateOfBirth ?? '2024-01-01T00:00:00.000'));
    } else {
      Print('Date is ${widget.horse.dateOfBirth}');
    }
    selectedGender = widget.horse.gender;
    horseColor = TextEditingController(text: widget.horse.color);
    bloodLine = TextEditingController(text: widget.horse.bloodLine);
    horseDam = TextEditingController(text: widget.horse.horseDam);
    horseSire = TextEditingController(text: widget.horse.horseSire);
    horseDamSire = TextEditingController(text: widget.horse.horseDamSire);
    horseMicroCode =
        TextEditingController(text: widget.horse.horseMicrochipCode);
    horseUELNCode = TextEditingController(text: widget.horse.uELNCode);
    stable = TextEditingController(text: widget.horse.stable?.name ?? '');
    discipline = TextEditingController(text: widget.horse.discipline!.title);
    stableId = TextEditingController(text: widget.horse.stableId.toString());
    disciplineId =
        TextEditingController(text: widget.horse.disciplineId.toString());

    selectedDiscipline = widget.horse.discipline!.title ?? '';
    breed = TextEditingController(text: widget.horse.breed);
    if (selectedGender == 'Mare') {
      isGenderSelected = [true, false, false];
    } else if (selectedGender == 'Gelding') {
      isGenderSelected = [false, true, false];
    } else if (selectedGender == 'Stallion') {
      isGenderSelected = [false, false, true];
    }

    super.initState();
  }

  HorseCubit cubit = HorseCubit();
  String? selectedGender;
  String? selectedColor;
  String? selectedDiscipline;
  String? selectedStable;

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<HorseCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Horse Details",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Remove',
          isThereThirdOptionDelete: true,
          onPressThirdOption: () {
            showDeleteHorseBottomSheet(
              context: context,
              title: 'Remove Horse ',
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "For verified horses a removal request must submitted ",
                      textAlign: TextAlign.center,
                      style: AppStyles.descriptions,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<HorseCubit, HorseState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is RemoveHorseError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      } else if (state is RemoveHorseSuccessfully) {
                        RebiMessage.success(
                            msg: state.message, context: context);
                        myCubit.getAllHorses(limit: 1000);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is RemoveHorseLoading) {
                        return const LoadingCircularWidget(
                          isDeleteButton: true,
                        );
                      }
                      return MaterialButton(
                        onPressed: () {
                          cubit.removeHorse(widget.horse.id!);
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  horseImage == null
                      ? SizedBox(
                          height: 20.h,
                          width: 55.0.w,
                          child: Stack(
                            children: [
                              widget.horse.image == ''
                                  ? Container(
                                      height: 18.h,
                                      width: 50.0.w,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8))),
                                      child: SvgPicture.asset(AppIcons.horse))
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            topLeft: Radius.circular(8)),
                                        child: CachedNetworkImage(
                                          width: 340,
                                          height: 18.h,
                                          imageUrl: widget.horse.image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              Positioned(
                                  top: 140.5,
                                  left: 45.5.w,
                                  child: GestureDetector(
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
                                                    cropStyle:
                                                        CropStyle.rectangle,
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
                                                    cropStyle:
                                                        CropStyle.rectangle,
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
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.yellow,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.edit,
                                          size: 13,
                                          color: AppColors.backgroundColorLight,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 20.h,
                          width: 55.0.w,
                          child: Stack(
                            children: [
                              Container(
                                height: 18.h,
                                width: 50.0.w,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: kPadding),
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
                              Positioned(
                                  top: 135.5,
                                  left: 45.5.w,
                                  child: GestureDetector(
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
                                                    cropStyle:
                                                        CropStyle.rectangle,
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
                                                    cropStyle:
                                                        CropStyle.rectangle,
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
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.yellow,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.edit,
                                          size: 13,
                                          color: AppColors.backgroundColorLight,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
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
                              horizontal: 50, vertical: 10),
                          label: 'Mare',
                          index: 0,
                          isSelected: isGenderSelected[0],
                          onSelected: (bool value) {
                            _handleSelected(0, value, isGenderSelected);
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
                          isSelected: isGenderSelected[1],
                          onSelected: (bool value) {
                            _handleSelected(1, value, isGenderSelected);
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
                          isSelected: isGenderSelected[2],
                          onSelected: (bool value) {
                            _handleSelected(2, value, isGenderSelected);
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
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
                      child: UserStableWidget(
                        stableId: stableId,
                        stableName: stable,
                        userId: widget.userId,
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
                      child: HorseColorsWidget(
                        color: horseColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Visibility(
                  visible: widget.horse.isVerified!,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Bloodline'.tra,
                          controller: bloodLine,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(bloodLine.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Studbook'.tra,
                          controller: breed,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(breed.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Place Of Birth'.tra,
                          controller: placeOfBirth,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(
                                placeOfBirth.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Date Of Birth'.tra,
                          controller: _dateOfBirth,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            // return Validator.requiredValidator(_dateOfBirth.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Horse Sire'.tra,
                          controller: horseSire,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(horseSire.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Horse Dam'.tra,
                          controller: horseDam,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(horseDam.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Horse DamSire'.tra,
                          controller: horseDamSire,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(
                                horseDamSire.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'Horse MicroShip Code'.tra,
                          controller: horseMicroCode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(
                                horseMicroCode.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: RebiInput(
                          hintText: 'UELN Code'.tra,
                          controller: horseUELNCode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: true,
                          color: AppColors.formsLabel,
                          isItDisable: true,
                          readOnly: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(
                                horseUELNCode.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocConsumer<HorseCubit, HorseState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is UploadFileSuccessful) {
                        horseUrl = state.fileUrl!.url;
                        _onPressUpdate(horseUrl!);
                      } else if (state is UploadFileError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      }
                      if (state is UpdateHorseSuccessfully) {
                        RebiMessage.success(
                            msg: state.message, context: context);
                        myCubit.getAllHorses(limit: 1000);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else if (state is UpdateHorseError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateHorseLoading ||
                          state is UploadFileLoading) {
                        return const LoadingCircularWidget();
                      }
                      return RebiButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (horseImage != null) {
                              _onPressUpload();
                            } else {
                              _onPressUpdate(image);
                            }
                          } else {}
                        },
                        child: Text(
                          "Save",
                          style: AppStyles.buttonStyle,
                        ),
                      );
                    },
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

  void _handleSelected(int index, bool value, var _isSelected) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = value;
    });
  }

  _onPressUpdate(String image) {
    cubit.updateHorse(
      UpdateHorseRequestModel(
        isVerified: widget.horse.isVerified,
        isDommy: widget.horse.isDommy,
        id: widget.horse.id!,
        name: horseName!.text,
        color: selectedColor,
        dateOfBirth: widget.horse.dateOfBirth,
        placeOfBirth: placeOfBirth.text,
        breed: breed.text,
        disciplineId: int.parse(disciplineId.text),
        stableId: int.parse(stableId.text),
        bloodLine: bloodLine.text,
        image: horseImage == null ? widget.horse.image! : image,
        gender: selectedGender,
      ),
    );
  }

  _onPressUpload() {
    cubit.uploadFile(horseImage!.path.toString());
  }
}
