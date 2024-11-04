class HorseVerificationRequestModel {
  int? id;
  String? horseNationalPassport;
  String? horseFEIPassport;
  String? docsRequestDate;

  HorseVerificationRequestModel(
      {this.id,
        this.horseNationalPassport,
        this.horseFEIPassport,
        this.docsRequestDate,

      });

  HorseVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    horseNationalPassport = json['horseNationalPassport'];
    horseFEIPassport = json['horseFEIPassport'];
    docsRequestDate = json['docsRequestDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['horseNationalPassport'] = horseNationalPassport;
    data['horseFEIPassport'] = horseFEIPassport;
    data['docsRequestDate'] = docsRequestDate;
    return data;
  }
}