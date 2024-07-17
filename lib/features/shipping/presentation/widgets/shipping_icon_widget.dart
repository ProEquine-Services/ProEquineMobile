import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';

class ShippingIconWidget extends StatelessWidget {
  final String type;
  const ShippingIconWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        type=='Import'?SvgPicture.asset(AppIcons.importLine):SvgPicture.asset(AppIcons.transportIconWidget),
        Center(
            child: type=='Import'? SvgPicture.asset(AppIcons.importIcon):SvgPicture.asset(AppIcons.shippingIcon))
      ],
    );
  }
}
