import 'package:flutter/material.dart';
import 'package:proequine/features/shipping/data/create_shipping_request_model.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../screens/chose_location_screen.dart';

class ChoseLocationWidget extends StatefulWidget {
  final TextEditingController locationName;
  final TextEditingController lat;
  final TextEditingController lng;

  VoidCallback? changeTrue;
  VoidCallback? changeFalse;

  ChoseLocationWidget({
    super.key,
    required this.locationName,
    required this.lat,
    required this.lng,
    required this.changeFalse,
    required this.changeTrue,
  });

  @override
  State<ChoseLocationWidget> createState() => _ChoseLocationWidgetState();
}

class _ChoseLocationWidgetState extends State<ChoseLocationWidget> {
  ChooseLocation result = ChooseLocation();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding),
      child: RebiInput(
        hintText: "Choose Location",
        controller: widget.locationName,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {});
        },
        textInputAction: TextInputAction.done,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        isOptional: false,
        color: AppColors.formsLabel,
        onTap: () {
          widget.changeTrue!.call();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChoseLocationScreen())).then((value) {
            setState(() {
              result = value;
              widget.locationName.text = result.name!;
              widget.lat.text = result.lat.toString();
              widget.lng.text = result.lng.toString();
            });
          });
        },
        readOnly: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        obscureText: false,
        validator: (value) {
          return Validator.requiredValidator(widget.locationName.text);
        },
      ),
    );
  }
}
