import 'package:proequine/core/CoreModels/base_result_model.dart';

import 'get_user_horses_response_model.dart';

class HorseDocumentsResponseModel extends BaseResultModel{
  int? id;
  int? horseId;
  Horse? horse;
  String? docNumber;
  String? docCategory;
  String? docType;
  String? docRegistrationData;
  String? docExpiryDate;
  String? docAttachment;
  String? docNotes;
  String? docTitle;

  HorseDocumentsResponseModel(
      {this.id,
        this.horseId,
        this.horse,
        this.docNumber,
        this.docCategory,
        this.docType,
        this.docRegistrationData,
        this.docExpiryDate,
        this.docAttachment,
        this.docNotes,
        this.docTitle});

  HorseDocumentsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    horseId = json['horseId'];
    horse = json['horse'] != null ? Horse.fromJson(json['horse']) : null;
    docNumber = json['docNumber'];
    docCategory = json['docCategory'];
    docType = json['docType'];
    docRegistrationData = json['docRegistrationData'];
    docExpiryDate = json['docExpiryDate'];
    docAttachment = json['docAttachment'];
    docNotes = json['docNotes'];
    docTitle = json['docTitle'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['horseId'] = horseId;
    if (horse != null) {
      data['horse'] = horse!.toJson();
    }
    data['docNumber'] = docNumber;
    data['docCategory'] = docCategory;
    data['docType'] = docType;
    data['docRegistrationData'] = docRegistrationData;
    data['docExpiryDate'] = docExpiryDate;
    data['docAttachment'] = docAttachment;
    data['docNotes'] = docNotes;
    data['docTitle'] = docTitle;
    return data;
  }
}