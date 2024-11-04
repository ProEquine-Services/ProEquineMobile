import 'package:proequine_dev/core/CoreModels/base_result_model.dart';

import '../../equine_info/data/add_secondary_interests_response_model.dart';

class NotificationsResponseModel extends BaseResultModel{
  int? count;
  List<NotificationModel>? rows;

  NotificationsResponseModel({this.count, this.rows});

  NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <NotificationModel>[];
      json['rows'].forEach((v) {
        rows!.add(NotificationModel.fromJson(v));
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

class NotificationModel {
  int? id;
  String? type;
  int? userId;
  User? user;
  bool? isPublic;
  Content? content;
  Content? title;
  bool? seen;
  String? dateTime;

  NotificationModel(
      {this.id, this.type, this.userId, this.user, this.isPublic, this.content, this.title, this.seen,this.dateTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isPublic = json['isPublic'];
    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;
    title = json['title'] != null ? Content.fromJson(json['title']) : null;
    seen = json['seen'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['isPublic'] = isPublic;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['seen'] = seen;
    data['dateTime'] = dateTime;
    return data;
  }
}
class Content {
  String? en;
  String? ar;

  Content({this.en, this.ar});

  Content.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}