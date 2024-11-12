import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/driver_Information_model.dart';
import '../repository/driver_information_repo.dart';


class DriverInformationController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<DriverInformationModel> model = DriverInformationModel().obs;
  TextEditingController dobController = TextEditingController();
  TextEditingController ppsController = TextEditingController();
  TextEditingController veyearController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController modelNameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  String address = "";
  String? dropdownvalue;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<DriverInformationModel> getData() async {
    isDataLoading.value = false;
    return await driverInformationRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
      if (isDataLoading.value &&
          model.value.data != null) {
       dobController.text =
           model.value.data!.dob.toString();
        ppsController.text =
            model.value.data!.ppsNo.toString();
        veyearController.text =
            model.value.data!.vehicleName.toString();

        makeController.text = model.value.data!.vehicleMake.toString();
        modelNameController.text = model.value.data!.vehicleModel.toString();
        colorController.text = model.value.data!.vehicleColor.toString();
        address = model.value.data!.address.toString();
        dropdownvalue = model.value.data!.vehicleType.toString();
      }
      return value;
    });
  }
}