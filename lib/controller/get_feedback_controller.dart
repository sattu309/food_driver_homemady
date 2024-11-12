import 'package:get/get.dart';
import '../models/get_ratingModel.dart';
import '../repository/getRating_repo.dart';

class GetFeedbackController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<RatingModel> model = RatingModel().obs;
  RxString driverId = "".obs;

  getData() async {
    isDataLoading.value = false;
    getRatingRepo(driverId: driverId).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
