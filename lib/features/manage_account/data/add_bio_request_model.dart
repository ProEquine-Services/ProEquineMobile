class AddBioRequestModel {
  String? bio;
  List<SocialMediaAccountDTOs>? socialMediaAccountDTOs;

  AddBioRequestModel({this.bio, this.socialMediaAccountDTOs});

  AddBioRequestModel.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    if (json['socialMediaAccountDTOs'] != null) {
      socialMediaAccountDTOs = <SocialMediaAccountDTOs>[];
      json['socialMediaAccountDTOs'].forEach((v) {
        socialMediaAccountDTOs!.add(SocialMediaAccountDTOs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = bio;
    if (socialMediaAccountDTOs != null) {
      data['socialMediaAccountDTOs'] =
          socialMediaAccountDTOs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialMediaAccountDTOs {
  String? socialMediaUserName;
  String? socialMediaAccountName;

  SocialMediaAccountDTOs(
      {this.socialMediaUserName, this.socialMediaAccountName});

  SocialMediaAccountDTOs.fromJson(Map<String, dynamic> json) {
    socialMediaUserName = json['socialMediaUserName'];
    socialMediaAccountName = json['socialMediaAccountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['socialMediaUserName'] = socialMediaUserName;
    data['socialMediaAccountName'] = socialMediaAccountName;
    return data;
  }
}