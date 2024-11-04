import 'package:easy_localization/easy_localization.dart';

import 'http_error.dart';

class InternalServerError extends HttpError {
  String message = 'InternalServerError'.tr();
}
