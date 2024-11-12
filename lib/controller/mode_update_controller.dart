import 'package:get/get.dart';
import '../models/mode_update_model.dart';
import '../repository/mode_update_repo.dart';

class ModeUpdateController extends GetxController{
  Rx<ModeUpdateModel> model = ModeUpdateModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    modeUpdate().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }
}