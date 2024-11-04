import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors/app_colors.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class RebiInput extends StatefulWidget {
  const RebiInput({
    Key? key,
    this.radius = 10.0,
    this.background = AppColors.formsBackground,
    this.color = Colors.white,
    this.hintText,
    this.labelText,
    this.needToMessage = false,
    this.obscureText = false,
    this.capitalization = false,
    this.focusNodeParam,
    this.onSave,
    this.onFieldSubmitted,
    this.onChanged,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.initialValue,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 13.0, horizontal: 4.0),
    this.scrollPadding = const EdgeInsets.only(bottom: 40),
    this.borderSide =
        const BorderSide(color: AppColors.backgroundColor, width: 0.0),
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isOptional = false,
    this.isItDisable = false,
    this.autofocus = false,
    this.hintStyle,
  }) : super(key: key);

  final double radius;
  final Color? background;
  final Color color;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final bool capitalization;
  final FocusNode? focusNodeParam;
  final FormFieldSetter<String>? onSave;
  final FormFieldSetter<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? initialValue;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets scrollPadding;
  final BorderSide borderSide;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final bool isOptional;
  final bool needToMessage;
  final bool autofocus;
  final bool isItDisable;
  final TextStyle? hintStyle;

  @override
  State<RebiInput> createState() => _RebiInputState();
}

class _RebiInputState extends State<RebiInput> {
  late bool showPassword;
  final TextEditingController _controller = TextEditingController();
  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    showPassword = widget.obscureText;
    if (widget.initialValue != null && widget.initialValue != 'null') {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          scrollPadding: widget.scrollPadding,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          textCapitalization: widget.capitalization
              ? TextCapitalization.sentences
              : TextCapitalization.none,
          focusNode: widget.focusNodeParam ?? focusNode,
          autofocus: widget.autofocus,
          enableSuggestions: false,
          cursorColor: AppColors.blackLight,
          autocorrect: false,
          controller: widget.controller ?? _controller,
          textAlign: widget.textAlign,
          textAlignVertical: TextAlignVertical.center,
          keyboardAppearance:
              AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                  ? Brightness.dark
                  : Brightness.light,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscuringCharacter: '*',
          style: TextStyle(
            color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                ? AppColors.white
                : AppColors.blackLight,
            fontFamily: "notosan",
            // fontFamily: AppStyles.montserrat,
            decoration: TextDecoration.none,
          ),
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          onChanged: (value) {
            if (widget.onChanged == null) {
              return;
            }
            widget.onChanged!(value);
          },
          onFieldSubmitted: (value) {
            if (widget.onFieldSubmitted == null) {
              return;
            }
            widget.onFieldSubmitted!(value);
          },
          onTap: () {
            if (widget.onTap == null) {
              return;
            }
            widget.onTap!();
          },
          onSaved: (newValue) {
            if (widget.onSave == null) {
              return;
            }
            widget.onSave!(newValue);
          },
          validator: (value) {
            return widget.validator(value);
          },
          autovalidateMode: widget.autoValidateMode,
          obscureText: showPassword,
          decoration: InputDecoration(
            labelText: widget.labelText,

            errorStyle: widget.needToMessage
                ? TextStyle(
                    color: AppColors.red,
                    fontSize: 11,
                    height: 1.0,
                    fontFamily: 'notosan')
                : TextStyle(height: 0),
            errorMaxLines: 4,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.red, width: 1.0),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),

            isDense: true,
            iconColor: AppColors.white,
            prefixIconColor: AppColors.formsHintFont,
            suffixIconColor: AppColors.formsHintFont,
            contentPadding: widget.contentPadding,
            prefixIcon: widget.prefixIcon != null
                ? IconButton(
                    onPressed: null,
                    icon: widget.prefixIcon!,
                  )
                : null,

            suffixIcon: _buildSuffixWidget(),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.isItDisable ? AppColors.grey : AppColors.gold,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: const BorderSide(
                color: Color(0xFFDBD4C3),
                width: 0.50,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: const BorderSide(
                color: Color(0xFFDBD4C3),
                width: 0.50,
              ),
            ),
            fillColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                ? Colors.white
                : Colors.white,
            filled: true,
            alignLabelWithHint: true,
            // labelStyle: TextStyle(
            //   fontSize: 12.0,
            //   fontFamily: "notosan",
            //   fontWeight: FontWeight.w400,
            //   color: widget.color,
            // ),
            hintStyle: widget.hintStyle ??
                TextStyle(
                    fontFamily: "notosan",
                    fontSize: 14.0,
                    color:
                        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            ? AppColors.formsHintFont
                            : AppColors.formsHintFontLight),
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixWidget() {
    if (widget.suffixIcon != null) {
      return IconButton(onPressed: null, icon: widget.suffixIcon!);
    } else {
      return widget.obscureText
          ? IconButton(
              focusNode: FocusNode(skipTraversal: false),
              icon: showPassword
                  ? Icon(
                      CupertinoIcons.eye,
                      color:
                          AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                              ? AppColors.formsHintFont
                              : AppColors.formsHintFontLight,
                      size: 20.0,
                    )
                  : Icon(
                      CupertinoIcons.eye_slash,
                      color:
                          AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                              ? AppColors.formsHintFont
                              : AppColors.formsHintFontLight,
                      size: 20.0,
                    ),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            )
          : null;
    }
  }
}
