import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine_dev/core/utils/extensions.dart';

import '../../../core/utils/rebi_message.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());

  DateTime? currentBackPressTime;

  Future<bool> onWillPop(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      RebiMessage.warning(msg: "Tap again to quit the app.".tra,context: context);
      return Future.value(false);
    }
    return exit(0);
  }

}
