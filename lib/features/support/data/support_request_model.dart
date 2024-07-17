class CreateSupportRequestModel {

  String? subject;
  String? division;
  String? applicableReference;
  String? supportInquiry;
  bool? sourceIsApp;

  CreateSupportRequestModel(
      {
        this.subject,
        this.division,
        this.applicableReference,
        this.supportInquiry,
        this.sourceIsApp,});

  CreateSupportRequestModel.fromJson(Map<String, dynamic> json) {

    subject = json['subject'];
    division = json['division'];
    applicableReference = json['applicableReference'];
    supportInquiry = json['supportInquiry'];
    sourceIsApp = json['sourceIsApp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['division'] = division;
    data['applicableReference'] = applicableReference;
    data['supportInquiry'] = supportInquiry;
    data['sourceIsApp'] = sourceIsApp;
    return data;
  }
}