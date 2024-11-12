class VendorBankListModel {
  bool? status;
  String? message;
  Data? data;

  VendorBankListModel({this.status, this.message, this.data});

  VendorBankListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null && json['data'].toString() != "{}" ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Banks>? banks;

  Data({this.banks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banks != null) {
      data['banks'] = banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  dynamic id;
  String? name;

  Banks({this.id, this.name});

  Banks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}