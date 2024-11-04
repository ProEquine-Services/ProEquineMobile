// import 'package:fyt/core/CoreModels/base_result_model.dart';
//
// class VersionResponseModel extends BaseResultModel {
//   String? iosVersion;
//   String? iosBuildNumber;
//   String? androidVersion;
//   String? androidBuildNumber;
//   bool? updateIsImportant;
//
//   VersionResponseModel(
//       {this.iosVersion,
//         this.iosBuildNumber,
//         this.androidVersion,
//         this.androidBuildNumber,
//         this.updateIsImportant});
//
//   VersionResponseModel.fromJson(Map<String, dynamic> json) {
//     iosVersion = json['iosVersion'];
//     iosBuildNumber = json['iosBuildNumber'];
//     androidVersion = json['androidVersion'];
//     androidBuildNumber = json['androidBuildNumber'];
//     updateIsImportant = json['updateIsImportant'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['iosVersion'] = this.iosVersion;
//     data['iosBuildNumber'] = this.iosBuildNumber;
//     data['androidVersion'] = this.androidVersion;
//     data['androidBuildNumber'] = this.androidBuildNumber;
//     data['updateIsImportant'] = this.updateIsImportant;
//     return data;
//   }
// }