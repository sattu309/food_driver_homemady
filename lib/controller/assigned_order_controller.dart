// import 'package:get/get.dart';
// import '../models/assigned_order_model.dart';
// import '../models/common_model.dart';
// import '../repository/assigned_order_repo.dart';
//
// class AssignedOrderController extends GetxController {
//   RxBool isDataLoading = false.obs;
//   Rx<ModelCommonResponse> model = ModelCommonResponse().obs;
//   RxString status = "".obs;
//   @override
//   void onInit() {
//     super.onInit();
//     getData();
//   }
//
//   getData() async {
//     isDataLoading.value = false;
//     assignedOrderListRepo(status: status.value).then((value) {
//       isDataLoading.value = true;
//       model.value = value;
//     });
//   }
// }