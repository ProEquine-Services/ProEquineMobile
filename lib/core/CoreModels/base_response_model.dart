import '../errors/base_error.dart';
import '../utils/printer.dart';
import 'base_result_model.dart';

class BaseResponseModel<Result extends BaseResultModel> {
  bool? success;
  Result? data;
  Message? message;
  BaseResponseModel({
    this.success,
    this.data,
    this.message,
  });

  BaseResponseModel.fromJson({
    Map<String, dynamic>? json,
    Result Function(Map<String, dynamic>)? fromJson,
    BaseError? error,
  }) {
    Print('json $json');
    Print('error $error');

    if (json == null) {
      if (error != null) {
        success = false;
      }
    } else {
      success = json['success'];
      message = (json['message'] != null ? Message(content: json['message']) : null);

      if (fromJson != null) {
        if (json['data'] != null) {
          if ((json['data'] is List)) {
            data = fromJson(json);
          } else {
            data = fromJson(json['data']);
          }
        } else {
          if (success!) {
            data = fromJson({"": ""});
          }
        }
      }
    }
  }

  @override
  String toString() {
    return 'BaseResponseModel{\nsuccess: $success, \ndata: $data, \nmessage: $message\n}';
  }
}

class Message extends BaseResultModel {
  Message({
    required this.content,
  });

  late String content;

  Message.fromJson(Map<String, dynamic> json) {
    if(json["message"]==null){
      content='';
    }
    if (json["message"] is List) {
      List list = json["message"];
      if (list.isNotEmpty) {
        content = list[0];
      } else {
        content = '';
      }
    } else {
      content = json["message"];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        "message": content,
      };

  @override
  String toString() {
    return content;
  }
}
