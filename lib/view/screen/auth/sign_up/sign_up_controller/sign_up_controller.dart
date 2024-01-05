import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/sign_up_model/sign_up_model.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/sign_up_repo/sign_up_repo.dart';

class SignUpController extends GetxController {
  SignUpRepo signUpRepo;
  SignUpController({required this.signUpRepo});

  bool isSubmit = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String phoneCode = "+225";


  Future<void> signUpUser() async {
    isSubmit = true;
    update();
    ApiResponseModel responseModel = await signUpRepo.createUser(
        fullName: fullNameController.text.trim().toString(),
        email: emailController.text.trim().toString(),
        phoneNumber: "$phoneCode${phoneNumberController.text.trim().toString()}",
        address: addressController.text.trim().toString(),
        dateOfBirth: dobController.text.trim().toString(),
        password: confirmPasswordController.text.trim().toString());

    if (responseModel.statusCode == 201) {
      await signUpRepo.apiService.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey,emailController.text.trim().toString());
      isSubmit = false;
      update();
      Get.offAndToNamed(AppRoute.emailVerifyScreen);
    } else if (responseModel.statusCode == 503) {
      isSubmit = false;
      update();
      Utils.snackBar("Error","Internet Error");
    }else {
      SignUpErrorModel signUpModel = SignUpErrorModel.fromJson(jsonDecode(responseModel.responseJson));
      isSubmit = false;
      update();
      Utils.snackBar(signUpModel.message?[0].error??"Error","Error");
    }
  }

  String year = "";
  String month = "";
  String day = "";

  Future<void> pickedDateTime(BuildContext context) async{

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2023 + 50),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.blackPrimary, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                onSurface: AppColors.blackPrimary, // <-- SEE HERE
              ),
            ),
            child: child!
        )
    );
    if (picked != null ) {
      year = picked.year.toString();
      month = picked.month.toString();
      day = picked.day.toString();
      dobController.text = "$year-$month-$day";
      update();
    }
  }
}
