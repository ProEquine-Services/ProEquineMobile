import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../features/manage_account/data/basic_account_management_route.dart';
import '../../features/manage_account/domain/manage_account_cubit.dart';
import '../constants/colors/app_colors.dart';
import '../constants/images/app_images.dart';
import '../constants/routes/routes.dart';
import '../utils/pick_image.dart';
import '../utils/rebi_message.dart';
import 'chose_picture_bottom_sheet.dart';
import 'loading_widget.dart';

class ProfileHeaderWidget extends StatefulWidget {
  String? userName;
  Function? onTapSave;
  String? pictureUrl;
  String? name;
  bool isFromEditing = false;
  bool isEditingPressed = false;

  ProfileHeaderWidget(
      {Key? key,
      this.onTapSave,
      this.userName,
      this.pictureUrl,
      this.name,
      this.isFromEditing = false,
      this.isEditingPressed = false})
      : super(key: key);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  ManageAccountCubit cubit = ManageAccountCubit();
  File? profilePic;
  String? profileUrl;

  ImageHelper imageHelper =ImageHelper();


  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: widget.isFromEditing
          ? Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    profilePic == null
                        ? widget.pictureUrl != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                    width: 62,
                                    height: 62,
                                    fit: BoxFit.cover,
                                    imageUrl: widget.pictureUrl!),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFD9C9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppIcons.subtract,
                                    // color: Color(0xFFDFD9C9),
                                  ),
                                ),
                              )
                        : Container(
                            width: 62,
                            height: 62,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: FileImage(profilePic!),
                                  fit: BoxFit.cover),
                            ),
                          ),
                    Positioned(
                      child: Transform.translate(
                          offset: const Offset(5, 5),
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
                                          cropStyle: CropStyle.circle,
                                          aspectRatio:
                                          const CropAspectRatio(
                                              ratioX: 2.0,
                                              ratioY: 4.0),
                                          file: file);
                                      setState(() {
                                        profilePic =
                                            File(croppedFile!.path);
                                      });
                                    }
                                    if (mounted) {
                                      widget.isEditingPressed=true;
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
                                          cropStyle: CropStyle.circle,
                                          aspectRatio:
                                          const CropAspectRatio(
                                              ratioX: 2.0,
                                              ratioY: 4.0),
                                          // maxHeight: 100,
                                          // maxWidth: 200,
                                          file: file);
                                      setState(() {
                                        profilePic =
                                            File(croppedFile!.path);
                                      });
                                    }
                                    if (mounted) {
                                      widget.isEditingPressed=true;
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  title: "Chose Your Profile Picture",
                                );
                              },
                              child: SvgPicture.asset(AppIcons.takePic))),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      '${widget.name}',
                      style: const TextStyle(
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.userName}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: AppColors.formsHintFontLight,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: 25.0.w,
                        ),
                        Visibility(
                            visible: widget.isEditingPressed,
                            child: BlocConsumer<ManageAccountCubit,
                                ManageAccountState>(
                              bloc: cubit,
                              listener: (context, state) {
                                if (state is UploadFileSuccessful) {
                                  profileUrl = state.fileUrl!.url;
                                  _onPressUploadProfilePic(profileUrl);
                                } else if (state is UploadFileError) {
                                  RebiMessage.error(
                                      msg: state.message!, context: context);
                                }
                                if (state is UpdateImageError) {
                                  RebiMessage.error(
                                      msg: state.message!, context: context);
                                } else if (state is UpdateImageSuccessful) {
                                  Navigator.pushReplacementNamed(
                                      context, successScreen,
                                      arguments: BasicAccountManagementRoute(
                                          type: 'profileImage',
                                          title:
                                              "Profile picture has been added successfully"));
                                }
                              },
                              builder: (context, state) {
                                if (state is UpdateImageLoading ||
                                    state is UploadFileLoading) {
                                  return LoadingCircularWidget();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      _onPressUpload();
                                    },
                                    child: Container(
                                      width: 87,
                                      height: 20,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFE0AD25),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      child: const Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'notosan'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            )),
                      ],
                    ),
                  ],
                )
              ],
            )
          : Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFDFD9C9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.subtract,
                      // color: Color(0xFFDFD9C9),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "Hi ${widget.name}",
                      style: const TextStyle(
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Text(
                      "${widget.userName}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: AppColors.formsHintFontLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  _onPressUploadProfilePic(url) {
    cubit.updateProfileImage(url);
  }

  _onPressUpload() {
    cubit.uploadFile(profilePic!.path.toString());
  }
}
