// class MyOrdersDetailsModel {
//   bool? status;
//   dynamic message;
//   Data? data;
//
//   MyOrdersDetailsModel({this.status, this.message, this.data});
//
//   MyOrdersDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic orderId;
//   dynamic itemTotal;
//   dynamic deliveryCharges;
//   dynamic walletSaving;
//   dynamic couponDiscount;
//   dynamic commissionDriver;
//   dynamic commissionAdmin;
//   dynamic grandTotal;
//   User? user;
//   Vendor? vendor;
//   dynamic driver;
//   dynamic address;
//   dynamic orderType;
//   dynamic paymentType;
//   dynamic deliveryStatus;
//   List<OrderItems>? orderItems;
//   dynamic placedAt;
//
//   Data(
//       {this.orderId,
//         this.itemTotal,
//         this.deliveryCharges,
//         this.walletSaving,
//         this.couponDiscount,
//         this.commissionDriver,
//         this.commissionAdmin,
//         this.grandTotal,
//         this.user,
//         this.vendor,
//         this.driver,
//         this.address,
//         this.orderType,
//         this.paymentType,
//         this.deliveryStatus,
//         this.orderItems,
//         this.placedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     itemTotal = json['item_total'];
//     deliveryCharges = json['delivery_charges'];
//     walletSaving = json['wallet_saving'];
//     couponDiscount = json['coupon_discount'];
//     commissionDriver = json['commission_driver'];
//     commissionAdmin = json['commission_admin'];
//     grandTotal = json['grand_total'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     vendor =
//     json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
//     driver = json['driver'];
//     address = json['address'];
//     orderType = json['order_type'];
//     paymentType = json['payment_type'];
//     deliveryStatus = json['delivery_status'];
//     if (json['order_items'] != null) {
//       orderItems = <OrderItems>[];
//       json['order_items'].forEach((v) {
//         orderItems!.add(new OrderItems.fromJson(v));
//       });
//     }
//     placedAt = json['placed_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_id'] = this.orderId;
//     data['item_total'] = this.itemTotal;
//     data['delivery_charges'] = this.deliveryCharges;
//     data['wallet_saving'] = this.walletSaving;
//     data['coupon_discount'] = this.couponDiscount;
//     data['commission_driver'] = this.commissionDriver;
//     data['commission_admin'] = this.commissionAdmin;
//     data['grand_total'] = this.grandTotal;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.vendor != null) {
//       data['vendor'] = this.vendor!.toJson();
//     }
//     data['driver'] = this.driver;
//     data['address'] = this.address;
//     data['order_type'] = this.orderType;
//     data['payment_type'] = this.paymentType;
//     data['delivery_status'] = this.deliveryStatus;
//     if (this.orderItems != null) {
//       data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
//     }
//     data['placed_at'] = this.placedAt;
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
//   dynamic firstName;
//   dynamic lastName;
//   dynamic name;
//   dynamic email;
//   dynamic phone;
//   dynamic earnedBalance;
//   dynamic profileImage;
//   bool? isDriverOnline;
//   bool? isVendorOnline;
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
//         this.firstName,
//         this.lastName,
//         this.name,
//         this.email,
//         this.phone,
//         this.earnedBalance,
//         this.profileImage,
//         this.isDriverOnline,
//         this.isVendorOnline,
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
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     earnedBalance = json['earned_balance'];
//     profileImage = json['profile_image'];
//     isDriverOnline = json['is_driver_online'];
//     isVendorOnline = json['is_vendor_online'];
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
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['earned_balance'] = this.earnedBalance;
//     data['profile_image'] = this.profileImage;
//     data['is_driver_online'] = this.isDriverOnline;
//     data['is_vendor_online'] = this.isVendorOnline;
//     data['self_delivery'] = this.selfDelivery;
//     data['as_driver_verified'] = this.asDriverVerified;
//     data['as_vendor_verified'] = this.asVendorVerified;
//     data['is_profile_complete'] = this.isProfileComplete;
//     return data;
//   }
// }
//
// class Vendor {
//   dynamic storeId;
//   dynamic id;
//   dynamic storeName;
//   dynamic phone;
//   dynamic businessId;
//   dynamic latitude;
//   dynamic longitude;
//   List<int>? storeCategory;
//   dynamic storeImage;
//   dynamic businessIdImage;
//   dynamic remark;
//   bool? status;
//
//   Vendor(
//       {this.storeId,
//         this.id,
//         this.storeName,
//         this.phone,
//         this.businessId,
//         this.latitude,
//         this.longitude,
//         this.storeCategory,
//         this.storeImage,
//         this.businessIdImage,
//         this.remark,
//         this.status});
//
//   Vendor.fromJson(Map<String, dynamic> json) {
//     storeId = json['storeId'];
//     id = json['id'];
//     storeName = json['store_name'];
//     phone = json['phone'];
//     businessId = json['businessId'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     storeCategory = json['store_category'].cast<int>();
//     storeImage = json['storeImage'];
//     businessIdImage = json['business_id_image'];
//     remark = json['remark'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['storeId'] = this.storeId;
//     data['id'] = this.id;
//     data['store_name'] = this.storeName;
//     data['phone'] = this.phone;
//     data['businessId'] = this.businessId;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['store_category'] = this.storeCategory;
//     data['storeImage'] = this.storeImage;
//     data['business_id_image'] = this.businessIdImage;
//     data['remark'] = this.remark;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class OrderItems {
//   dynamic id;
//   dynamic productId;
//   dynamic productName;
//   dynamic variantId;
//   dynamic price;
//   List<Addons>? addons;
//   dynamic qty;
//   dynamic totalPrice;
//   dynamic note;
//   dynamic status;
//
//   OrderItems(
//       {this.id,
//         this.productId,
//         this.productName,
//         this.variantId,
//         this.price,
//         this.addons,
//         this.qty,
//         this.totalPrice,
//         this.note,
//         this.status});
//
//   OrderItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     productName = json['product_name'];
//     variantId = json['variant_id'];
//     price = json['price'];
//     if (json['addons'] != null) {
//       addons = <Addons>[];
//       json['addons'].forEach((v) {
//         addons!.add(new Addons.fromJson(v));
//       });
//     }
//     qty = json['qty'];
//     totalPrice = json['total_price'];
//     note = json['note'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['product_name'] = this.productName;
//     data['variant_id'] = this.variantId;
//     data['price'] = this.price;
//     if (this.addons != null) {
//       data['addons'] = this.addons!.map((v) => v.toJson()).toList();
//     }
//     data['qty'] = this.qty;
//     data['total_price'] = this.totalPrice;
//     data['note'] = this.note;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class Addons {
//   dynamic id;
//   dynamic title;
//   dynamic name;
//   dynamic calories;
//   dynamic price;
//   bool? multiSelect;
//
//   Addons(
//       {this.id,
//         this.title,
//         this.name,
//         this.calories,
//         this.price,
//         this.multiSelect});
//
//   Addons.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     name = json['name'];
//     calories = json['calories'];
//     price = json['price'];
//     multiSelect = json['multi_select'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['name'] = this.name;
//     data['calories'] = this.calories;
//     data['price'] = this.price;
//     data['multi_select'] = this.multiSelect;
//     return data;
//   }
// }
//
//
//
//
// class MyOrdersDetailsModel {
//   bool? status;
//   dynamic message;
//   Data? data;
//
//   MyOrdersDetailsModel({this.status, this.message, this.data});
//
//   MyOrdersDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic orderId;
//   dynamic itemTotal;
//   dynamic deliveryCharges;
//   dynamic walletSaving;
//   dynamic couponDiscount;
//   dynamic commissionDriver;
//   dynamic commissionAdmin;
//   dynamic grandTotal;
//   User? user;
//   Vendor? vendor;
//   User? driver;
//   dynamic address;
//   dynamic orderType;
//   dynamic paymentType;
//   dynamic deliveryStatus;
//   List<OrderItems>? orderItems;
//   dynamic placedAt;
//
//   Data(
//       {this.orderId,
//         this.itemTotal,
//         this.deliveryCharges,
//         this.walletSaving,
//         this.couponDiscount,
//         this.commissionDriver,
//         this.commissionAdmin,
//         this.grandTotal,
//         this.user,
//         this.vendor,
//         this.driver,
//         this.address,
//         this.orderType,
//         this.paymentType,
//         this.deliveryStatus,
//         this.orderItems,
//         this.placedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     itemTotal = json['item_total'];
//     deliveryCharges = json['delivery_charges'];
//     walletSaving = json['wallet_saving'];
//     couponDiscount = json['coupon_discount'];
//     commissionDriver = json['commission_driver'];
//     commissionAdmin = json['commission_admin'];
//     grandTotal = json['grand_total'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     vendor =
//     json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
//     driver = json['driver'] != null ? new User.fromJson(json['driver']) : null;
//     address =
//     json['address'] != null ? new Address.fromJson(json['address']) : null;
//     orderType = json['order_type'];
//     paymentType = json['payment_type'];
//     deliveryStatus = json['delivery_status'];
//     if (json['order_items'] != null) {
//       orderItems = <OrderItems>[];
//       json['order_items'].forEach((v) {
//         orderItems!.add(new OrderItems.fromJson(v));
//       });
//     }
//     placedAt = json['placed_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_id'] = this.orderId;
//     data['item_total'] = this.itemTotal;
//     data['delivery_charges'] = this.deliveryCharges;
//     data['wallet_saving'] = this.walletSaving;
//     data['coupon_discount'] = this.couponDiscount;
//     data['commission_driver'] = this.commissionDriver;
//     data['commission_admin'] = this.commissionAdmin;
//     data['grand_total'] = this.grandTotal;
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
//     data['payment_type'] = this.paymentType;
//     data['delivery_status'] = this.deliveryStatus;
//     if (this.orderItems != null) {
//       data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
//     }
//     data['placed_at'] = this.placedAt;
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
//   dynamic firstName;
//   dynamic lastName;
//   dynamic name;
//   dynamic email;
//   dynamic phone;
//   dynamic earnedBalance;
//   dynamic profileImage;
//   bool? isDriverOnline;
//   bool? isVendorOnline;
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
//         this.firstName,
//         this.lastName,
//         this.name,
//         this.email,
//         this.phone,
//         this.earnedBalance,
//         this.profileImage,
//         this.isDriverOnline,
//         this.isVendorOnline,
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
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     earnedBalance = json['earned_balance'];
//     profileImage = json['profile_image'];
//     isDriverOnline = json['is_driver_online'];
//     isVendorOnline = json['is_vendor_online'];
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
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['earned_balance'] = this.earnedBalance;
//     data['profile_image'] = this.profileImage;
//     data['is_driver_online'] = this.isDriverOnline;
//     data['is_vendor_online'] = this.isVendorOnline;
//     data['self_delivery'] = this.selfDelivery;
//     data['as_driver_verified'] = this.asDriverVerified;
//     data['as_vendor_verified'] = this.asVendorVerified;
//     data['is_profile_complete'] = this.isProfileComplete;
//     return data;
//   }
// }
//
// class Vendor {
//   dynamic storeId;
//   dynamic id;
//   dynamic storeName;
//   dynamic phone;
//   dynamic businessId;
//   dynamic latitude;
//   dynamic longitude;
//   // List<int>? storeCategory;
//   dynamic storeImage;
//   dynamic businessIdImage;
//   dynamic remark;
//   bool? status;
//
//   Vendor(
//       {this.storeId,
//         this.id,
//         this.storeName,
//         this.phone,
//         this.businessId,
//         this.latitude,
//         this.longitude,
//         // this.storeCategory,
//         this.storeImage,
//         this.businessIdImage,
//         this.remark,
//         this.status});
//
//   Vendor.fromJson(Map<String, dynamic> json) {
//     storeId = json['storeId'];
//     id = json['id'];
//     storeName = json['store_name'];
//     phone = json['phone'];
//     businessId = json['businessId'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     // storeCategory = json['store_category'].cast<int>();
//     storeImage = json['storeImage'];
//     businessIdImage = json['business_id_image'];
//     remark = json['remark'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['storeId'] = this.storeId;
//     data['id'] = this.id;
//     data['store_name'] = this.storeName;
//     data['phone'] = this.phone;
//     data['businessId'] = this.businessId;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     // data['store_category'] = this.storeCategory;
//     data['storeImage'] = this.storeImage;
//     data['business_id_image'] = this.businessIdImage;
//     data['remark'] = this.remark;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class Address {
//   dynamic id;
//   dynamic userId;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic location;
//   dynamic name;
//   dynamic phone;
//   dynamic image;
//   dynamic addressType;
//   bool? leaveAtDoor;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic deletedAt;
//
//   Address(
//       {this.id,
//         this.userId,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.name,
//         this.phone,
//         this.image,
//         this.addressType,
//         this.leaveAtDoor,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     name = json['name'];
//     phone = json['phone'];
//     image = json['image'];
//     addressType = json['address_type'];
//     leaveAtDoor = json['leave_at_door'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['location'] = this.location;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['image'] = this.image;
//     data['address_type'] = this.addressType;
//     data['leave_at_door'] = this.leaveAtDoor;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     return data;
//   }
// }
//
// class OrderItems {
//   dynamic id;
//   dynamic productId;
//   dynamic productName;
//   dynamic variantId;
//   dynamic price;
//   dynamic variantSize;
//   List<Addons>? addons;
//   dynamic qty;
//   dynamic totalPrice;
//   dynamic note;
//   dynamic status;
//
//   OrderItems(
//       {this.id,
//         this.productId,
//         this.productName,
//         this.variantId,
//         this.price,
//         this.variantSize,
//         this.addons,
//         this.qty,
//         this.totalPrice,
//         this.note,
//         this.status});
//
//   OrderItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     productName = json['product_name'];
//     variantId = json['variant_id'];
//     price = json['price'];
//     variantSize = json['variant_size'];
//     if (json['addons'] != null) {
//       addons = <Addons>[];
//       json['addons'].forEach((v) {
//         addons!.add(new Addons.fromJson(v));
//       });
//     }
//     qty = json['qty'];
//     totalPrice = json['total_price'];
//     note = json['note'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['product_name'] = this.productName;
//     data['variant_id'] = this.variantId;
//     data['price'] = this.price;
//     data['variant_size'] = this.variantSize;
//     if (this.addons != null) {
//       data['addons'] = this.addons!.map((v) => v.toJson()).toList();
//     }
//     data['qty'] = this.qty;
//     data['total_price'] = this.totalPrice;
//     data['note'] = this.note;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class Addons {
//   dynamic id;
//   dynamic title;
//   dynamic name;
//   dynamic calories;
//   dynamic price;
//   bool? multiSelect;
//
//   Addons(
//       {this.id,
//         this.title,
//         this.name,
//         this.calories,
//         this.price,
//         this.multiSelect});
//
//   Addons.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     name = json['name'];
//     calories = json['calories'];
//     price = json['price'];
//     multiSelect = json['multi_select'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['name'] = this.name;
//     data['calories'] = this.calories;
//     data['price'] = this.price;
//     data['multi_select'] = this.multiSelect;
//     return data;
//   }
// }

class MyOrdersDetailsModel {
  bool? status;
  dynamic message;
  OrderDetail? orderDetail;
  String vendorID ="";


  MyOrdersDetailsModel({this.status, this.message, this.orderDetail});

  MyOrdersDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetail = json['data'] != null ? OrderDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderDetail != null) {
      data['data'] = orderDetail!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  String vendorID= "";
  dynamic orderId;
  dynamic itemTotal;
  dynamic serviceCharge;
  dynamic tipAmount;
  dynamic deliveryCharges;
  dynamic couponDiscount;
  dynamic grandTotal;
  dynamic specialRequets;
  dynamic instructionForDelivery;
  User? user;
  Vendor? vendor;
  Driver? driver;
  Address? address;
  dynamic orderType;
  dynamic deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  OrderDetail(
      {this.orderId,
        this.itemTotal,
        this.serviceCharge,
        this.deliveryCharges,
        this.couponDiscount,
        this.grandTotal,
        this.tipAmount,
        this.specialRequets,
        this.instructionForDelivery,
        this.user,
        this.vendor,
        this.driver,
        this.address,
        this.orderType,
        this.deliveryStatus,
        this.orderItems,
        this.placedAt});

  OrderDetail.fromJson(Map<dynamic, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    serviceCharge = json['service_charge'];
    deliveryCharges = json['delivery_charges'];
    couponDiscount = json['coupon_discount'];
    tipAmount = json['tip_amount'];
    grandTotal = json['grand_total'];
    specialRequets = json['special_requets'];
    instructionForDelivery = json['instruction_for_delivery'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    driver =
    json['driver'] != null ? Driver.fromJson(json['driver']) : null;
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
    data['service_charge'] = serviceCharge;
    data['delivery_charges'] = deliveryCharges;
    data['coupon_discount'] = couponDiscount;
    data['tip_amount'] = tipAmount;
    data['grand_total'] = grandTotal;
    data['special_requets'] = specialRequets;
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
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic name;
  dynamic lastName;
  dynamic email;
  dynamic phone;
  List<void>? defaultAddress;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic profileImage;
  dynamic referalCode;
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
    // if (json['default_address '] != null) {
    //   defaultAddress = <Null>[];
    //   json['default_address '].forEach((v) {
    //     defaultAddress!.add(new Null.fromJson(v));
    //   });
    // }
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
    // if (this.defaultAddress != null) {
    //   data['default_address '] =
    //       this.defaultAddress!.map((v) => v.toJson()).toList();
    // }
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

class Vendor {
  dynamic storeId;
  dynamic id;
  dynamic storeName;
  dynamic number;
  dynamic ppsNo;
  dynamic category;
  dynamic secondarycategory;
  dynamic tertiarycategory;
  dynamic collection;
  dynamic phone;
  dynamic storeImage;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic deliveryRange;
  dynamic ppsCardImage;
  dynamic city;
  dynamic addressType;
  dynamic pinCode;
  dynamic remark;
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
        this.city,
        this.addressType,
        this.pinCode,
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
    city = json['city'];
    addressType = json['address_type'];
    pinCode = json['pin_code'];
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
    data['city'] = city;
    data['address_type'] = addressType;
    data['pin_code'] = pinCode;
    data['remark'] = remark;
    data['status'] = status;
    return data;
  }
}

class Driver {
  dynamic driverId;
  dynamic id;
  dynamic dob;
  dynamic name;
  dynamic phone;
  dynamic ppsNo;
  dynamic vehicleType;
  dynamic profile_image;
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
        this.profile_image,
        this.id,
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
    id = json['id'];
    profile_image = json['profile_image'];
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

class Address {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic landmark;
  dynamic note;
  dynamic pinCode;
  dynamic addressType;
  dynamic createdAt;
  dynamic updatedAt;
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
  dynamic qty;
  dynamic price;
  dynamic sizeQuantity;
  dynamic sizeId;
  dynamic totalPrice;
  dynamic status;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.qty,
        this.price,
        this.sizeQuantity,
        this.sizeId,
        this.totalPrice,
        this.status});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    qty = json['qty'];
    price = json['price'];
    sizeQuantity = json['size_quantity'];
    sizeId = json['size_id'];
    totalPrice = json['total_price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['qty'] = qty;
    data['price'] = price;
    data['size_quantity'] = sizeQuantity;
    data['size_id'] = sizeId;
    data['total_price'] = totalPrice;
    data['status'] = status;
    return data;
  }
}
