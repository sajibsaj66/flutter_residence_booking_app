import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/change_password/change_password_repo/change_password_repo.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordRepo changePasswordRepo;
  ChangePasswordController({required this.changePasswordRepo});

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> changeUserPassword() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await changePasswordRepo.changePasswordResponse(
        currentPassword: currentPasswordController.text.trim().toString(),
        newPassword: newPasswordController.text.trim().toString()
    );
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }

    if (responseModel.statusCode == 200) {
      Get.back();
      Utils.snackBar("Successful",'Successful Update Password');
    }
    else if (responseModel.statusCode == 401){
      Utils.snackBar("Unauthorized", "Invalid Password");
    }
    else {
      final data = jsonDecode(jsonDecode(responseModel.responseJson));
      Utils.snackBar("Error",'${data['message']} Error');
    }
    isLoading = false;
    update();
  }
}
