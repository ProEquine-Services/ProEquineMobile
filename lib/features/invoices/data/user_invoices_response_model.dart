import 'dart:convert';

import '../../../core/CoreModels/base_result_model.dart';


class UserInvoicesResponseModel extends BaseResultModel {
  int? count;
  List<Invoice>? rows;

  UserInvoicesResponseModel({
    this.count,
    this.rows,
  });

  factory UserInvoicesResponseModel.fromRawJson(String str) =>
      UserInvoicesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInvoicesResponseModel.fromJson(Map<String, dynamic> json) =>
      UserInvoicesResponseModel(
        count: json["count"],
        rows: json["rows"] == null
            ? []
            : List<Invoice>.from(json["rows"]!.map((x) => Invoice.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Invoice {
  int? id;
  int? userId;
  User? user;
  int? baseServiceId;
  BaseService? baseService;
  int? amount;
  String? invoiceIdZh;
  String? url;
  num? walletAvailableAmount;
  String? status;
  InvoiceDetails? invoiceDetails;

  Invoice({
    this.id,
    this.userId,
    this.user,
    this.baseServiceId,
    this.baseService,
    this.amount,
    this.invoiceIdZh,
    this.url,
    this.status,
    this.walletAvailableAmount,
    this.invoiceDetails,
  });

  factory Invoice.fromRawJson(String str) => Invoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        userId: json["userId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        baseServiceId: json["baseServiceId"],
        baseService: json["baseService"] == null
            ? null
            : BaseService.fromJson(json["baseService"]),
        amount: json["amount"],
        invoiceIdZh: json["invoiceIdZh"],
        url: json["url"],
    walletAvailableAmount: json["walletAvailableAmount"],
        status: json["status"],
        invoiceDetails: json["invoiceDetails"] == null
            ? null
            : InvoiceDetails.fromJson(json["invoiceDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "user": user?.toJson(),
        "baseServiceId": baseServiceId,
        "baseService": baseService?.toJson(),
        "amount": amount,
        "invoiceIdZh": invoiceIdZh,
        "url": url,
        "status": status,
        "walletAvailableAmount": walletAvailableAmount,
        "invoiceDetails": invoiceDetails?.toJson(),
      };
}

class BaseService {
  int? id;
  String? serviceCategory;
  String? serviceType;
  String? serviceSource;
  int? serviceLineQty;
  int? modifiedBy;
  int? userId;
  bool? isBelongToSelective;
  int? selectiveParent;
  String? status;
  DateTime? startDate;
  DateTime? updatedAt;
  String? invoiceUrl;

  BaseService({
    this.id,
    this.serviceCategory,
    this.serviceType,
    this.serviceSource,
    this.serviceLineQty,
    this.modifiedBy,
    this.userId,
    this.isBelongToSelective,
    this.selectiveParent,
    this.status,
    this.startDate,
    this.updatedAt,
    this.invoiceUrl,
  });

  factory BaseService.fromRawJson(String str) =>
      BaseService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseService.fromJson(Map<String, dynamic> json) => BaseService(
        id: json["id"],
        serviceCategory: json["serviceCategory"],
        serviceType: json["serviceType"],
        serviceSource: json["serviceSource"],
        serviceLineQty: json["serviceLineQty"],
        modifiedBy: json["modifiedBy"],
        userId: json["userId"],
        isBelongToSelective: json["isBelongToSelective"],
        selectiveParent: json["selectiveParent"],
        status: json["status"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        invoiceUrl: json["invoiceUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceCategory": serviceCategory,
        "serviceType": serviceType,
        "serviceSource": serviceSource,
        "serviceLineQty": serviceLineQty,
        "modifiedBy": modifiedBy,
        "userId": userId,
        "isBelongToSelective": isBelongToSelective,
        "selectiveParent": selectiveParent,
        "status": status,
        "startDate": startDate?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "invoiceUrl": invoiceUrl,
      };
}

class InvoiceDetails {
  DateTime? date;
  String? type;
  String? email;
  String? notes;
  List<Tax>? taxes;
  String? terms;
  int? total;
  String? status;
  int? balance;
  DateTime? dueDate;
  int? subTotal;
  int? taxTotal;
  String? invoiceId;
  List<LineItem>? lineItems;
  String? pageHeight;
  List<dynamic>? salesorders;
  DateTime? createdDate;
  String? invoiceNumber;
  String? createdTime;
  int? bcySubTotal;
  int? bcyTaxTotal;

  InvoiceDetails(
      {this.date,
      this.type,
      this.email,
      this.notes,
      this.taxes,
      this.terms,
      this.total,
      this.status,
      this.balance,
      this.dueDate,
      this.subTotal,
      this.taxTotal,
      this.invoiceId,
      this.lineItems,
        this.invoiceNumber,
      this.salesorders,
      this.createdDate,
      this.createdTime,
      this.bcySubTotal,
      this.bcyTaxTotal});

  factory InvoiceDetails.fromRawJson(String str) =>
      InvoiceDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceDetails.fromJson(Map<String, dynamic> json) => InvoiceDetails(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        type: json["type"],
        email: json["email"],
        notes: json["notes"],
        taxes: json["taxes"] == null
            ? []
            : List<Tax>.from(json["taxes"]!.map((x) => Tax.fromJson(x))),
        terms: json["terms"],
        total: json["total"],
        status: json["status"],
        balance: json["balance"],
    invoiceNumber: json["invoice_number"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        subTotal: json["sub_total"],
        taxTotal: json["tax_total"],
        invoiceId: json["invoice_id"],
        lineItems: json["line_items"] == null
            ? []
            : List<LineItem>.from(
                json["line_items"]!.map((x) => LineItem.fromJson(x))),
        salesorders: json["salesorders"] == null
            ? []
            : List<dynamic>.from(json["salesorders"]!.map((x) => x)),
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        bcySubTotal: json["bcy_sub_total"],
        bcyTaxTotal: json["bcy_tax_total"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "type": type,
        "email": email,
        "notes": notes,
        "taxes": taxes == null
            ? []
            : List<dynamic>.from(taxes!.map((x) => x.toJson())),
        "terms": terms,
        "total": total,
        "status": status,
        "balance": balance,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "sub_total": subTotal,
        "tax_total": taxTotal,
        "invoice_id": invoiceId,
        "invoice_number": invoiceNumber,
        "line_items": lineItems == null
            ? []
            : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
        "page_height": pageHeight,
        "salesorders": salesorders == null
            ? []
            : List<dynamic>.from(salesorders!.map((x) => x)),
        "created_date":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "bcy_sub_total": bcySubTotal,
        "bcy_tax_total": bcyTaxTotal,
      };
}

class LineItem {
  String? name;
  int? rate;
  String? unit;
  String? taxId;
  String? billId;
  String? itemId;
  int? bcyRate;
  int? discount;
  int? quantity;
  String? itemType;
  int? itemOrder;
  int? itemTotal;
  int? costAmount;
  String? description;

  LineItem({
    this.name,
    this.rate,
    this.unit,
    this.taxId,
    this.billId,
    this.itemId,
    this.bcyRate,
    this.discount,
    this.quantity,
    this.itemType,
    this.itemOrder,
    this.itemTotal,
    this.costAmount,
    this.description,
  });

  factory LineItem.fromRawJson(String str) =>
      LineItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        name: json["name"],
        rate: json["rate"],
        unit: json["unit"],
        taxId: json["tax_id"],
        billId: json["bill_id"],
        itemId: json["item_id"],
        bcyRate: json["bcy_rate"],
        discount: json["discount"],
        quantity: json["quantity"],
        itemType: json["item_type"],
        itemOrder: json["item_order"],
        itemTotal: json["item_total"],
        costAmount: json["cost_amount"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rate": rate,
        "unit": unit,
        "tax_id": taxId,
        "bill_id": billId,
        "item_id": itemId,
        "bcy_rate": bcyRate,
        "discount": discount,
        "quantity": quantity,
        "item_type": itemType,
        "item_order": itemOrder,
        "item_total": itemTotal,
        "cost_amount": costAmount,
        "description": description,
      };
}

class ReferenceInvoice {
  String? referenceInvoiceId;

  ReferenceInvoice({
    this.referenceInvoiceId,
  });

  factory ReferenceInvoice.fromRawJson(String str) =>
      ReferenceInvoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReferenceInvoice.fromJson(Map<String, dynamic> json) =>
      ReferenceInvoice(
        referenceInvoiceId: json["reference_invoice_id"],
      );

  Map<String, dynamic> toJson() => {
        "reference_invoice_id": referenceInvoiceId,
      };
}

class Tax {
  String? taxName;
  int? taxAmount;
  String? taxAmountFormatted;

  Tax({
    this.taxName,
    this.taxAmount,
    this.taxAmountFormatted,
  });

  factory Tax.fromRawJson(String str) => Tax.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        taxName: json["tax_name"],
        taxAmount: json["tax_amount"],
        taxAmountFormatted: json["tax_amount_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "tax_name": taxName,
        "tax_amount": taxAmount,
        "tax_amount_formatted": taxAmountFormatted,
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
  String? userName;
  bool? verifiedEmail;
  bool? verifiedPhoneNumber;
  bool? isBlocked;
  String? image;
  int? mainStableId;
  int? mainDisciplineId;
  String? displayName;
  String? address;
  String? country;
  String? state;
  String? city;
  String? secondNumber;
  DateTime? dateOfBirth;
  String? zohoId;
  bool? isRegisterdInZoho;

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
    this.userName,
    this.verifiedEmail,
    this.verifiedPhoneNumber,
    this.isBlocked,
    this.image,
    this.mainStableId,
    this.mainDisciplineId,
    this.displayName,
    this.address,
    this.country,
    this.state,
    this.city,
    this.secondNumber,
    this.dateOfBirth,
    this.zohoId,
    this.isRegisterdInZoho,
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
        userName: json["userName"],
        verifiedEmail: json["verifiedEmail"],
        verifiedPhoneNumber: json["verifiedPhoneNumber"],
        isBlocked: json["isBlocked"],
        image: json["image"],
        mainStableId: json["mainStableId"],
        mainDisciplineId: json["mainDisciplineId"],
        displayName: json["displayName"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        secondNumber: json["secondNumber"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        zohoId: json["zohoId"],
        isRegisterdInZoho: json["isRegisterdInZoho"],
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
        "userName": userName,
        "verifiedEmail": verifiedEmail,
        "verifiedPhoneNumber": verifiedPhoneNumber,
        "isBlocked": isBlocked,
        "image": image,
        "mainStableId": mainStableId,
        "mainDisciplineId": mainDisciplineId,
        "displayName": displayName,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "secondNumber": secondNumber,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "zohoId": zohoId,
        "isRegisterdInZoho": isRegisterdInZoho,
      };
}
