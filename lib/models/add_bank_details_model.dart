class VendorAddAccountDetailsModel {
  bool? status;
  String? message;
  Data? data;

  VendorAddAccountDetailsModel({this.status, this.message, this.data});

  VendorAddAccountDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  dynamic id;
  String? bank;
  String? accountName;
  String? accountNo;
  String? ifscCode;

  Data({this.id, this.bank, this.accountName, this.accountNo, this.ifscCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank'] = bank;
    data['account_name'] = accountName;
    data['account_no'] = accountNo;
    data['ifsc_code'] = ifscCode;
    return data;
  }
}