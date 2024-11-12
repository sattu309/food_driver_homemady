class orderDetailsModel {
  bool? status;
  String? message;
  Data? data;
  OrderDetail? orderDetail;
  String vendorID ="";

  orderDetailsModel({this.status, this.message, this.data});

  orderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String vendorId = "";
  dynamic orderId;
  dynamic itemTotal;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic couponDiscount;
  dynamic grandTotal;
  dynamic tipAmount;
  User? user;
  Vendor? vendor;
  User? driver;
  Address? address;
  String? orderType;
  String? deliveryStatus;
  List<OrderItems>? orderItems;
  String? placedAt;

  Data(
      {this.orderId,
        this.itemTotal,
        this.tax,
        this.deliveryCharges,
        this.packingFee,
        this.couponDiscount,
        this.grandTotal,
        this.user,
        this.tipAmount,
        this.vendor,
        this.driver,
        this.address,
        this.orderType,
        this.deliveryStatus,
        this.orderItems,
        this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    tipAmount = json['tip_amount'];
    couponDiscount = json['coupon_discount'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    driver = json['driver'] != null ? User.fromJson(json['driver']) : null;
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['item_total'] = itemTotal;
    data['tip_amount'] = tipAmount;
    data['tax'] = tax;
    data['delivery_charges'] = deliveryCharges;
    data['packing_fee'] = packingFee;
    data['coupon_discount'] = couponDiscount;
    data['grand_total'] = grandTotal;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_status'] = deliveryStatus;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = placedAt;
    return data;
  }
}

class User {
  dynamic id;
  bool? isDriver;
  bool? isVendor;
  String? latitude;
  String? longitude;
  String? location;
  String? name;
  String? lastName;
  String? email;
  String? phone;
  String? walletBalance;
  String? earnedBalance;
  String? profileImage;
  String? referalCode;
  bool? isDriverOnline;
  bool? isVendorOnline;
  dynamic deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? isProfileComplete;

  User(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.latitude,
        this.longitude,
        this.location,
        this.name,
        this.lastName,
        this.email,
        this.phone,
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
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
    data['phone'] = phone;
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
class OrderDetail {

  String vendorID ="";
  dynamic orderId;
  dynamic itemTotal;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic tipAmount;
  dynamic serviceCharge;
  dynamic grandTotal;
  dynamic deliveryType;
  dynamic minOrderCharge;
  dynamic specialRequets;
  dynamic deliveryTime;
  dynamic instructionForDelivery;
  User? user;
  Vendor? vendor;
  Driver? driver;
  dynamic address;
  dynamic orderType;
  dynamic deliveryStatus;
  dynamic feedback;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  OrderDetail(
      {this.orderId,
        this.itemTotal,
        this.tax,
        this.deliveryCharges,
        this.tipAmount,
        this.packingFee,

        this.grandTotal,
        this.deliveryType,
        this.minOrderCharge,
        this.user,
        this.vendor,
        this.specialRequets,
        this.serviceCharge,
        this.driver,
        this.address,
        this.deliveryTime,
        this.instructionForDelivery,
        this.orderType,
        this.deliveryStatus,
        this.feedback,
        this.orderItems,
        this.placedAt});

  OrderDetail.fromJson(Map<dynamic, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    tipAmount = json['tip_amount'];
    deliveryType = json['delivery_type'];
    minOrderCharge = json['min_order_charge'];
    deliveryTime = json['delivery_time'];
    packingFee = json['packing_fee'];
    minOrderCharge = json['min_order_charge'];
    serviceCharge = json['service_charge'];
    specialRequets = json['special_requets'];
    instructionForDelivery = json['instruction_for_delivery'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    user = json['driver'] != null ? User.fromJson(json['driver']) : null;
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    feedback = json['feedback'];
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['item_total'] = itemTotal;
    data['tax'] = tax;
    data['service_charge'] = serviceCharge;
    data['delivery_charges'] = deliveryCharges;
    data['min_order_charge'] = minOrderCharge;
    data['tip_amount'] = tipAmount;
    data['delivery_time'] = deliveryTime;
    data['special_requets'] = specialRequets;
    data['packing_fee'] = packingFee;
    data['delivery_type'] = deliveryType;
    data['min_order_charge'] = minOrderCharge;

    data['grand_total'] = grandTotal;
    data['instruction_for_delivery'] = instructionForDelivery;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_status'] = deliveryStatus;
    data['feedback'] = feedback;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = placedAt;
    return data;
  }
}
class Driver {
  dynamic driverId;
  dynamic dob;
  dynamic name;
  dynamic phone;
  dynamic ppsNo;
  dynamic vehicleType;
  dynamic address;
  dynamic vehicleName;
  dynamic vehicleModel;
  dynamic vehicleMake;
  dynamic vehicleColor;
  dynamic ppsCardImage;
  dynamic licenceFrontImage;
  dynamic licenceBackImage;

  Driver(
      {this.driverId,
        this.dob,
        this.name,
        this.phone,
        this.ppsNo,
        this.vehicleType,
        this.address,
        this.vehicleName,
        this.vehicleModel,
        this.vehicleMake,
        this.vehicleColor,
        this.ppsCardImage,
        this.licenceFrontImage,
        this.licenceBackImage});

  Driver.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    dob = json['dob'];
    name = json['name'];
    phone = json['phone'];
    ppsNo = json['pps_no'];
    vehicleType = json['vehicle_type'];
    address = json['address'];
    vehicleName = json['vehicle_name'];
    vehicleModel = json['vehicle_model'];
    vehicleMake = json['vehicle_make'];
    vehicleColor = json['vehicle_color'];
    ppsCardImage = json['pps_card_image'];
    licenceFrontImage = json['licence_front_image'];
    licenceBackImage = json['licence_back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driverId'] = driverId;
    data['dob'] = dob;
    data['name'] = name;
    data['phone'] = phone;
    data['pps_no'] = ppsNo;
    data['vehicle_type'] = vehicleType;
    data['address'] = address;
    data['vehicle_name'] = vehicleName;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_make'] = vehicleMake;
    data['vehicle_color'] = vehicleColor;
    data['pps_card_image'] = ppsCardImage;
    data['licence_front_image'] = licenceFrontImage;
    data['licence_back_image'] = licenceBackImage;
    return data;
  }
}

class Vendor {
  dynamic storeId;
  dynamic id;
  String? storeName;
  String? number;
  String? ppsNo;
  dynamic category;
  dynamic secondarycategory;
  dynamic tertiarycategory;
  dynamic collection;
  String? phone;
  String? storeImage;
  String? location;
  String? latitude;
  String? longitude;
  String? deliveryRange;
  String? ppsCardImage;
  String? remark;
  bool? status;

  Vendor(
      {this.storeId,
        this.id,
        this.storeName,
        this.number,
        this.ppsNo,
        this.category,
        this.secondarycategory,
        this.tertiarycategory,
        this.collection,
        this.phone,
        this.storeImage,
        this.location,
        this.latitude,
        this.longitude,
        this.deliveryRange,
        this.ppsCardImage,
        this.remark,
        this.status});

  Vendor.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    id = json['id'];
    storeName = json['store_name'];
    number = json['number'];
    ppsNo = json['pps_no'];
    category = json['category'];
    secondarycategory = json['secondarycategory'];
    tertiarycategory = json['tertiarycategory'];
    collection = json['collection'];
    phone = json['phone'];
    storeImage = json['storeImage'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryRange = json['delivery_range'];
    ppsCardImage = json['pps_card_image'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = storeId;
    data['id'] = id;
    data['store_name'] = storeName;
    data['number'] = number;
    data['pps_no'] = ppsNo;
    data['category'] = category;
    data['secondarycategory'] = secondarycategory;
    data['tertiarycategory'] = tertiarycategory;
    data['collection'] = collection;
    data['phone'] = phone;
    data['storeImage'] = storeImage;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['delivery_range'] = deliveryRange;
    data['pps_card_image'] = ppsCardImage;
    data['remark'] = remark;
    data['status'] = status;
    return data;
  }
}

class Address {
  dynamic id;
  dynamic userId;
  String? latitude;
  String? longitude;
  String? location;
  String? flatNo;
  String? landmark;
  dynamic note;
  dynamic pinCode;
  String? addressType;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Address(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.landmark,
        this.note,
        this.pinCode,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    landmark = json['landmark'];
    note = json['note'];
    pinCode = json['pin_code'];
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
    data['note'] = note;
    data['pin_code'] = pinCode;
    data['address_type'] = addressType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class OrderItems {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic price;
  dynamic qty;
  dynamic sizeQuantity;
  dynamic sizeId;
  dynamic totalPrice;
  String? status;
  dynamic specialRequets;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.price,
        this.qty,
        this.sizeQuantity,
        this.sizeId,
        this.totalPrice,
        this.status,
        this.specialRequets});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    qty = json['qty'];
    sizeQuantity = json['size_quantity'];
    sizeId = json['size_id'];
    totalPrice = json['total_price'];
    status = json['status'];
    specialRequets = json['special_requets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['product_name'] = productName;
    data['price'] = price;
    data['size_quantity'] = sizeQuantity;
    data['size_id'] = sizeId;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['special_requets'] = specialRequets;
    return data;
  }
}
