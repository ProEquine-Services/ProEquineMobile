
import '../../../core/CoreModels/base_result_model.dart';

class ConfigurationResponseModel extends BaseResultModel{
  String? androidVersion;
  String? iosVersion;
  String? androidBuildNumber;
  String? iosBuildNumber;
  bool? updateIsImportant;
  String? privacyPolicyUrl;
  String? privacyPolicyText;
  String? terms;

  ConfigurationResponseModel(
      {this.androidVersion,
        this.iosVersion,
        this.androidBuildNumber,
        this.iosBuildNumber,
        this.updateIsImportant,
        this.privacyPolicyUrl,
        this.privacyPolicyText,
        this.terms});

  ConfigurationResponseModel.fromJson(Map<String, dynamic> json) {
    androidVersion = json['androidVersion'];
    iosVersion = json['iosVersion'];
    androidBuildNumber = json['androidBuildNumber'];
    iosBuildNumber = json['iosBuildNumber'];
    updateIsImportant = json['updateIsImportant'];
    privacyPolicyUrl = json['privacyPolicyUrl'];
    privacyPolicyText = json['privacyPolicyText'];
    terms = json['terms'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['androidVersion'] = androidVersion;
    data['iosVersion'] = iosVersion;
    data['androidBuildNumber'] = androidBuildNumber;
    data['iosBuildNumber'] = iosBuildNumber;
    data['updateIsImportant'] = updateIsImportant;
    data['privacyPolicyUrl'] = privacyPolicyUrl;
    data['privacyPolicyText'] = privacyPolicyText;
    data['terms'] = terms;
    return data;
  }
}