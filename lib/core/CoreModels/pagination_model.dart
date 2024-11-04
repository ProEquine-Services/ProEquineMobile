import 'base_result_model.dart';

class Pagination extends BaseResultModel {
  int? pageNumber;
  int? pageSize;
  List<dynamic>? data;
  String? firstPage;
  String? lastPage;
  int? totalPages;
  int? totalRecords;
  String? nextPage;
  String? previousPage;

  Pagination(
      {this.pageNumber,
        this.pageSize,
        this.firstPage,
        this.lastPage,
        this.data,
        this.totalPages,
        this.totalRecords,
        this.nextPage,
        this.previousPage,});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    if (json['data'] != null) {
      data = json['data'];
      // json['data'].forEach((v) {
      //   data.add(new Brand.fromJson(v));
      // });
    }
    pageSize = json['pageSize'];
    firstPage = json['firstPage'];
    lastPage = json['lastPage'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['firstPage'] = firstPage;
    data['lastPage'] = lastPage;
    data['totalPages'] = totalPages;
    data['totalRecords'] = totalRecords;
    data['nextPage'] = nextPage;
    data['previousPage'] = previousPage;
    return data;
  }
}
