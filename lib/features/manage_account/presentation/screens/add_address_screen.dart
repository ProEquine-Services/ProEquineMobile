import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_country_state/flutter_country_state.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../data/add_address_request_model.dart';
import '../../data/basic_account_management_route.dart';
import '../../domain/manage_account_cubit.dart';

class AddAddressScreen extends StatefulWidget {
  final String? country;
  final String? address;
  final String? city;
  final String? countryState;

  const AddAddressScreen(
      {super.key, this.country, this.address, this.city, this.countryState});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late final TextEditingController city;
  late final TextEditingController address;
  late final TextEditingController country;
  late final TextEditingController countryState;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedState = '';
  String? selectedCity;
  ManageAccountCubit cubit = ManageAccountCubit();

  @override
  void initState() {
    initializeDateFormatting();
    if (widget.country != null) {
      city = TextEditingController(text: widget.city);
      address = TextEditingController(text: widget.address);
      country = TextEditingController(text: widget.country);
      countryState = TextEditingController(text: widget.countryState);
    } else {
      city = TextEditingController();
      address = TextEditingController();
      country = TextEditingController();
      countryState = TextEditingController();
    }

    super.initState();
  }

  @override
  void dispose() {
    address.dispose();
    city.dispose();
    country.dispose();
    countryState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Address",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: false,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: RebiInput(
                                hintText: 'Country'.tra,
                                controller: country,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      countryListTheme: CountryListThemeData(
                                        flagSize: 25,
                                        backgroundColor:
                                            AppColors.backgroundColorLight,
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.blackLight),
                                        bottomSheetHeight: 85.0.h,
                                        // Optional. Country list modal height
                                        //Optional. Sets the border radius for the bottomsheet.
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        //Optional. Styles the search field.
                                        inputDecoration: const InputDecoration(
                                          hintText: 'Search by name or code',
                                          hintStyle: TextStyle(
                                            color: AppColors.formsHintFontLight,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: AppColors.formsHintFontLight,
                                          ),
                                          filled: true,
                                          fillColor: AppColors.whiteLight,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBD4C3),
                                              width: 0.50,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBD4C3),
                                              width: 0.50,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country selectedCountry) {
                                        setState(() {
                                          country.text = selectedCountry.name;
                                          countryState.text = '';

                                          city.text = '';
                                        });
                                      });
                                },
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {},
                              ),
                            ),
                            Visibility(
                              visible: country.text == '' ? false : true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: country.text == 'United Arab Emirates'
                                    ? RebiInput(
                                        hintText: 'State'.tra,
                                        controller: countryState,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        onTap: () {
                                          Variables.country =
                                              'United Arab Emirates';
                                          showGlobalBottomSheet(
                                              context: context,
                                              title: "State",
                                              content: Column(
                                                children: [
                                                  ListView.separated(
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return const CustomDivider();
                                                      },
                                                      itemCount:
                                                          emiratesStates.length,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              countryState
                                                                      .text =
                                                                  emiratesStates[
                                                                      index];
                                                              city.text = '';
                                                              Print(
                                                                  "choosed state ${countryState.text}");
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                                emiratesStates[
                                                                    index]),
                                                          ),
                                                        );
                                                      })
                                                ],
                                              ));
                                        },
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        readOnly: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {},
                                      )
                                    : RebiInput(
                                        hintText: 'State'.tra,
                                        controller: countryState,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        isOptional: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        color: AppColors.formsLabel,
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              countryState.text);
                                        },
                                      ),
                              ),
                            ),
                            Visibility(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'City'.tra,
                                  controller: city,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        city.text);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: RebiInput(
                                hintText: 'Address'.tra,
                                controller: address,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: false,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      address.text);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(kPadding),
                        child: BlocConsumer<ManageAccountCubit,
                            ManageAccountState>(
                          bloc: cubit,
                          listener: (context, state) {
                            if (state is AddAddressSuccessfully) {
                              Navigator.pushReplacementNamed(
                                  context, successScreen,
                                  arguments: BasicAccountManagementRoute(
                                      type: 'manageAccount',
                                      title: widget.country == null
                                          ? "Address added successfully"
                                          : "Address updated successfully"));
                            } else if (state is AddAddressError) {
                              RebiMessage.error(
                                  msg: state.message!, context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is AddAddressLoading) {
                              return const LoadingCircularWidget();
                            }
                            return RebiButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    country.text.isNotEmpty &&
                                    (selectedCity != null ||
                                        city.text.isNotEmpty) &&
                                    (selectedState != null ||
                                        countryState.text.isNotEmpty)) {
                                  onPressAdd();
                                } else {
                                  RebiMessage.error(
                                      msg: "Some data are missing.",
                                      context: context);
                                }
                              },
                              child: Text(
                                widget.country == null ? "Add" : "Update",
                                style: AppStyles.buttonStyle,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  onPressAdd() {
    return cubit
      ..addAddress(AddAddressRequestModel(
        country: country.text,
        city: city.text,
        state: countryState.text,
        address: address.text,
      ));
  }
}
