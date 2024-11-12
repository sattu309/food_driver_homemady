
class assgnedOrderList {
  bool? status;
  String? message;
  List<Data>? data;
  // OrderDetail? orderDetail;
  String vendorID ="";

  assgnedOrderList({this.status, this.message, this.data});

  assgnedOrderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic date;
  dynamic orderId;
  dynamic paymentMethod;
  dynamic orderTotal;
  dynamic pick_up_time;
  dynamic orderStatus;
  dynamic accpetanceStatus;
  Location? location;

  Data(
      {this.date,
        this.orderId,
        this.paymentMethod,
        this.accpetanceStatus,
        this.orderTotal,
        this.pick_up_time,
        this.orderStatus,
        this.location});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    orderId = json['order_id'];
    paymentMethod = json['payment_method'];
    orderTotal = json['order_total'];
    pick_up_time = json['pick_up_time'];
    orderStatus = json['order_status'];
    accpetanceStatus = json['accpetance_status'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['order_id'] = orderId;
    data['payment_method'] = paymentMethod;
    data['order_total'] = orderTotal;
    data['pick_up_time'] = pick_up_time;
    data['accpetance_status'] = accpetanceStatus;
    data['order_status'] = orderStatus;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

// class OrderDetail {
//
//   String vendorID ="";
//   dynamic orderId;
//   dynamic itemTotal;
//   dynamic tax;
//   dynamic deliveryCharges;
//   dynamic packingFee;
//   dynamic tipAmount;
//   CouponDiscount? couponDiscount;
//   dynamic serviceCharge;
//   dynamic grandTotal;
//   dynamic deliveryType;
//   dynamic minOrderCharge;
//   dynamic specialRequets;
//   dynamic deliveryTime;
//   dynamic instructionForDelivery;
//   User? user;
//   Vendor? vendor;
//   Driver? driver;
//   dynamic address;
//   dynamic orderType;
//   dynamic deliveryStatus;
//   dynamic feedback;
//   List<OrderItems>? orderItems;
//   dynamic placedAt;
//
//   OrderDetail(
//       {this.orderId,
//         this.itemTotal,
//         this.tax,
//         this.deliveryCharges,
//         this.tipAmount,
//         this.packingFee,
//         this.couponDiscount,
//         this.grandTotal,
//         this.deliveryType,
//         this.minOrderCharge,
//         this.user,
//         this.vendor,
//         this.specialRequets,
//         this.serviceCharge,
//         this.driver,
//         this.address,
//         this.deliveryTime,
//         this.instructionForDelivery,
//         this.orderType,
//         this.deliveryStatus,
//         this.feedback,
//         this.orderItems,
//         this.placedAt});
//
//   OrderDetail.fromJson(Map<dynamic, dynamic> json) {
//     orderId = json['order_id'];
//     itemTotal = json['item_total'];
//     tax = json['tax'];
//     deliveryCharges = json['delivery_charges'];
//     tipAmount = json['tip_amount'];
//     deliveryType = json['delivery_type'];
//     minOrderCharge = json['min_order_charge'];
//     deliveryTime = json['delivery_time'];
//     packingFee = json['packing_fee'];
//     couponDiscount = json['coupon_discount'] != null
//         ? new CouponDiscount.fromJson(json['coupon_discount'])
//         : null;
//     minOrderCharge = json['min_order_charge'];
//     serviceCharge = json['service_charge'];
//     specialRequets = json['special_requets'];
//     instructionForDelivery = json['instruction_for_delivery'];
//     grandTotal = json['grand_total'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     vendor =
//     json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
//     user = json['driver'] != null ? new User.fromJson(json['driver']) : null;
//     address =
//     json['address'] != null ? new Address.fromJson(json['address']) : null;
//     orderType = json['order_type'];
//     deliveryStatus = json['delivery_status'];
//     if (json['order_items'] != null) {
//       orderItems = <OrderItems>[];
//       json['order_items'].forEach((v) {
//         orderItems!.add(new OrderItems.fromJson(v));
//       });
//     }
//     feedback = json['feedback'];
//     placedAt = json['placed_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_id'] = this.orderId;
//     data['item_total'] = this.itemTotal;
//     data['tax'] = this.tax;
//     data['service_charge'] = this.serviceCharge;
//     data['delivery_charges'] = this.deliveryCharges;
//     data['min_order_charge'] = this.minOrderCharge;
//     data['tip_amount'] = this.tipAmount;
//     data['delivery_time'] = this.deliveryTime;
//     data['special_requets'] = this.specialRequets;
//     data['packing_fee'] = this.packingFee;
//     data['delivery_type'] = this.deliveryType;
//     data['min_order_charge'] = this.minOrderCharge;
//     if (this.couponDiscount != null) {
//       data['coupon_discount'] = this.couponDiscount!.toJson();
//     }
//     data['grand_total'] = this.grandTotal;
//     data['instruction_for_delivery'] = this.instructionForDelivery;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.vendor != null) {
//       data['vendor'] = this.vendor!.toJson();
//     }
//     if (this.driver != null) {
//       data['driver'] = this.driver!.toJson();
//     }
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     data['order_type'] = this.orderType;
//     data['delivery_status'] = this.deliveryStatus;
//     data['feedback'] = this.feedback;
//     if (this.orderItems != null) {
//       data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
//     }
//     data['placed_at'] = this.placedAt;
//     return data;
//   }
// }
// class CouponDiscount {
//   dynamic id;
//   dynamic userId;
//   dynamic couponCode;
//   dynamic discountType;
//   dynamic discountedPrice;
//   dynamic createdAt;
//   dynamic updatedAt;
//
//   CouponDiscount(
//       {this.id,
//         this.userId,
//         this.couponCode,
//         this.discountType,
//         this.discountedPrice,
//         this.createdAt,
//         this.updatedAt});
//
//   CouponDiscount.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     couponCode = json['coupon_code'];
//     discountType = json['discount_type'];
//     discountedPrice = json['discounted_price'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['coupon_code'] = this.couponCode;
//     data['discount_type'] = this.discountType;
//     data['discounted_price'] = this.discountedPrice;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class User {
//   dynamic id;
//   bool? isDriver;
//   bool? isVendor;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic location;
//   dynamic name;
//   dynamic lastName;
//   dynamic email;
//   dynamic phone;
//   dynamic walletBalance;
//   dynamic earnedBalance;
//   dynamic profileImage;
//   dynamic referalCode;
//   bool? isDriverOnline;
//   bool? isVendorOnline;
//   int? deliveryRange;
//   bool? selfDelivery;
//   bool? asDriverVerified;
//   bool? asVendorVerified;
//   bool? isProfileComplete;
//
//   User(
//       {this.id,
//         this.isDriver,
//         this.isVendor,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.name,
//         this.lastName,
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
//         this.isProfileComplete});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isDriver = json['is_driver'];
//     isVendor = json['is_vendor'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     name = json['name'];
//     lastName = json['last_name'];
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
//     isProfileComplete = json['is_profile_complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['is_driver'] = this.isDriver;
//     data['is_vendor'] = this.isVendor;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['location'] = this.location;
//     data['name'] = this.name;
//     data['last_name'] = this.lastName;
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
//     data['is_profile_complete'] = this.isProfileComplete;
//     return data;
//   }
// }
//
// class Driver {
//   dynamic driverId;
//   dynamic dob;
//   dynamic name;
//   dynamic phone;
//   dynamic ppsNo;
//   dynamic vehicleType;
//   dynamic address;
//   dynamic vehicleName;
//   dynamic vehicleModel;
//   dynamic vehicleMake;
//   dynamic vehicleColor;
//   dynamic ppsCardImage;
//   dynamic licenceFrontImage;
//   dynamic licenceBackImage;
//
//   Driver(
//       {this.driverId,
//         this.dob,
//         this.name,
//         this.phone,
//         this.ppsNo,
//         this.vehicleType,
//         this.address,
//         this.vehicleName,
//         this.vehicleModel,
//         this.vehicleMake,
//         this.vehicleColor,
//         this.ppsCardImage,
//         this.licenceFrontImage,
//         this.licenceBackImage});
//
//   Driver.fromJson(Map<String, dynamic> json) {
//     driverId = json['driverId'];
//     dob = json['dob'];
//     name = json['name'];
//     phone = json['phone'];
//     ppsNo = json['pps_no'];
//     vehicleType = json['vehicle_type'];
//     address = json['address'];
//     vehicleName = json['vehicle_name'];
//     vehicleModel = json['vehicle_model'];
//     vehicleMake = json['vehicle_make'];
//     vehicleColor = json['vehicle_color'];
//     ppsCardImage = json['pps_card_image'];
//     licenceFrontImage = json['licence_front_image'];
//     licenceBackImage = json['licence_back_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['driverId'] = this.driverId;
//     data['dob'] = this.dob;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['pps_no'] = this.ppsNo;
//     data['vehicle_type'] = this.vehicleType;
//     data['address'] = this.address;
//     data['vehicle_name'] = this.vehicleName;
//     data['vehicle_model'] = this.vehicleModel;
//     data['vehicle_make'] = this.vehicleMake;
//     data['vehicle_color'] = this.vehicleColor;
//     data['pps_card_image'] = this.ppsCardImage;
//     data['licence_front_image'] = this.licenceFrontImage;
//     data['licence_back_image'] = this.licenceBackImage;
//     return data;
//   }
// }
//
// class Vendor {
//   dynamic storeId;
//   dynamic id;
//   dynamic storeName;
//   dynamic number;
//   dynamic ppsNo;
//   dynamic category;
//   dynamic secondarycategory;
//   dynamic tertiarycategory;
//   dynamic collection;
//   dynamic phone;
//   dynamic storeImage;
//   dynamic location;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic deliveryRange;
//   dynamic ppsCardImage;
//   dynamic remark;
//   bool? status;
//
//   Vendor(
//       {this.storeId,
//         this.id,
//         this.storeName,
//         this.number,
//         this.ppsNo,
//         this.category,
//         this.secondarycategory,
//         this.tertiarycategory,
//         this.collection,
//         this.phone,
//         this.storeImage,
//         this.location,
//         this.latitude,
//         this.longitude,
//         this.deliveryRange,
//         this.ppsCardImage,
//         this.remark,
//         this.status});
//
//   Vendor.fromJson(Map<String, dynamic> json) {
//     storeId = json['storeId'];
//     id = json['id'];
//     storeName = json['store_name'];
//     number = json['number'];
//     ppsNo = json['pps_no'];
//     category = json['category'];
//     secondarycategory = json['secondarycategory'];
//     tertiarycategory = json['tertiarycategory'];
//     collection = json['collection'];
//     phone = json['phone'];
//     storeImage = json['storeImage'];
//     location = json['location'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     deliveryRange = json['delivery_range'];
//     ppsCardImage = json['pps_card_image'];
//     remark = json['remark'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['storeId'] = this.storeId;
//     data['id'] = this.id;
//     data['store_name'] = this.storeName;
//     data['number'] = this.number;
//     data['pps_no'] = this.ppsNo;
//     data['category'] = this.category;
//     data['secondarycategory'] = this.secondarycategory;
//     data['tertiarycategory'] = this.tertiarycategory;
//     data['collection'] = this.collection;
//     data['phone'] = this.phone;
//     data['storeImage'] = this.storeImage;
//     data['location'] = this.location;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['delivery_range'] = this.deliveryRange;
//     data['pps_card_image'] = this.ppsCardImage;
//     data['remark'] = this.remark;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
class Location {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic landmark;
  dynamic addressType;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Location(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.landmark,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['flat_no'] = flatNo;
    data['landmark'] = landmark;
    data['address_type'] = addressType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
