import 'package:get/get.dart';
import '../models/bank_list_model.dart';
import '../repository/bank_list_repo.dart';

class VendorBankListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorBankListModel> bankListModel = VendorBankListModel().obs;

  Future getVendorBankListDetails() async {
    isDataLoading.value = false;
    await vendorBankListRepo().then((value) {
      isDataLoading.value = true;
      bankListModel.value = value;
    });
  }
}