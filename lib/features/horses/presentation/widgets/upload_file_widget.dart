import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../../../core/constants/colors/app_colors.dart';

class UploadFileWidget extends StatefulWidget {
  Function onPressUpload;
  Function? onPressChange;
  String? title;
  String? buttonTitle;
  bool isLoading = false;

  UploadFileWidget(
      {Key? key,
      required this.onPressUpload,
      this.title,
      this.buttonTitle,
      this.isLoading = false,
      this.onPressChange})
      : super(key: key);

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFFDFD9C9),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 39,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                  color: Color(0xFFDFD9C9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFDFD9C9),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  )),
              margin: EdgeInsets.zero,
              child: MaterialButton(
                color: const Color(0xFFDFD9C9),
                onPressed: () {
                  setState(() {
                    if (widget.buttonTitle == 'Change') {
                      widget.onPressChange!();
                    } else {
                      widget.onPressUpload();
                    }
                  });
                },
                child: widget.isLoading
                    ? Center(
                        child: JumpingDots(
                          color: Colors.black,
                          radius: 4,
                          numberOfDots: 3,
                          verticalOffset: -10,
                        ),
                      )
                    : Text(widget.buttonTitle!),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    widget.title!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.blackLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
