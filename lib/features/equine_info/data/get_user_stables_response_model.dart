import 'package:proequine/core/CoreModels/base_result_model.dart';

class GetUserStablesResponseModel extends BaseResultModel {
  int? count;
  List<UserStable>? rows;

  GetUserStablesResponseModel({this.count, this.rows});

  GetUserStablesResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <UserStable>[];
      json['rows'].forEach((v) {
        rows!.add(UserStable.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserStable {
  int? id;
  int? userId;
  User? user;
  int? stableId;
  Stable? stable;
  bool? isMainStable;

  UserStable({this.id, this.userId, this.user, this.stableId, this.stable,this.isMainStable});

  UserStable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    stableId = json['stableId'];
    stable = json['stable'] != null ? Stable.fromJson(json['stable']) : null;
    isMainStable = json['isMainStable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['stableId'] = stableId;
    if (stable != null) {
      data['stable'] = stable!.toJson();
    }
    data['isMainStable'] = isMainStable;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? phoneNumber;
  List<String>? roles;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  String? nationality;
  String? userName;
  bool? verifiedEmail;
  bool? verifiedPhoneNumber;
  bool? isBlocked;
  String? image;
  int? mainStableId;
  int? mainDisciplineId;
  String? displayName;

  User(
      {this.id,
      this.email,
      this.phoneNumber,
      this.roles,
      this.firstName,
      this.lastName,
      this.middleName,
      this.gender,
      this.nationality,
      this.userName,
      this.verifiedEmail,
      this.verifiedPhoneNumber,
      this.isBlocked,
      this.image,
      this.mainStableId,
      this.mainDisciplineId,
      this.displayName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    gender = json['gender'];
    nationality = json['nationality'];
    userName = json['userName'];
    verifiedEmail = json['verifiedEmail'];
    verifiedPhoneNumber = json['verifiedPhoneNumber'];
    isBlocked = json['isBlocked'];
    image = json['image'];
    mainStableId = json['mainStableId'];
    mainDisciplineId = json['mainDisciplineId'];
    displayName = json['displayName'];
  }

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
    data['userName'] = userName;
    data['verifiedEmail'] = verifiedEmail;
    data['verifiedPhoneNumber'] = verifiedPhoneNumber;
    data['isBlocked'] = isBlocked;
    data['image'] = image;
    data['mainStableId'] = mainStableId;
    data['mainDisciplineId'] = mainDisciplineId;
    data['displayName'] = displayName;
    return data;
  }
}

class Stable {
  int? id;
  String? name;
  String? emirate;
  String? pinLocation;
  String? status;
  bool? showOnApp;
  int? createdBy;

  Stable(
      {this.id,
      this.name,
      this.emirate,
      this.pinLocation,
      this.status,
      this.showOnApp,
      this.createdBy});

  Stable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
    status = json['status'];
    showOnApp = json['showOnApp'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emirate'] = emirate;
    data['pinLocation'] = pinLocation;
    data['status'] = status;
    data['showOnApp'] = showOnApp;
    data['createdBy'] = createdBy;
    return data;
  }
}
