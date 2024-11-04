import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/bank_transfer/presentation/screens/transfer_summary_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../horses/presentation/widgets/upload_file_widget.dart';
import '../../data/all_bank_transfers_response_model.dart';
import '../../data/create_bank_transfer_request_model.dart';
import '../../data/push_transfer_request_model.dart';
import '../../domain/bank_transfer_cubit.dart';
import '../widgets/proequine_bank_details_widget.dart';
import 'edit_bank_details_screen.dart';

class BankDepositScreen extends StatefulWidget {
  final Account? account;
  final int userId;

  const BankDepositScreen({super.key, required this.userId, this.account});

  @override
  State<BankDepositScreen> createState() => _BankDepositScreenState();
}

class _BankDepositScreenState extends State<BankDepositScreen> {
  bool ownerSaved = false;
  bool isOwnerLoading = false;
  String? ownerLink = '';
  String? transferProfPath = '';
  String? transferProf = '';

  BankTransferCubit cubit = BankTransferCubit();
  bool unActive = false;
  TextEditingController controller = TextEditingController(text: '');

  void _addValueToInput(int value) {
    if (controller.text.isNotEmpty) {
      try {
        int inputValue = int.parse(controller.text);
        int newValue = inputValue + value;
        setState(() {
          controller.text = newValue.toString();
        });
      } catch (e) {
        // Handle parsing error
      }
    } else if (controller.text.isEmpty) {
      setState(() {
        controller.text = value.toString();
      });
    }
  }

  String get lessThanInputText {
    if (controller.text.isNotEmpty) {
      try {
        int inputValue = int.parse(controller.text);
        double lessValue =
            inputValue * (1 - 0.039) - 1; // 2.9% less than the input plus 1 AED
        return '≈ ${lessValue.toStringAsFixed(2)}';
      } catch (e) {
        return 'Invalid Input'.tra;
      }
    } else {
      return '';
    }
  }

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

  String? selectedType;

  List<DropdownMenuItem<String>> transferType = [
    const DropdownMenuItem(
      value: "My bank account",
      child: Text("My bank account"),
    ),
    const DropdownMenuItem(
      value: "Cash Deposit",
      child: Text("Cash Deposit"),
    ),
    const DropdownMenuItem(
      value: "Other bank account",
      child: Text("Other bank account"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<BankTransferCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Bank Deposit".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionIcon: InkWell(
            onTap: () {
              showGlobalBottomSheet(
                  context: context,
                  title: "Transaction Process",
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPadding, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              color: AppColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AppIcons.createTransferIcon),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "create a new transfer",
                                      style: TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    width: 5,
                                    thickness: 10,
                                    color: AppColors.grey,
                                    indent: 2,
                                    endIndent: 4,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.transferToPEIcon),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Transfer to ProEuqine bank account",
                                      style: TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    width: 5,
                                    thickness: 10,
                                    color: AppColors.grey,
                                    indent: 2,
                                    endIndent: 4,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AppIcons.confirmTransferIcon),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Confirm that transfer has completed",
                                      style: TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    width: 5,
                                    thickness: 10,
                                    color: AppColors.grey,
                                    indent: 2,
                                    endIndent: 4,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AppIcons.transferApproveIcon),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "ProEquine team will Approve transfer",
                                      style: TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: VerticalDivider(
                                    width: 5,
                                    thickness: 10,
                                    color: AppColors.grey,
                                    indent: 2,
                                    endIndent: 4,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        AppIcons.finalTransferIcon),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Amount will be credited to your wallet",
                                      style: TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: VerticalDivider(
                                    width: 5,
                                    thickness: 10,
                                    color: AppColors.grey,
                                    indent: 2,
                                    endIndent: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const ProEquineBankDetailsWidget(),
                    ],
                  ));
            },
            child: SvgPicture.asset(
              AppIcons.questionMark,
            ),
          ),
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
                  Container(
                    height: 175,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFDFD9C9)),
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Amount to deposit',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 10,
                            fontFamily: 'notosan',
                            fontWeight: FontWeight.w600,
                            height: 0.22,
                            letterSpacing: 0.18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: AppColors.gold,
                          style: const TextStyle(
                            color: Color(0xFFC48636),
                            fontSize: 34.06,
                            fontFamily: 'notosans',
                            fontWeight: FontWeight.w700,
                          ),
                          controller: controller,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            // contentPadding: EdgeInsets.only(left: 40.w),
                            hintText: '0.0 AED',
                            hintStyle: TextStyle(
                              fontSize: 34.06,
                              fontFamily: 'notosans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => _addValueToInput(250),
                              child: Container(
                                width: 95,
                                height: 41,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEBEEF4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    "+ 250",
                                    style: TextStyle(
                                        color: AppColors.blackLight,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _addValueToInput(500),
                              child: Container(
                                width: 95,
                                height: 41,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEBEEF4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    "+ 500",
                                    style: TextStyle(
                                        color: AppColors.blackLight,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _addValueToInput(1000),
                              child: Container(
                                width: 95,
                                height: 41,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEBEEF4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    "+ 1000",
                                    style: TextStyle(
                                        color: AppColors.blackLight,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: Text(
                      "Transfer type",
                      style: TextStyle(
                        color: AppColors.formsHintFontLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7, horizontal: kPadding),
                    child: DropDownWidget(
                      items: transferType,
                      selected: selectedType,
                      onChanged: (type) {
                        setState(() {
                          selectedType = type;
                        });
                      },
                      validator: (value) {
                        return Validator.requiredValidator(selectedType);
                      },
                      hint: 'Transfer Type',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: selectedType == 'Other bank account' ||
                            selectedType == 'Cash Deposit'
                        ? true
                        : false,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPadding),
                      child: Text(
                        'Transfer Proof',
                        style: TextStyle(
                          color: AppColors.formsHintFontLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: selectedType == 'Other bank account' ||
                            selectedType == 'Cash Deposit'
                        ? true
                        : false,
                    child: BlocConsumer<BankTransferCubit, BankTransferState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is UploadTransferProofSuccessfully) {
                          isOwnerLoading = false;
                          ownerSaved = true;
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
                                setState(() {
                                  showFilePickerOptions(context);
                                });
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Spacer(),
                  BlocConsumer<BankTransferCubit, BankTransferState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is CreateBankPayError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                        if (state.message ==
                            'please add your bank account first') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditBankDetailsScreen()));
                        }
                      } else if (state is CreateBankPaySuccessfully) {
                        if (selectedType == 'Other bank account' ||
                            selectedType == 'Cash Deposit') {
                          _onPushTransfer(state.responseModel.id!);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransferSummaryScreen(
                                        responseModel: state.responseModel,
                                      )));
                        }
                      } else if (state is PushTransferSuccessfully) {
                        myCubit.getAllBankTransfers(limit: 1000);
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is PushTransferLoading ||
                          state is CreateBankPayLoading) {
                        return const LoadingCircularWidget();
                      } else {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: RebiButton(
                                onPressed: () {
                                  if (controller.text.isEmpty) {
                                    RebiMessage.error(
                                        msg: "Enter a valid amount.",
                                        context: context);
                                  }
                                  int totalAmount = int.parse(controller.text);
                                  _onPressMakeTransfer(totalAmount);
                                },
                                child: Text("Next".tra)));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _onPressUploadFile(String file) {
    cubit.uploadFile(file);
  }

  _onPressMakeTransfer(int amount) {
    cubit.createBankTransfer(CreateBankTransferRequestModel(
        userId: widget.userId,
        amount: amount,
        transferType: selectedType,
        transferProof: ownerLink));
  }

  _onPushTransfer(int id) {
    cubit.pushTransfer(
        PushTransferRequestModel(id: id, transferProof: ownerLink));
  }
}
