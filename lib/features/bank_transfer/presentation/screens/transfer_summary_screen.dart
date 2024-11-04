import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/custom_popup_widget.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../horses/presentation/widgets/upload_file_widget.dart';
import '../../data/create_bank_transfer_response_model.dart';
import '../../data/push_transfer_request_model.dart';
import '../../domain/bank_transfer_cubit.dart';
import '../widgets/proequine_bank_details_widget.dart';

class TransferSummaryScreen extends StatefulWidget {
  final CreateBankTransferResponseModel responseModel;

  const TransferSummaryScreen({super.key, required this.responseModel});

  @override
  State<TransferSummaryScreen> createState() => _TransferSummaryScreenState();
}

class _TransferSummaryScreenState extends State<TransferSummaryScreen> {
  bool ownerSaved = false;
  bool isOwnerLoading = false;
  String? ownerLink = '';
  String? transferProfPath = '';
  String? transferProf = '';
  BankTransferCubit cubit = BankTransferCubit();

  void showFilePickerOptions(BuildContext context) {
    showGlobalBottomSheet(
      context: context,
      title: "File type",
      content: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Pick Image from Gallery'),
            onTap: () {
              Navigator.of(context).pop();
              uploadFile('owner ship', 'Image');
            },
          ),

          ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: const Text('Pick Custom File'),
            onTap: () {
              Navigator.of(context).pop();
              uploadFile('owner ship', 'custom');
            },
          ),
        ],
      ),
    );
  }

  uploadFile(String title, String type) async {
    FilePickerResult? result;
    if (type == 'Image') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        // allowMultiple: true,
        // allowedExtensions: ['pdf', 'doc', 'jpeg', 'png', 'jpg'],
      );
    } else {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        // allowMultiple: true,
        allowedExtensions: ['pdf', 'doc', 'jpeg', 'png', 'jpg'],
      );
    }

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = file.path.split('/').last;
      String filePath = file.path;
      setState(() {
        transferProf = fileName;
        transferProfPath = filePath;
      });
    } else {
      // User canceled the picker
    }
  }

  String formatDate(DateTime date) {
    // Define the date format
    final dateFormat = DateFormat("MMMM d, yyyy - hh:mm a");
    // Format the date
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  String maskIban(String iban) {
    if (iban.length < 4) {
      throw ArgumentError("IBAN must be at least 4 characters long");
    }
    // Extract the last 4 digits
    String last4Digits = iban.substring(iban.length - 4);
    // Concatenate with asterisks
    return '*** $last4Digits';
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<BankTransferCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Transfer Summary".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: true,
          onPressBack: () {
            Navigator.pop(context);
            Navigator.pop(context);
            myCubit.getAllBankTransfers(limit: 1000);
          },
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: Text(
                      "Transaction Details",
                      style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFDFD9C9)),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "AED ${widget.responseModel.amount}",
                              style: const TextStyle(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                            ),
                          ),
                          const CustomDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Status",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.formsHintFontLight,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              Text(
                                widget.responseModel.status.toString(),
                                style: const TextStyle(
                                    color: Color(0xFF232F39),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'notosan'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "From",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.formsHintFontLight,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              Text(
                                maskIban(
                                    widget.responseModel.user!.account!.iBAN!),
                                style: const TextStyle(
                                    color: Color(0xFF232F39),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'notosan'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.formsHintFontLight,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              Text(
                                formatDate(DateTime.parse(
                                    widget.responseModel.createdAt!)),
                                style: const TextStyle(
                                  color: AppColors.blackLight,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                  fontFamily: 'Noto Sans',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reference Number",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: AppColors.formsHintFontLight,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Include it in your transfer notes",
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.responseModel.referenceNumber
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF232F39),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'notosan'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: widget
                                                .responseModel.referenceNumber
                                                .toString()));

                                        // copied successfully
                                        RebiMessage.success(
                                            msg: "copied successfully",
                                            context: context);
                                      },
                                      child:
                                          SvgPicture.asset(AppIcons.copyIcon)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: Text(
                      "ProEquine Bank Account",
                      style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const ProEquineBankDetailsWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<BankTransferCubit, BankTransferState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is UploadTransferProofSuccessfully) {
                        setState(() {
                          ownerSaved = true;
                        });
                        isOwnerLoading = false;

                        ownerLink = state.fileUrl!.url!;
                      } else if (state is UploadTransferProofError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      } else if (state is UploadTransferProofLoading) {
                        isOwnerLoading = true;
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: UploadFileWidget(
                          isLoading: isOwnerLoading,
                          buttonTitle: ownerSaved
                              ? 'Change'
                              : transferProf == ''
                                  ? 'Upload'
                                  : 'Save',
                          onPressUpload: () {
                            if (ownerSaved) {

                                showFilePickerOptions(context);

                            } else if (transferProf != '' &&
                                ownerSaved == false) {
                              _onPressUploadFile(transferProfPath!);
                            } else {
                              setState(() {
                                showFilePickerOptions(context);
                              });
                            }
                          },
                          onPressChange: () {
                            setState(() {
                              ownerSaved = false;
                              showFilePickerOptions(context);
                            });
                          },
                          title: transferProf != ''
                              ? transferProf
                              : 'No file uploaded',
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: RebiButton(
                        backgroundColor: AppColors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          myCubit.getAllBankTransfers(limit: 1000);
                        },
                        child: const Text("later")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: ownerSaved,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                        onPressed: () {
                          customPopupWidget(
                              context: context,
                              description:
                                  'Confirming this transaction requires approval',
                              logoutButton: BlocConsumer<BankTransferCubit,
                                  BankTransferState>(
                                bloc: cubit,
                                listener: (context, state) {
                                  if (state is PushTransferSuccessfully) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    myCubit.getAllBankTransfers(limit: 1000);
                                  } else if (state is PushTransferError) {
                                    RebiMessage.error(
                                        msg: state.message!, context: context);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is PushTransferLoading) {
                                    return const LoadingCircularWidget();
                                  } else {
                                    return RebiButton(
                                        height: 38,
                                        onPressed: () {
                                          _onPushTransfer(
                                              widget.responseModel.id!);
                                        },
                                        child: const Text(
                                          "Confirm",
                                          style: TextStyle(fontSize: 14),
                                        ));
                                  }
                                },
                              ),
                              title: 'Confirm Transaction');
                        },
                        child: Text(
                          "Transfer Completed",
                          style: AppStyles.buttonTitle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _onPushTransfer(int id) {
    cubit.pushTransfer(
        PushTransferRequestModel(id: id, transferProof: ownerLink));
  }

  _onPressUploadFile(String file) {
    cubit.uploadFile(file);
  }
}
