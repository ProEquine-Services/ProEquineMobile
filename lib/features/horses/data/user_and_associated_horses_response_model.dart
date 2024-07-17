import 'dart:convert';

import 'package:proequine/core/CoreModels/base_result_model.dart';

class UserAndAssociatedHorsesResponseModel extends BaseResultModel {
  int? count;
  List<UserAndAssociatedHorses>? rows;

  UserAndAssociatedHorsesResponseModel({
    this.count,
    this.rows,
  });

  factory UserAndAssociatedHorsesResponseModel.fromRawJson(String str) =>
      UserAndAssociatedHorsesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAndAssociatedHorsesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UserAndAssociatedHorsesResponseModel(
        count: json["count"],
        rows: json["rows"] == null
            ? []
            : List<UserAndAssociatedHorses>.from(
                json["rows"]!.map((x) => UserAndAssociatedHorses.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class UserAndAssociatedHorses {
  int? id;
  int? userId;
  User? user;
  int? disciplineId;
  Discipline? discipline;
  int? stableId;
  Stable? stable;
  String? name;
  int? age;
  String? image;
  String? status;
  String? dateOfBirth;
  String? placeOfBirth;
  String? color;
  String? gender;
  String? bloodLine;
  String? breed;
  String? horseNationalPassport;
  String? horseFeiPassport;
  String? horseSire;
  String? horseDam;
  String? horseDamSire;
  String? horseMicrochipCode;
  String? horseNote;
  bool? isPony;
  bool? isVerified;
  bool? isSportHorse;
  bool? isDommy;
  String? docsRequestDate;
  String? uelnCode;
  String? feId;
  int? createdBy;
  User? createdByUser;
  String? updatedAt;

  UserAndAssociatedHorses({
    this.id,
    this.userId,
    this.user,
    this.disciplineId,
    this.discipline,
    this.stableId,
    this.stable,
    this.name,
    this.age,
    this.image,
    this.status,
    this.dateOfBirth,
    this.placeOfBirth,
    this.color,
    this.gender,
    this.bloodLine,
    this.breed,
    this.horseNationalPassport,
    this.horseFeiPassport,
    this.horseSire,
    this.horseDam,
    this.horseDamSire,
    this.horseMicrochipCode,
    this.horseNote,
    this.isPony,
    this.isVerified,
    this.isSportHorse,
    this.isDommy,
    this.docsRequestDate,
    this.uelnCode,
    this.feId,
    this.createdBy,
    this.createdByUser,
    this.updatedAt,
  });

  factory UserAndAssociatedHorses.fromRawJson(String str) =>
      UserAndAssociatedHorses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAndAssociatedHorses.fromJson(Map<String, dynamic> json) =>
      UserAndAssociatedHorses(
        id: json["id"],
        userId: json["userId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        disciplineId: json["disciplineId"],
        discipline: json["discipline"] == null
            ? null
            : Discipline.fromJson(json["discipline"]),
        stableId: json["stableId"],
        stable: json["stable"] == null ? null : Stable.fromJson(json["stable"]),
        name: json["name"],
        age: json["age"],
        image: json["image"],
        status: json["status"],
        dateOfBirth: json["dateOfBirth"],
        placeOfBirth: json["placeOfBirth"],
        color: json["color"],
        gender: json["gender"],
        bloodLine: json["bloodLine"],
        breed: json["breed"],
        horseNationalPassport: json["horseNationalPassport"],
        horseFeiPassport: json["horseFEIPassport"],
        horseSire: json["horseSire"],
        horseDam: json["horseDam"],
        horseDamSire: json["horseDamSire"],
        horseMicrochipCode: json["horseMicrochipCode"],
        horseNote: json["horseNote"],
        isPony: json["isPony"],
        isVerified: json["isVerified"],
        isSportHorse: json["isSportHorse"],
        isDommy: json["isDommy"],
        docsRequestDate: json["docsRequestDate"],
        uelnCode: json["UELNCode"],
        feId: json["FEId"],
        createdBy: json["createdBy"],
        createdByUser: json["createdByUser"] == null
            ? null
            : User.fromJson(json["createdByUser"]),
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "user": user?.toJson(),
        "disciplineId": disciplineId,
        "discipline": discipline?.toJson(),
        "stableId": stableId,
        "stable": stable?.toJson(),
        "name": name,
        "age": age,
        "image": image,
        "status": status,
        "dateOfBirth": dateOfBirth,
        "placeOfBirth": placeOfBirth,
        "color": color,
        "gender": gender,
        "bloodLine": bloodLine,
        "breed": breed,
        "horseNationalPassport": horseNationalPassport,
        "horseFEIPassport": horseFeiPassport,
        "horseSire": horseSire,
        "horseDam": horseDam,
        "horseDamSire": horseDamSire,
        "horseMicrochipCode": horseMicrochipCode,
        "horseNote": horseNote,
        "isPony": isPony,
        "isVerified": isVerified,
        "isSportHorse": isSportHorse,
        "isDommy": isDommy,
        "docsRequestDate": docsRequestDate,
        "UELNCode": uelnCode,
        "FEId": feId,
        "createdBy": createdBy,
        "createdByUser": createdByUser?.toJson(),
        "updatedAt": updatedAt,
      };
}

class User {
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
  Stable? mainStable;
  int? mainDisciplineId;
  Discipline? mainDiscipline;
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

  User({
    this.id,
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
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
        userType: json["userType"] == null
            ? []
            : List<String>.from(json["userType"]!.map((x) => x)),
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        gender: json["gender"],
        nationality: json["nationality"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        steps: json["steps"] == null ? null : Steps.fromJson(json["steps"]),
        userName: json["userName"],
        verifiedEmail: json["verifiedEmail"],
        verifiedPhoneNumber: json["verifiedPhoneNumber"],
        isBlocked: json["isBlocked"],
        image: json["image"],
        mainStableId: json["mainStableId"],
        mainStable: json["mainStable"] == null
            ? null
            : Stable.fromJson(json["mainStable"]),
        mainDisciplineId: json["mainDisciplineId"],
        mainDiscipline: json["mainDiscipline"] == null
            ? null
            : Discipline.fromJson(json["mainDiscipline"]),
        displayName: json["displayName"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        secondNumber: json["secondNumber"],
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        dateOfBirth: json["dateOfBirth"],
        zohoId: json["zohoId"],
        isRegisterdInZoho: json["isRegisterdInZoho"],
        salutation: json["salutation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phoneNumber": phoneNumber,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "userType":
            userType == null ? [] : List<dynamic>.from(userType!.map((x) => x)),
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "gender": gender,
        "nationality": nationality,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "steps": steps?.toJson(),
        "userName": userName,
        "verifiedEmail": verifiedEmail,
        "verifiedPhoneNumber": verifiedPhoneNumber,
        "isBlocked": isBlocked,
        "image": image,
        "mainStableId": mainStableId,
        "mainStable": mainStable?.toJson(),
        "mainDisciplineId": mainDisciplineId,
        "mainDiscipline": mainDiscipline?.toJson(),
        "displayName": displayName,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "secondNumber": secondNumber,
        "account": account?.toJson(),
        "dateOfBirth": dateOfBirth,
        "zohoId": zohoId,
        "isRegisterdInZoho": isRegisterdInZoho,
        "salutation": salutation,
      };
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
  String? iban;
  String? swiftCode;
  String? accountHolderName;
  String? accountNote;

  Account({
    this.id,
    this.totalAmount,
    this.blockedAmount,
    this.availableAmount,
    this.userId,
    this.user,
    this.bankName,
    this.accountNumber,
    this.iban,
    this.swiftCode,
    this.accountHolderName,
    this.accountNote,
  });

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        totalAmount: json["totalAmount"],
        blockedAmount: json["blockedAmount"],
        availableAmount: json["availableAmount"],
        userId: json["userId"],
        user: json["user"],
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        iban: json["IBAN"],
        swiftCode: json["swiftCode"],
        accountHolderName: json["accountHolderName"],
        accountNote: json["accountNote"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalAmount": totalAmount,
        "blockedAmount": blockedAmount,
        "availableAmount": availableAmount,
        "userId": userId,
        "user": user,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "IBAN": iban,
        "swiftCode": swiftCode,
        "accountHolderName": accountHolderName,
        "accountNote": accountNote,
      };
}

class Discipline {
  int? id;
  String? title;
  String? code;

  Discipline({
    this.id,
    this.title,
    this.code,
  });

  factory Discipline.fromRawJson(String str) =>
      Discipline.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Discipline.fromJson(Map<String, dynamic> json) => Discipline(
        id: json["id"],
        title: json["title"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
      };
}

class Stable {
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

  Stable({
    this.id,
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
    this.createdBy,
  });

  factory Stable.fromRawJson(String str) => Stable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stable.fromJson(Map<String, dynamic> json) => Stable(
        id: json["id"],
        name: json["name"],
        stableCode: json["stableCode"],
        stableType: json["stableType"],
        emirate: json["emirate"],
        pinLocation: json["pinLocation"],
        stableAddress: json["stableAddress"],
        stableCountry: json["stableCountry"],
        isManaged: json["isManaged"],
        isVerified: json["isVerified"],
        isDummy: json["isDummy"],
        showOnApp: json["showOnApp"],
        status: json["status"],
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stableCode": stableCode,
        "stableType": stableType,
        "emirate": emirate,
        "pinLocation": pinLocation,
        "stableAddress": stableAddress,
        "stableCountry": stableCountry,
        "isManaged": isManaged,
        "isVerified": isVerified,
        "isDummy": isDummy,
        "showOnApp": showOnApp,
        "status": status,
        "createdBy": createdBy,
      };
}

class Steps {
  bool? isAddMainDiscipline;
  bool? isAddMainStable;
  bool? isAddUserName;
  bool? isAddRole;
  bool? isVerifiedPhoneNumber;
  bool? isVerifiedEmail;

  Steps({
    this.isAddMainDiscipline,
    this.isAddMainStable,
    this.isAddUserName,
    this.isAddRole,
    this.isVerifiedPhoneNumber,
    this.isVerifiedEmail,
  });

  factory Steps.fromRawJson(String str) => Steps.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Steps.fromJson(Map<String, dynamic> json) => Steps(
        isAddMainDiscipline: json["isAddMainDiscipline"],
        isAddMainStable: json["isAddMainStable"],
        isAddUserName: json["isAddUserName"],
        isAddRole: json["isAddRole"],
        isVerifiedPhoneNumber: json["isVerifiedPhoneNumber"],
        isVerifiedEmail: json["isVerifiedEmail"],
      );

  Map<String, dynamic> toJson() => {
        "isAddMainDiscipline": isAddMainDiscipline,
        "isAddMainStable": isAddMainStable,
        "isAddUserName": isAddUserName,
        "isAddRole": isAddRole,
        "isVerifiedPhoneNumber": isVerifiedPhoneNumber,
        "isVerifiedEmail": isVerifiedEmail,
      };
}
