import 'package:easy_localization/easy_localization.dart';

import './http_error.dart';

class UnauthorizedError extends HttpError {
  String message = 'Unauthorized Error'.tr();
}
