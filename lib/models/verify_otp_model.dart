// class ModelVerifyOtp {
//   bool? status;
//   String? message;
//   String? authToken;
//   Data? data;
//
//   ModelVerifyOtp({this.status, this.message, this.authToken, this.data});
//
//   ModelVerifyOtp.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     authToken = json['auth_token'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['auth_token'] = this.authToken;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic id;
//   bool? isDriver;
//   bool? isVendor;
//   bool? isMarketingManager;
//   String? latitude;
//   String? longitude;
//   String? location;
//   String? name;
//   String? email;
//   String? phone;
//   String? walletBalance;
//   String? earnedBalance;
//   String? profileImage;
//   String? referalCode;
//   bool? isDriverOnline;
//   bool? isVendorOnline;
//   dynamic deliveryRange;
//   bool? selfDelivery;
//   bool? asDriverVerified;
//   bool? asVendorVerified;
//   bool? asMarketingManagerVerified;
//   bool? isProfileComplete;
//
//   Data(
//       {this.id,
//         this.isDriver,
//         this.isVendor,
//         this.isMarketingManager,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.name,
//         this.email,
//         this.phone,
//         this.walletBalance,
//         this.earnedBalance,
//         this.profileImage,
//         this.referalCode,
//         this.isDriverOnline,
//         this.isVendorOnline,
//         this.deliveryRange,
//         this.selfDelivery,
//         this.asDriverVerified,
//         this.asVendorVerified,
//         this.asMarketingManagerVerified,
//         this.isProfileComplete});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isDriver = json['is_driver'];
//     isVendor = json['is_vendor'];
//     isMarketingManager = json['is_marketing_manager'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     walletBalance = json['wallet_balance'];
//     earnedBalance = json['earned_balance'];
//     profileImage = json['profile_image'];
//     referalCode = json['referal_code'];
//     isDriverOnline = json['is_driver_online'];
//     isVendorOnline = json['is_vendor_online'];
//     deliveryRange = json['delivery_range'];
//     selfDelivery = json['self_delivery'];
//     asDriverVerified = json['as_driver_verified'];
//     asVendorVerified = json['as_vendor_verified'];
//     asMarketingManagerVerified = json['as_marketing_manager_verified'];
//     isProfileComplete = json['is_profile_complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['is_driver'] = this.isDriver;
//     data['is_vendor'] = this.isVendor;
//     data['is_marketing_manager'] = this.isMarketingManager;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['location'] = this.location;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['wallet_balance'] = this.walletBalance;
//     data['earned_balance'] = this.earnedBalance;
//     data['profile_image'] = this.profileImage;
//     data['referal_code'] = this.referalCode;
//     data['is_driver_online'] = this.isDriverOnline;
//     data['is_vendor_online'] = this.isVendorOnline;
//     data['delivery_range'] = this.deliveryRange;
//     data['self_delivery'] = this.selfDelivery;
//     data['as_driver_verified'] = this.asDriverVerified;
//     data['as_vendor_verified'] = this.asVendorVerified;
//     data['as_marketing_manager_verified'] = this.asMarketingManagerVerified;
//     data['is_profile_complete'] = this.isProfileComplete;
//     return data;
//   }
// }
class ModelVerifyOtp {
  bool? status;
  String? message;
  String? authToken;
  Data? data;

  ModelVerifyOtp({this.status, this.message, this.authToken, this.data});

  ModelVerifyOtp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authToken = json['auth_token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['auth_token'] = authToken;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  bool? isDriver;
  bool? isVendor;
  String? latitude;
  String? longitude;
  String? location;
  String? name;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;
  List<void>? defaultAddress;
  String? walletBalance;
  String? earnedBalance;
  String? profileImage;
  String? referalCode;
  bool? isDriverOnline;
  bool? isVendorOnline;
  int? deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? isProfileComplete;

  Data(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.latitude,
        this.longitude,
        this.location,
        this.name,
        this.lastName,
        this.email,
        this.countryCode,
        this.phone,
        this.defaultAddress,
        this.walletBalance,
        this.earnedBalance,
        this.profileImage,
        this.referalCode,
        this.isDriverOnline,
        this.isVendorOnline,
        this.deliveryRange,
        this.selfDelivery,
        this.asDriverVerified,
        this.asVendorVerified,
        this.isProfileComplete});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    if (json['default_address '] != null) {
      defaultAddress = <Null>[];
      json['default_address '].forEach((v) {
        //defaultAddress!.add(new Null.fromJson(v));
      });
    }
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    profileImage = json['profile_image'];
    referalCode = json['referal_code'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    isProfileComplete = json['is_profile_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_driver'] = isDriver;
    data['is_vendor'] = isVendor;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['name'] = name;
    data['last_name'] = lastName;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    if (defaultAddress != null) {
      // data['default_address '] =
      //     this.defaultAddress!.map((v) => v.toJson()).toList();
    }
    data['wallet_balance'] = walletBalance;
    data['earned_balance'] = earnedBalance;
    data['profile_image'] = profileImage;
    data['referal_code'] = referalCode;
    data['is_driver_online'] = isDriverOnline;
    data['is_vendor_online'] = isVendorOnline;
    data['delivery_range'] = deliveryRange;
    data['self_delivery'] = selfDelivery;
    data['as_driver_verified'] = asDriverVerified;
    data['as_vendor_verified'] = asVendorVerified;
    data['is_profile_complete'] = isProfileComplete;
    return data;
  }
}
