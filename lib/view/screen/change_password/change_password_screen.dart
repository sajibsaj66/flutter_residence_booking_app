import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/change_password/change_password_controller/change_password_controller.dart';
import 'package:resid_plus_user/view/screen/change_password/change_password_repo/change_password_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ChangePasswordRepo(apiService: Get.find()));
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false, bottom: false,
      child: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: AppColors.black5,
              appBar: CustomAppBar(
                appBarContent: GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "changePassword".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          title: "Current Password",
                          hintText: "Enter password",
                          prefixSvgIcon: "",
                          controller: controller.currentPasswordController,
                          isPassword: true,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Password Not Be Empty";
                            } else if (value.length < 8) {
                              return "Please use 8 characters long password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          title: "New Password",
                          hintText: "Enter New Password",
                          prefixSvgIcon: "",
                          controller: controller.newPasswordController,
                          isPassword: true,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Password Not Be Empty";
                            } else if (value.length < 8) {
                              return "Please use 8 characters long password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          title: "Confirm New Password",
                          hintText: "Confirm new password",
                          prefixSvgIcon: "",
                          controller: controller.confirmPasswordController,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Password Not Be Empty";
                            } else if (value.length < 6) {
                              return "Please use 8 characters long password";
                            } else if (controller.confirmPasswordController.text != controller.newPasswordController.text) {
                              return "Passwords did not match";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
                child: CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.changeUserPassword();
                    }
                  },
                  title: 'Continue',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
