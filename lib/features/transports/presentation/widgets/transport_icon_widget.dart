import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine_dev/core/constants/images/app_images.dart';

class TransportIconWidget extends StatelessWidget {
  const TransportIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(AppIcons.transportIconWidget),
        Center(
            child: SvgPicture.asset(AppIcons.transportCar))
      ],
    );
  }
}
