import 'package:get/get.dart';
import '../models/order_details_cooks_copy_model.dart';
import '../repository/order_details_repo.dart';


class MyOrderDetailsController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<MyOrdersDetailsModel> model = MyOrdersDetailsModel().obs;

  Future getMyOrderDetails(String orderId) async {
    isDataLoading.value = false;
    await myOrderDetailsRepo(id: orderId).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}