import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../repository/notificatoin_repo.dart';

class NotificationController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<NotificationModel> model = NotificationModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    notificationRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
