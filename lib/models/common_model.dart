class ModelCommonResponse {
  bool? status;
  String? message;

  ModelCommonResponse({this.status, this.message});

  ModelCommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}


class ModelCommonResponse1 {
  bool? status;
  String? message;
  dynamic data;

  ModelCommonResponse1({this.status, this.message,this.data});

  ModelCommonResponse1.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}