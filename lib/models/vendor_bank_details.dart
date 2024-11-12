class VendorBankDetailsModel {
  bool? status;
  String? message;
  Data? data;

  VendorBankDetailsModel({this.status, this.message, this.data});

  VendorBankDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null && json['data'].toString() != "[]" ? Data.fromJson(json['data']) : null;
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
    bank = json['bank_name'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank_name'] = bank;
    data['account_name'] = accountName;
    data['account_no'] = accountNo;
    data['ifsc_code'] = ifscCode;
    return data;
  }
}