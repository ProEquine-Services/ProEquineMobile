import 'package:easy_localization/easy_localization.dart';

import 'base_error.dart';

class ConnectionError extends BaseError {
  @override
  String message = 'ConnectionError'.tr();

  List<Object> get props => [];
}
