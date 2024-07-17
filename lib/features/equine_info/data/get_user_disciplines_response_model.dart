import 'package:proequine/core/CoreModels/base_result_model.dart';

class GetUserInterestsResponseModel extends BaseResultModel {
  int? count;
  List<UserInterests>? rows;

  GetUserInterestsResponseModel({this.count, this.rows});

  GetUserInterestsResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <UserInterests>[];
      json['rows'].forEach((v) {
        rows!.add(UserInterests.fromJson(v));
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

class UserInterests {
  int? id;
  int? userId;
  User? user;
  int? disciplineId;
  Discipline? discipline;

  UserInterests({this.id, this.userId, this.user, this.disciplineId, this.discipline});

  UserInterests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    disciplineId = json['disciplineId'];
    discipline = json['discipline'] != null
        ? Discipline.fromJson(json['discipline'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['disciplineId'] = disciplineId;
    if (discipline != null) {
      data['discipline'] = discipline!.toJson();
    }
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
    data['phoneNumber']=phoneNumber;
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

class Discipline {
  int? id;
  String? title;
  String? code;

  Discipline({this.id, this.title, this.code});

  Discipline.fromJson(Map<String, dynamic> json) {
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