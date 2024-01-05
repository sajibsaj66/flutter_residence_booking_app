import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/profile/profile_model/profile_model.dart';
import 'package:resid_plus_user/view/screen/profile/profile_repo/profile_repo.dart';

class ProfileController extends GetxController {

  ProfileRepo profileRepo;
  ProfileController({required this.profileRepo});

  @override
  void onInit(){
    profile();
    super.onInit();
  }

  String img = "";
  ProfileModel profileModel = ProfileModel();

  bool isLoading = true;
  Future<void> profile() async {
    ApiResponseModel responseModel = await profileRepo.profileRepo();

    if(responseModel.statusCode == 200) {
      profileModel = ProfileModel.fromJson(jsonDecode(responseModel.responseJson));

      img = profileModel.data!.attributes!.user!.image!.publicFileUrl!;

      isLoading = false;
      update();
    }else {
      ProfileModel profileModel = ProfileModel.fromJson(jsonDecode(responseModel.responseJson));
      Get.snackbar("Error", profileModel.message.toString(),snackPosition: SnackPosition.BOTTOM,colorText: AppColors.bgColor,backgroundColor: AppColors.black80);
      isLoading = false;
      update();
    }
  }
}