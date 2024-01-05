import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/booking_details/booking_details_repo/booking_details_repo.dart';

class BookingController extends GetxController{
  BookingRepo bookingRepo;
  BookingController({required this.bookingRepo});

  Future deleteResidenceResult({required String id}) async {
    ApiResponseModel responseModel = await bookingRepo.deleteResidence(id: id);

    if (responseModel.statusCode == 201) {
      Utils.toastMessageCenter(responseModel.message);
      Get.offAndToNamed(AppRoute.homeScreen);
    } else {
      Utils.toastMessageCenter(responseModel.message);
    }
  }

}