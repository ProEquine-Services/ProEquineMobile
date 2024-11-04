class UpdateSecondaryNumberRequestModel {
  String? secondNumber;


  UpdateSecondaryNumberRequestModel(
      {this.secondNumber});

  UpdateSecondaryNumberRequestModel.fromJson(Map<String, dynamic> json) {
    secondNumber = json['secondNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secondNumber'] = secondNumber;
    return data;
  }
}