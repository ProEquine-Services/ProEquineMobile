import 'package:proequine_dev/core/CoreModels/base_result_model.dart';

import '../../associations/data/horse_associated_requests_response_model.dart';

class LoginResponseModel extends BaseResultModel{
  int? id;
  String? email;
  String? phoneNumber;
  List<String>? roles;
  List<String>? userType;
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
  String? address;
  String? country;
  String? state;
  String? city;
  String? secondNumber;
  Account? account;
  String? dateOfBirth;
  String? zohoId;
  bool? isRegisterdInZoho;
  String? salutation;
  bool? isLoggedInBefore;
  bool? isEmailGenerated;
  bool? isPhoneNumberGenerated;

  LoginResponseModel(
      {this.id,
        this.email,
        this.phoneNumber,
        this.roles,
        this.userType,
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
        this.address,
        this.country,
        this.state,
        this.city,
        this.secondNumber,
        this.account,
        this.dateOfBirth,
        this.zohoId,
        this.isRegisterdInZoho,
        this.salutation,
        this.isLoggedInBefore,
        this.isEmailGenerated,
        this.isPhoneNumberGenerated});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
    userType = json['userType'].cast<String>();
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
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    secondNumber = json['secondNumber'];
    account =
    json['account'] != null ?  Account.fromJson(json['account']) : null;
    dateOfBirth = json['dateOfBirth'];
    zohoId = json['zohoId'];
    isRegisterdInZoho = json['isRegisterdInZoho'];
    salutation = json['salutation'];
    isLoggedInBefore = json['isLoggedInBefore'];
    isEmailGenerated = json['isEmailGenerated'];
    isPhoneNumberGenerated = json['isPhoneNumberGenerated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['roles'] = this.roles;
    data['userType'] = this.userType;
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
    if (mainStable != null) {
      data['mainStable'] = mainStable!.toJson();
    }
    data['mainDisciplineId'] = this.mainDisciplineId;
    if (this.mainDiscipline != null) {
      data['mainDiscipline'] = this.mainDiscipline!.toJson();
    }
    data['displayName'] = this.displayName;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['secondNumber'] = this.secondNumber;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    data['dateOfBirth'] = this.dateOfBirth;
    data['zohoId'] = this.zohoId;
    data['isRegisterdInZoho'] = this.isRegisterdInZoho;
    data['salutation'] = this.salutation;
    data['isLoggedInBefore'] = this.isLoggedInBefore;
    data['isEmailGenerated'] = this.isEmailGenerated;
    data['isPhoneNumberGenerated'] = this.isPhoneNumberGenerated;
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
  bool? isLoggedInBefore;
  bool? isEmailGenerated;
  bool? isPhoneNumberGenerated;

  Steps(
      {this.isAddMainDiscipline,
        this.isAddMainStable,
        this.isAddUserName,
        this.isAddRole,
        this.isVerifiedPhoneNumber,
        this.isVerifiedEmail,
        this.isLoggedInBefore,
        this.isEmailGenerated,
        this.isPhoneNumberGenerated});

  Steps.fromJson(Map<String, dynamic> json) {
    isAddMainDiscipline = json['isAddMainDiscipline'];
    isAddMainStable = json['isAddMainStable'];
    isAddUserName = json['isAddUserName'];
    isAddRole = json['isAddRole'];
    isVerifiedPhoneNumber = json['isVerifiedPhoneNumber'];
    isVerifiedEmail = json['isVerifiedEmail'];
    isLoggedInBefore = json['isLoggedInBefore'];
    isEmailGenerated = json['isEmailGenerated'];
    isPhoneNumberGenerated = json['isPhoneNumberGenerated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAddMainDiscipline'] = this.isAddMainDiscipline;
    data['isAddMainStable'] = this.isAddMainStable;
    data['isAddUserName'] = this.isAddUserName;
    data['isAddRole'] = this.isAddRole;
    data['isVerifiedPhoneNumber'] = this.isVerifiedPhoneNumber;
    data['isVerifiedEmail'] = this.isVerifiedEmail;
    data['isLoggedInBefore'] = this.isLoggedInBefore;
    data['isEmailGenerated'] = this.isEmailGenerated;
    data['isPhoneNumberGenerated'] = this.isPhoneNumberGenerated;
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

class Account {
  int? id;
  int? totalAmount;
  int? blockedAmount;
  int? availableAmount;
  int? userId;
  String? user;
  String? bankName;
  String? accountNumber;
  String? iBAN;
  String? swiftCode;
  String? accountHolderName;
  String? accountNote;
  String? walletModifiedByName;

  Account(
      {this.id,
        this.totalAmount,
        this.blockedAmount,
        this.availableAmount,
        this.userId,
        this.user,
        this.bankName,
        this.accountNumber,
        this.iBAN,
        this.swiftCode,
        this.accountHolderName,
        this.accountNote,
        this.walletModifiedByName});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['totalAmount'];
    blockedAmount = json['blockedAmount'];
    availableAmount = json['availableAmount'];
    userId = json['userId'];
    user = json['user'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    iBAN = json['IBAN'];
    swiftCode = json['swiftCode'];
    accountHolderName = json['accountHolderName'];
    accountNote = json['accountNote'];
    walletModifiedByName = json['walletModifiedByName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalAmount'] = this.totalAmount;
    data['blockedAmount'] = this.blockedAmount;
    data['availableAmount'] = this.availableAmount;
    data['userId'] = this.userId;
    data['user'] = this.user;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['IBAN'] = this.iBAN;
    data['swiftCode'] = this.swiftCode;
    data['accountHolderName'] = this.accountHolderName;
    data['accountNote'] = this.accountNote;
    data['walletModifiedByName'] = this.walletModifiedByName;
    return data;
  }
}