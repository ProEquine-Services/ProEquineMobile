import 'dart:convert';
import 'package:flutter/widgets.dart';

class Base64Image extends StatelessWidget {
  final String base64Image;
  final double? height;
  final double? width;
  bool isItHorse=false;

  Base64Image({super.key, required this.base64Image, this.height,  this.width,this.isItHorse=false});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      height:height,
      width:width,
      base64Decode(base64Image),
      fit: isItHorse?BoxFit.cover:BoxFit.cover,
    );
  }
}