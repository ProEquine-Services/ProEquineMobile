import 'package:proequine/core/CoreModels/base_result_model.dart';

class RegisterResponseModel extends BaseResultModel{
  int? id;
  String? email;
  String? phoneNumber;
  List<String>? roles;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  String? nationality;
  String? accessToken;
  String? refreshToken;
  Steps? steps;
  String? userName;
  bool? verifiedEmail;
  bool? verifiedPhoneNumber;
  bool? isBlocked;
  String? image;
  int? mainStableId;
  MainStable? mainStable;
  int? mainDisciplineId;
  MainDiscipline? mainDiscipline;
  String? displayName;

  RegisterResponseModel(
      {this.id,
        this.email,
        this.phoneNumber,
        this.roles,
        this.firstName,
        this.lastName,
        this.middleName,
        this.gender,
        this.nationality,
        this.accessToken,
        this.refreshToken,
        this.steps,
        this.userName,
        this.verifiedEmail,
        this.verifiedPhoneNumber,
        this.isBlocked,
        this.image,
        this.mainStableId,
        this.mainStable,
        this.mainDisciplineId,
        this.mainDiscipline,
        this.displayName});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    gender = json['gender'];
    nationality = json['nationality'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    steps = json['steps'] != null ? Steps.fromJson(json['steps']) : null;
    userName = json['userName'];
    verifiedEmail = json['verifiedEmail'];
    verifiedPhoneNumber = json['verifiedPhoneNumber'];
    isBlocked = json['isBlocked'];
    image = json['image'];
    mainStableId = json['mainStableId'];
    mainStable = json['mainStable'] != null
        ? MainStable.fromJson(json['mainStable'])
        : null;
    mainDisciplineId = json['mainDisciplineId'];
    mainDiscipline = json['mainDiscipline'] != null
        ? MainDiscipline.fromJson(json['mainDiscipline'])
        : null;
    displayName = json['displayName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['roles'] = roles;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    if (steps != null) {
      data['steps'] = steps!.toJson();
    }
    data['userName'] = userName;
    data['verifiedEmail'] = verifiedEmail;
    data['verifiedPhoneNumber'] =verifiedPhoneNumber;
    data['isBlocked'] = isBlocked;
    data['image'] = image;
    data['mainStableId'] = mainStableId;
    if (mainStable != null) {
      data['mainStable'] = mainStable!.toJson();
    }
    data['mainDisciplineId'] = mainDisciplineId;
    if (mainDiscipline != null) {
      data['mainDiscipline'] = mainDiscipline!.toJson();
    }
    data['displayName'] = displayName;
    return data;
  }
}

class Steps {
  bool? isAddMainDiscipline;
  bool? isAddMainStable;
  bool? isAddUserName;
  bool? isAddRole;
  bool? isVerifiedPhoneNumber;
  bool? isVerifiedEmail;

  Steps(
      {this.isAddMainDiscipline,
        this.isAddMainStable,
        this.isAddUserName,
        this.isAddRole,
        this.isVerifiedPhoneNumber,
        this.isVerifiedEmail});

  Steps.fromJson(Map<String, dynamic> json) {
    isAddMainDiscipline = json['isAddMainDiscipline'];
    isAddMainStable = json['isAddMainStable'];
    isAddUserName = json['isAddUserName'];
    isAddRole = json['isAddRole'];
    isVerifiedPhoneNumber = json['isVerifiedPhoneNumber'];
    isVerifiedEmail = json['isVerifiedEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAddMainDiscipline'] = isAddMainDiscipline;
    data['isAddMainStable'] = isAddMainStable;
    data['isAddUserName'] = isAddUserName;
    data['isAddRole'] = isAddRole;
    data['isVerifiedPhoneNumber'] = isVerifiedPhoneNumber;
    data['isVerifiedEmail'] = isVerifiedEmail;
    return data;
  }
}

class MainStable {
  int? id;
  String? name;
  String? country;
  String? pinLocation;
  String? status;
  bool? showOnApp;
  int? createdBy;

  MainStable(
      {this.id,
        this.name,
        this.country,
        this.pinLocation,
        this.status,
        this.showOnApp,
        this.createdBy});

  MainStable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    pinLocation = json['pinLocation'];
    status = json['status'];
    showOnApp = json['showOnApp'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country'] = country;
    data['pinLocation'] = pinLocation;
    data['status'] = status;
    data['showOnApp'] = showOnApp;
    data['createdBy'] =createdBy;
    return data;
  }
}

class MainDiscipline {
  int? id;
  String? title;
  String? code;

  MainDiscipline({this.id, this.title, this.code});

  MainDiscipline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    return data;
  }
}