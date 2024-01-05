import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/auth/reset_password/reset_password_controller/reset_password_controller.dart';
import 'package:resid_plus_user/view/screen/auth/reset_password/reset_password_repo/reset_password_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final otpFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ResetPasswordRepo(apiService: Get.find()));
    Get.put(ResetPasswordController(resetPasswordRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ResetPasswordController>(
      builder: (controller) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: otpFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Scaffold(
              backgroundColor: AppColors.black5,
              appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 64),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 24),
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () => Get.offAndToNamed(AppRoute.forgetPasswordScreen),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "Reset Password",
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 46),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your password must have 8-10 characters.",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackPrimary),
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            title: "New Password",
                            hintText: "Enter your new Password",
                            prefixSvgIcon: "",
                            controller: controller.passwordController,
                            textInputAction: TextInputAction.next,
                            isPassword: true,
                            validator: (value){
                              if(value.isEmpty){
                                return "Please enter your password";
                              } else if(controller.passwordController.text != controller.confirmPasswordController.text){
                                return "Password doesn't match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            title: "Confirm Password",
                            hintText: "Confirm Your Password",
                            prefixSvgIcon: "",
                            controller: controller.confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            isPassword: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your password";
                              } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(controller.passwordController.text)) {
                                return "Please use uppercase,lowercase,spacial character and number";
                              } else if (value.length < 8) {
                                return "Please use 8 character long password";
                              }
                              else if(controller.passwordController.value != controller.confirmPasswordController.value){
                                return "Password does not match!";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24.0, left: 20, right: 20),
                child: controller.isSubmit?const Center(child: CircularProgressIndicator())
                    : CustomButton(
                  onTap: (){
                    if(otpFormKey.currentState!.validate()){
                      controller.forgetPassword();
                    }
                  },
                  title: 'Reset',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
