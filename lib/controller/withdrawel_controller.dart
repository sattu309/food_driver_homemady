import 'package:get/get.dart';

import '../models/withdraw_money_controller.dart';
import '../repository/withdraw_money_repo.dart';


class WithdrawalListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<WithdrawalListModel> model = WithdrawalListModel().obs;

  getWithdrawalList() {
    myWithdrawalListRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}