import '../../../core/CoreModels/base_result_model.dart';

class EventsResponseModel extends BaseResultModel {
  int? id;
  String? eventTitle;
  String? eventDate;
  String? eventImage;
  String? place;

  EventsResponseModel({this.id, this.eventTitle, this.eventDate, this.eventImage, this.place});

  EventsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventTitle = json['eventTitle'];
    eventDate = json['eventDate'];
    eventImage = json['imageURL'];
    place = json['place'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventTitle'] = eventTitle;
    data['eventDate'] = eventDate;
    data['imageURL'] = eventImage;
    data['place'] = place;
    return data;
  }
}