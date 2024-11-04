import 'package:easy_localization/easy_localization.dart';

import 'connection_error.dart';

class TimeoutError extends ConnectionError {
  String message = 'TimeoutError'.tr();
}
