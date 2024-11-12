import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUrl {
  static const baseUrl = "http://52.50.121.179/api/";
  static const roleUrl = "${baseUrl}roles";
  static const registrationApi = "${baseUrl}register";
  static const loginApi = "${baseUrl}login";
  static const otpApi = "${baseUrl}verify-otp";
  static const driverRegistrationApi = "${baseUrl}driver-register";
  static const forgotPassword = "${baseUrl}forget-password?email=";
  static const resetPassword = "${baseUrl}reset-password";
  static const updateLocationUrl = "${baseUrl}update-location";
  static const deshboradurl = "${baseUrl}driver-delivery-request-list";
  static const resendOtpUrl = "${baseUrl}resend-otp";
  static const privacyPolicyUrl = "${baseUrl}pages";
  static const deliveryVerifyOtpUrl = "${baseUrl}verify-delivery";
  static const vendorAddBankDetailsUrl = "${baseUrl}add-account-details";
  static const vendorBankListUrl = "${baseUrl}banks-list";
  static const resendDeliveryOtpUrl = "${baseUrl}resend-delivery-otp";
  static const vendorBankDetailsUrl = "${baseUrl}account-details";

  static const deleteUserAccount = "${baseUrl}user-delete";
  static const withdrawalListUrl = "${baseUrl}withdrawal-list";
  static const withdrawalRequestUrl = "${baseUrl}withdrawal-request";
  static const modeStatusUrl = "${baseUrl}driver-delivery-mode-update";
  static const userProfileUrl = "${baseUrl}user-profile";
  static const sendImageUrl = "${baseUrl}send-image";
  static const updateProfileUrl = "${baseUrl}update-profile";
  static const driverDeliveryModeUpdateUrl = "${baseUrl}driver-delivery-mode-update";
  static const assignedOrderListUrl = "${baseUrl}assigned-order";
  static const assignedOrderListUrl1 = "${baseUrl}assigned-order-list";
  static const myOrderDetailsUrl = "${baseUrl}order-details";
  static const resetVerifyUrl = "${baseUrl}reset-verify-otp";
  static const resetPasswordUrl = "${baseUrl}reset-password";
  static const driverOrderStatusUpdateUrl = "${baseUrl}driver-order-status-update";
  static const driverInformationUrl = "${baseUrl}driver-information";
  static const driverUpdate = "${baseUrl}driver-information-edit";
  static const socialUrl = "${baseUrl}social-login";
  static const faq = "${baseUrl}faq-list";
  static const mailToAdminUrl = "${baseUrl}request-homemady-inspection";
  static const notificationUrl = "${baseUrl}notification-list";
  static const ratingGetUrl = "${baseUrl}rating-and-review";
  static const setDeliveryLocation = "${baseUrl}set-delivery-location";
  static const paymentUrl = "${baseUrl}payment";


}

Future getAuthHeader() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // print(pref.getString("cookie")!.toString().replaceAll('"', ''));
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    if(pref.getString("cookie") != null)
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('"', '')}',
  };
}