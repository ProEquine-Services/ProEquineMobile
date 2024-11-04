
import '../../../core/CoreModels/base_result_model.dart';
import '../../bank_transfer/data/all_bank_transfers_response_model.dart';

class AddSecondaryInterestResponseModel extends BaseResultModel{
  int? id;
  int? userId;
  User? user;
  int? disciplineId;
  MainDiscipline? discipline;

  AddSecondaryInterestResponseModel(
      {this.id, this.userId, this.user, this.disciplineId, this.discipline});

  AddSecondaryInterestResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    disciplineId = json['disciplineId'];
    discipline = json['discipline'] != null
        ? new MainDiscipline.fromJson(json['discipline'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['disciplineId'] = this.disciplineId;
    if (this.discipline != null) {
      data['discipline'] = this.discipline!.toJson();
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
  Account? account;
  bool? isRegisterdInZoho;


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
        this.displayName,
        this.isRegisterdInZoho,
      this.account});

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
    isRegisterdInZoho = json['isRegisterdInZoho'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    steps = json['steps'] != null ? new Steps.fromJson(json['steps']) : null;
    userName = json['userName'];
    verifiedEmail = json['verifiedEmail'];
    verifiedPhoneNumber = json['verifiedPhoneNumber'];
    isBlocked = json['isBlocked'];
    image = json['image'];
    mainStableId = json['mainStableId'];
    mainStable = json['mainStable'] != null
        ? new MainStable.fromJson(json['mainStable'])
        : null;
    mainDisciplineId = json['mainDisciplineId'];
    mainDiscipline = json['mainDiscipline'] != null
        ? new MainDiscipline.fromJson(json['mainDiscipline'])
        : null;
    displayName = json['displayName'];
    account =
    json['account'] != null ?  Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['roles'] = this.roles;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    if (this.steps != null) {
      data['steps'] = this.steps!.toJson();
    }
    data['userName'] = this.userName;
    data['verifiedEmail'] = this.verifiedEmail;
    data['verifiedPhoneNumber'] = this.verifiedPhoneNumber;
    data['isBlocked'] = this.isBlocked;
    data['image'] = this.image;
    data['mainStableId'] = this.mainStableId;
    if (this.mainStable != null) {
      data['mainStable'] = this.mainStable!.toJson();
    }
    data['mainDisciplineId'] = this.mainDisciplineId;
    if (this.mainDiscipline != null) {
      data['mainDiscipline'] = this.mainDiscipline!.toJson();
    }
    data['displayName'] = this.displayName;
    data['isRegisterdInZoho'] = this.isRegisterdInZoho;
    if (account != null) {
      data['account'] = account!.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAddMainDiscipline'] = this.isAddMainDiscipline;
    data['isAddMainStable'] = this.isAddMainStable;
    data['isAddUserName'] = this.isAddUserName;
    data['isAddRole'] = this.isAddRole;
    data['isVerifiedPhoneNumber'] = this.isVerifiedPhoneNumber;
    data['isVerifiedEmail'] = this.isVerifiedEmail;
    return data;
  }
}

class MainStable {
  int? id;
  String? name;
  String? emirate;
  String? pinLocation;
  String? status;
  bool? showOnApp;
  int? createdBy;

  MainStable(
      {this.id,
        this.name,
        this.emirate,
        this.pinLocation,
        this.status,
        this.showOnApp,
        this.createdBy});

  MainStable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
    status = json['status'];
    showOnApp = json['showOnApp'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['emirate'] = this.emirate;
    data['pinLocation'] = this.pinLocation;
    data['status'] = this.status;
    data['showOnApp'] = this.showOnApp;
    data['createdBy'] = this.createdBy;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    return data;
  }
}