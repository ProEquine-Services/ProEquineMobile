import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class RebiButton extends StatefulWidget {
  const RebiButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.backgroundColor = AppColors.yellow,
    this.width,
    this.height = 47,
    this.elevation = 0,
    this.shadowColor = AppColors.gold,
    this.radius = 8.0,
    this.isBackButton = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget child;
  final Color backgroundColor;
  final double? width;
  final double height;
  final double? elevation;
  final Color shadowColor;
  final double radius;
  final bool isBackButton;

  @override
  State<RebiButton> createState() => _RebiButtonState();
}

class _RebiButtonState extends State<RebiButton> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isLoading,
      child: ElevatedButton(
        onPressed: () {
          if (widget.isLoading) {
            return;
          }
          widget.onPressed!();
        },
        style: widget.isBackButton
            ? ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColorLight,
                side: const BorderSide(
                  width: 2, // the thickness
                  color: AppColors.yellow,
                ),
                shadowColor: widget.shadowColor,
                elevation: widget.elevation,
                minimumSize: widget.width != null
                    ? Size(widget.width!, widget.height)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius),
                  ),
                ),
              )
            : ElevatedButton.styleFrom(
                // side: const BorderSide(
                //     width: 2, // the thickness
                //     color: Colors.black // the color of the border
                // ),
                backgroundColor: widget.backgroundColor,
                shadowColor: widget.shadowColor,
                elevation: widget.elevation,
                minimumSize: widget.width != null
                    ? Size(widget.width!, widget.height)
                    : null,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius),
                  ),
                ),
              ),
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          child: widget.isLoading
              ? Center(
                  child:
                      CircularProgressIndicator(color: widget.backgroundColor),
                )
              : widget.child,
        ),
      ),
    );
  }
}
