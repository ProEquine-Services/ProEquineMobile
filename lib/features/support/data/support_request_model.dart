class CreateSupportRequestModel {

  String? subject;
  String? division;
  String? applicableReference;
  String? phone;
  String? supportInquiry;
  bool? sourceIsApp;
  bool? sourceIsWebsite;
  bool? sourceIsCustomer;

  CreateSupportRequestModel(
      {
        this.subject,
        this.division,
        this.applicableReference,
        this.phone,
        this.supportInquiry,
        this.sourceIsWebsite,
        this.sourceIsCustomer,
        this.sourceIsApp,});

  CreateSupportRequestModel.fromJson(Map<String, dynamic> json) {

    subject = json['subject'];
    division = json['division'];
    applicableReference = json['applicableReference'];
    phone = json['phone'];
    supportInquiry = json['supportInquiry'];
    sourceIsApp = json['sourceIsApp'];
    sourceIsWebsite = json['sourceIsWebsite'];
    sourceIsCustomer = json['sourceIsCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['division'] = division;
    data['applicableReference'] = applicableReference;
    data['phone'] = phone;
    data['supportInquiry'] = supportInquiry;
    data['sourceIsApp'] = sourceIsApp;
    data['sourceIsWebsite'] = sourceIsWebsite;
    data['sourceIsCustomer'] = sourceIsCustomer;
    return data;
  }
}