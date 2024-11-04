class UpdateMainStableRequestModel {
  int? stableId;
  String? stableName;
  bool? isNewStable;
  String? emirate;
  String? location;

  UpdateMainStableRequestModel(
      {this.stableId,
        this.stableName,
        this.isNewStable,
        this.emirate,
        this.location});

  UpdateMainStableRequestModel.fromJson(Map<String, dynamic> json) {
    stableId = json['stableId'];
    stableName = json['stableName'];
    isNewStable = json['isNewStable'];
    emirate = json['emirate'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stableId'] = stableId;
    data['stableName'] = stableName;
    data['isNewStable'] = isNewStable;
    data['emirate'] = emirate;
    data['location'] = location;
    return data;
  }
}