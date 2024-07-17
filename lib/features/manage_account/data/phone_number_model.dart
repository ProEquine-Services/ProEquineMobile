// class PhoneModel{
//   String? mainPhoneNumber;
//   List<SecondaryPhoneNumbers> secondary;
// }
//
// class SecondaryPhoneNumbers {
//   String? phoneNumber;
//   String? title;
//
//   SecondaryPhoneNumbers({this.phoneNumber, this.title});
//
//   SecondaryPhoneNumbers.fromJson(Map<String, dynamic> json) {
//     phoneNumber = json['phoneNumber'];
//     title = json['title'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['phoneNumber'] = this.phoneNumber;
//     data['title'] = this.title;
//     return data;
//   }
// }