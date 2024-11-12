import 'package:get/get.dart';
import '../models/privacy_policy.dart';
import '../repository/privacy_policy_repo.dart';

class PrivacyController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<PrivacyPolicyModel> model = PrivacyPolicyModel().obs;
  RxString slug = "".obs;

  getData() async {
    isDataLoading.value = false;
    privacyPolicyData(slug: slug).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
}