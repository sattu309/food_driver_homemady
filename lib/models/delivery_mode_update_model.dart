class DeliveryModeUpdateModel {
  bool? status;
  String? message;
  Data? data;

  DeliveryModeUpdateModel({this.status, this.message, this.data});

  DeliveryModeUpdateModel.fromJson(Map<String, dynamic> json) {
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
  dynamic isDriver;
  dynamic isVendor;
  dynamic marketingBalance;
  dynamic walletBalance;
  dynamic earnedBalance;
  String? name;
  String? lastName;
  String? phone;
  String? email;
  dynamic otp;
  dynamic otpCreatedAt;
  dynamic otpVerified;
  String? profileImage;
  dynamic socialProfileImage;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic defaultAddress;
  dynamic referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic collectionStatus;
  dynamic adminCommissionType;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic featuredStore;
  dynamic emailVerifiedAt;
  dynamic status;
  dynamic isProfileComplete;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.marketingBalance,
        this.walletBalance,
        this.earnedBalance,
        this.name,
        this.lastName,
        this.phone,
        this.email,
        this.otp,
        this.otpCreatedAt,
        this.otpVerified,
        this.profileImage,
        this.socialProfileImage,
        this.latitude,
        this.longitude,
        this.location,
        this.defaultAddress,
        this.referalCode,
        this.deviceToken,
        this.deviceId,
        this.isDriverOnline,
        this.isVendorOnline,
        this.deliveryRange,
        this.selfDelivery,
        this.collectionStatus,
        this.adminCommissionType,
        this.adminCommission,
        this.asDriverVerified,
        this.asVendorVerified,
        this.featuredStore,
        this.emailVerifiedAt,
        this.status,
        this.isProfileComplete,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    marketingBalance = json['marketing_balance'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    name = json['name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    otpVerified = json['otp_verified'];
    profileImage = json['profile_image'];
    socialProfileImage = json['social_profile_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    defaultAddress = json['default_address'];
    referalCode = json['referal_code'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    collectionStatus = json['collection_status'];
    adminCommissionType = json['admin_commission_type'];
    adminCommission = json['admin_commission'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    featuredStore = json['featured_store'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    isProfileComplete = json['is_profile_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_driver'] = isDriver;
    data['is_vendor'] = isVendor;
    data['marketing_balance'] = marketingBalance;
    data['wallet_balance'] = walletBalance;
    data['earned_balance'] = earnedBalance;
    data['name'] = name;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['otp'] = otp;
    data['otp_created_at'] = otpCreatedAt;
    data['otp_verified'] = otpVerified;
    data['profile_image'] = profileImage;
    data['social_profile_image'] = socialProfileImage;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['default_address'] = defaultAddress;
    data['referal_code'] = referalCode;
    data['device_token'] = deviceToken;
    data['device_id'] = deviceId;
    data['is_driver_online'] = isDriverOnline;
    data['is_vendor_online'] = isVendorOnline;
    data['delivery_range'] = deliveryRange;
    data['self_delivery'] = selfDelivery;
    data['collection_status'] = collectionStatus;
    data['admin_commission_type'] = adminCommissionType;
    data['admin_commission'] = adminCommission;
    data['as_driver_verified'] = asDriverVerified;
    data['as_vendor_verified'] = asVendorVerified;
    data['featured_store'] = featuredStore;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['is_profile_complete'] = isProfileComplete;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
