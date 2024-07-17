import 'package:proequine/core/CoreModels/base_result_model.dart';

class CreateSupportResponseModel extends BaseResultModel{
  int? id;
  String? reference;
  int? userId;
  String? fullName;
  String? email;
  String? phone;
  String? subject;
  String? division;
  String? supportInquiry;
  String? applicableReference;
  String? supportStatus;
  String? supportResponse;
  String? userAssigned;
  String? supportInternalNote;

  CreateSupportResponseModel(
      {this.id,
        this.reference,
        this.userId,
        this.fullName,
        this.email,
        this.phone,
        this.subject,
        this.division,
        this.supportInquiry,
        this.applicableReference,
        this.supportStatus,
        this.supportResponse,
        this.userAssigned,
        this.supportInternalNote});

  CreateSupportResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    userId = json['userId'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    subject = json['subject'];
    division = json['division'];
    supportInquiry = json['supportInquiry'];
    applicableReference = json['applicableReference'];
    supportStatus = json['supportStatus'];
    supportResponse = json['supportResponse'];
    userAssigned = json['userAssigned'];
    supportInternalNote = json['supportInternalNote'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference'] = reference;
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['subject'] = subject;
    data['division'] = division;
    data['supportInquiry'] = supportInquiry;
    data['applicableReference'] = applicableReference;
    data['supportStatus'] = supportStatus;
    data['supportResponse'] = supportResponse;
    data['userAssigned'] = userAssigned;
    data['supportInternalNote'] = supportInternalNote;
    return data;
  }
}