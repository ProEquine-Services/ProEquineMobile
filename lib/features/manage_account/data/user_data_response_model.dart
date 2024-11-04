
import '../../../core/CoreModels/base_result_model.dart';

class UserDataResponseModel extends BaseResultModel{
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

  UserDataResponseModel(
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
        this.salutation});

  UserDataResponseModel.fromJson(Map<String, dynamic> json) {
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
    json['account'] != null ? Account.fromJson(json['account']) : null;
    dateOfBirth = json['dateOfBirth'];
    zohoId = json['zohoId'];
    isRegisterdInZoho = json['isRegisterdInZoho'];
    salutation = json['salutation'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['roles'] = roles;
    data['userType'] = userType;
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
    data['verifiedPhoneNumber'] = verifiedPhoneNumber;
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
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['secondNumber'] = secondNumber;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    data['dateOfBirth'] = dateOfBirth;
    data['zohoId'] = zohoId;
    data['isRegisterdInZoho'] = isRegisterdInZoho;
    data['salutation'] = salutation;
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
  String? stableCode;
  String? stableType;
  String? emirate;
  String? pinLocation;
  String? stableAddress;
  String? stableCountry;
  bool? isManaged;
  bool? isVerified;
  bool? isDummy;
  bool? showOnApp;
  String? status;
  int? createdBy;

  MainStable(
      {this.id,
        this.name,
        this.stableCode,
        this.stableType,
        this.emirate,
        this.pinLocation,
        this.stableAddress,
        this.stableCountry,
        this.isManaged,
        this.isVerified,
        this.isDummy,
        this.showOnApp,
        this.status,
        this.createdBy});

  MainStable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stableCode = json['stableCode'];
    stableType = json['stableType'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
    stableAddress = json['stableAddress'];
    stableCountry = json['stableCountry'];
    isManaged = json['isManaged'];
    isVerified = json['isVerified'];
    isDummy = json['isDummy'];
    showOnApp = json['showOnApp'];
    status = json['status'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['stableCode'] = stableCode;
    data['stableType'] = stableType;
    data['emirate'] = emirate;
    data['pinLocation'] = pinLocation;
    data['stableAddress'] = stableAddress;
    data['stableCountry'] = stableCountry;
    data['isManaged'] = isManaged;
    data['isVerified'] = isVerified;
    data['isDummy'] = isDummy;
    data['showOnApp'] = showOnApp;
    data['status'] = status;
    data['createdBy'] = createdBy;
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
        this.accountNote});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalAmount'] = totalAmount;
    data['blockedAmount'] = blockedAmount;
    data['availableAmount'] = availableAmount;
    data['userId'] = userId;
    data['user'] = user;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['IBAN'] = iBAN;
    data['swiftCode'] = swiftCode;
    data['accountHolderName'] = accountHolderName;
    data['accountNote'] = accountNote;
    return data;
  }
}