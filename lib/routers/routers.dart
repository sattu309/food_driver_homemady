import 'package:get/get_navigation/src/routes/get_route.dart';
import '../login_signup/change_password_screen.dart';
import '../login_signup/email_verification2.dart';
import '../login_signup/email_verification_screen.dart';
import '../login_signup/login_screen.dart';
import '../login_signup/onborading_screen.dart';
import '../login_signup/otpScreen.dart';
import '../login_signup/otp_forgot.dart';
import '../login_signup/signupScreen.dart';
import '../login_signup/splash_screen.dart';
import '../screen/assigned_order.dart';
import '../screen/bank_details.dart';
import '../screen/chat_message.dart';
import '../screen/chat_screen.dart';
import '../screen/delivery_partner_apply.dart';
import '../screen/deshborad_screen.dart';
import '../screen/driver_partner_update.dart';
import '../screen/faqs_screen.dart';
import '../screen/feedback_screen.dart';
import '../screen/help_center_screen.dart';
import '../screen/myprofileScreen.dart';
import '../screen/notification_screen.dart';
import '../screen/order_accpect.dart';
import '../screen/order_decline.dart';
import '../screen/privacy_policies.dart';
import '../screen/successfull_screen.dart';
import '../screen/thank_you.dart';
import '../screen/verification_screen.dart';
import '../screen/withdraw_money.dart';



class MyRouters {
  static var splashScreen = "/splashScreen";
  static var onBoardingScreen = "/onBoardingScreen";
  static var loginScreen = "/loginScreen";
  static var signupScreen = "/signupScreen";
  static var otpScreen = "/otpScreen";
  static var emailVerificationScreen = "/emailVerificationScreen";
  static var thankYouVendorScreen = "/thankYouVendorScreen";
  static var deliveryPartnerApplyScreen = "/deliveryPartnerApplyScreen";
  static var dashbordScreen = "/dashbordScreen";
  static var assignedOrderScreen = "/assignedOrderScreen";
  static var bankDetailsScreen = "/bankDetailsScreen";
  static var driverWithdrawMoney = "/driverWithdrawMoney";
  // static var driverDeliveryOrderDetails = "/driverDeliveryOrderDetails";
  static var orderDeclineScreen = "/orderDeclineScreen";
  static var orderAccept = "/orderAccept";
  static var feedBackScreen = "/feedBackScreen";
  static var chatScreen= "/chatScreen";
  static var chatMessageScreen= "/chatMessageScreen";
  static var emailVerificationScreen2= "/emailVerificationScreen2";
  static var changePasswordScreen= "/changePasswordScreen";
  static var otpForgotScreen= "/otpForgotScreen";
  static var help_Center_Screen= "/help_Center_Screen";
  static var privacyPolicies= "/privacyPolicies";
  static var faqsScreen= "/faqsScreen";
  static var myProfileScreen= "/myProfileScreen";
  static var deliveryPartnerUpdateScreen= "/deliveryPartnerUpdateScreen";
  static var notificationScreen = "/notificationScreen";



  static var route = [
    GetPage(name: '/', page: () =>  const SplashScreen()),
    GetPage(name: '/onBoardingScreen', page: () =>  const OnBoardingScreen()),
    GetPage(name: '/loginScreen', page: () => const LoginScreen()),
    GetPage(name: '/signupScreen', page: () => const SignupScreen()),
    GetPage(name: '/otpScreen', page: () => const OtpScreen()),
    GetPage(name: '/otpScreen', page: () => const OtpScreen()),
    GetPage(name: '/emailVerificationScreen', page: () => const EmailVerificationScreen()),
    GetPage(name: '/thankYouVendorScreen', page: () => const ThankYouVendorScreen()),
    GetPage(name: '/deliveryPartnerApplyScreen', page: () => const DeliveryPartnerApplyScreen()),
    GetPage(name: '/deliveryPartnerUpdateScreen', page: () => const DeliveryPartnerUpdateScreen()),
    GetPage(name: dashbordScreen, page: () => const DashbordScreen()),
    GetPage(name: '/assignedOrderScreen', page: () => const AssignedOrderScreen()),
    GetPage(name: '/bankDetailsScreen', page: () => const BankDetailsScreen()),
    GetPage(name: '/driverWithdrawMoney', page: () => const WithdrawMoney()),
    // GetPage(name: '/driverDeliveryOrderDetails', page: () => const DriverDeliveryOrderDetails()),
    GetPage(name: '/orderDeclineScreen', page: () => const OrderDeclineScreen()),
    GetPage(name: '/orderAccept', page: () => const OrderAccept()),
    GetPage(name: '/feedBackScreen', page: () => const FeedBackScreen()),
    GetPage(name: '/chatScreen', page: () => const ChatScreen()),
    GetPage(name: '/chatMessageScreen', page: () => const ChatMessageScreen()),
    GetPage(name: '/emailVerificationScreen2', page: () => const EmailVerificationScreen2()),
    GetPage(name: '/changePasswordScreen', page: () => const ChangePasswordScreen()),
    GetPage(name: '/otpForgotScreen', page: () => const OtpForgotScreen()),
    GetPage(name: '/help_Center_Screen', page: () => const Help_Center_Screen()),
    GetPage(name: '/privacyPolicies', page: () => const PrivacyPolicies()),
    GetPage(name: '/faqsScreen', page: () => const FaqsScreen()),
    GetPage(name: '/myProfileScreen', page: () => const MyProfileScreen()),
    GetPage(name: '/notificationScreen', page: () => const NotificationScreen()),
    GetPage(name: '/deliveredSuccessfullyScreen', page: () => const DeliveredSuccessfullyScreen()),
    GetPage(name: VerifyOtpDeliveryScreen.verifyOtpDeliveryScreen, page: () => const VerifyOtpDeliveryScreen()),



  ];
}