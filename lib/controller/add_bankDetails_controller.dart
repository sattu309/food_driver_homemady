import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/vendor_bank_details.dart';
import '../repository/vendor_bank_details_repo.dart';


class VendorBankDetailsController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorBankDetailsModel> bankDetailsModel = VendorBankDetailsModel().obs;

  final TextEditingController bankAccountNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController iFSCCode = TextEditingController();
  final TextEditingController bankController = TextEditingController();

  Future getVendorBankDetails() async {
    isDataLoading = false.obs;
    await vendorBankDetailsRepo().then((value) {
      isDataLoading = true.obs;
      bankDetailsModel.value = value;
    });
  }
}