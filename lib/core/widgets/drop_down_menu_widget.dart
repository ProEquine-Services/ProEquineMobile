import 'package:flutter/material.dart';
import 'package:proequine/core/widgets/profile_divider.dart';
import '../constants/colors/app_colors.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class DropDownWidget extends StatefulWidget {
  late List<DropdownMenuItem>? items;
  late String? selected;
  final String? hint;
  final FormFieldValidator<String> validator;
  final BorderSide borderSide;
  final FormFieldSetter<String>? onChanged;

  DropDownWidget({
    super.key,
    this.selected,
    this.items,
    required this.validator,
    this.onChanged,
    this.hint,
    this.borderSide = const BorderSide(color: Color(0xFFDBD4C3), width: 0.5),
  });

  @override
  DropDownWidgetState createState() => DropDownWidgetState();
}

class DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InputDecorator(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color(0xFFDBD4C3), width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: widget.borderSide,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: widget.borderSide,
          ),
          errorStyle: const TextStyle(color: AppColors.red),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red, width: 1.0),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            underline: const ProfileDivider(),
            dropdownColor:
                AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                    ? AppColors.formsBackground
                    : AppColors.formsBackgroundLight,
            elevation: 1,
            borderRadius: BorderRadius.circular(10),
            style: TextStyle(
              fontSize: 14,
              color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                  ? AppColors.formsLabel
                  : AppColors.backgroundColor,
              fontFamily: "notosan",
              decoration: TextDecoration.none,
            ),
            hint: Text(
              widget.hint!,
              style: TextStyle(
                  fontFamily: "notosan",
                  fontSize: 14.0,
                  color:
                      AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                          ? AppColors.formsHintFont
                          : AppColors.formsHintFontLight),
            ),
            items: widget.items?.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem(
                value: value.value,
                child: Text(value.value!),
                // // SizedBox(height: 10,),
                // ProfileDivider(),
              );
            }).toList(),
            isExpanded: true,
            isDense: true,

            // onChanged: (String? newSelectedItem) {
            //   setState(() {
            //     widget.selected = newSelectedItem;
            //     Print("selected $newSelectedItem");
            //     Print("selected ${widget.selected}");
            //   });
            // },
            onChanged: widget.onChanged,
            value: widget.selected,
          ),
        ),
      ),
    );
  }
}
