import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final Widget content;
  const PaymentCard({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFFBFBFB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2.35,
            offset: Offset(0, 1.18),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2.35,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: content
    );
  }
}
