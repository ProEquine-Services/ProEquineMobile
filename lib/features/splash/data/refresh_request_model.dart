class RefreshRequestModel {
  String? refreshToken;


  RefreshRequestModel({
    this.refreshToken,
  });

  RefreshRequestModel.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    return data;
  }
}