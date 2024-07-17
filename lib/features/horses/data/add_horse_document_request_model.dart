class CreateHorseDocumentsRequestModel {
  int? horseId;
  String? docNumber;
  String? docTitle;
  String? docCategory;
  String? docType;
  String? docRegistrationData;
  String? docExpiryDate;
  String? docAttachment;
  String? docNotes;

  CreateHorseDocumentsRequestModel(
      {
        this.horseId,
        this.docNumber,
        this.docTitle,
        this.docCategory,
        this.docType,
        this.docRegistrationData,
        this.docExpiryDate,
        this.docAttachment,
        this.docNotes});

  CreateHorseDocumentsRequestModel.fromJson(Map<String, dynamic> json) {
    horseId = json['horseId'];
    docNumber = json['docNumber'];
    docTitle = json['docTitle'];
    docCategory = json['docCategory'];
    docType = json['docType'];
    docRegistrationData = json['docRegistrationData'];
    docExpiryDate = json['docExpiryDate'];
    docAttachment = json['docAttachment'];
    docNotes = json['docNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseId'] = horseId;
    data['docNumber'] = docNumber;
    data['docTitle'] = docTitle;
    data['docCategory'] = docCategory;
    data['docType'] = docType;
    data['docRegistrationData'] = docRegistrationData;
    data['docExpiryDate'] = docExpiryDate;
    data['docAttachment'] = docAttachment;
    data['docNotes'] = docNotes;
    return data;
  }
}