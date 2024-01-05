import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/sign_up_repo/sign_up_repo.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_date_field.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SignUpRepo(apiService: Get.find()));
    Get.put(SignUpController(signUpRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.black5,
            appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 64),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 24, bottom: 0),
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () => Get.offAndToNamed(AppRoute.signInScreen),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios,
                            color: AppColors.blackPrimary, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "signUp".tr,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF333333),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            body: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 24, bottom: 24),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      title: "name".tr,
                      hintText: "Enter your name".tr,
                      controller: controller.fullNameController,
                      validator: (value){
                        if(value == null || value.toString().isEmpty){
                          return "Please enter your name".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: "email".tr,
                      hintText: "Enter your email".tr,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      validator: (value){
                        if(value == null || value.toString().isEmpty){
                          return "Please enter your email".tr;
                        }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.emailController.text)) {
                          return "Please enter your valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomDateField(
                      title: "dob".tr,
                      hintText: "YYYY-MM-DD",
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.dobController,
                      onTap: () => controller.pickedDateTime(context),
                      validator: (value){
                        if(value == null || value.toString().isEmpty){
                          return "Please enter your date of birth".tr;
                        }else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phone Number".tr,
                            style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackPrimary
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: controller.phoneNumberController.text.isEmpty ? const Color(0xffe2e2e2)
                                          : AppColors.blackPrimary
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.transparentColor,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.flagSouthAfrica, fit: BoxFit.contain),
                                    const SizedBox(width: 10),
                                    Text(
                                      controller.phoneCode,
                                      style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blackPrimary
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: controller.phoneNumberController,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.transparentColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE2E2E2)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE2E2E2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.blackPrimary),
                                  ),
                                  hintText: "phoneNum".tr,
                                ),
                              ),
                            )
                          ],
                        ),
                        controller.phoneNumberController.text.isEmpty
                            ?  const SizedBox() : controller.phoneNumberController.text.length < 10
                            ?  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              "*Please use valid phone number".tr,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ) : const SizedBox()
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: "address".tr,
                      hintText: "Enter your address".tr,
                      controller: controller.addressController,
                      validator: (value){
                        if(value == null || value.toString().isEmpty){
                          return "Please enter your address".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: "password".tr,
                      hintText: "Enter your Password".tr,
                      controller: controller.passwordController,
                      isPassword: true,
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter your password".tr;
                        }
                        else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(controller.passwordController.text)){
                          return "Please use uppercase,lowercase,spacial character and number";
                        }
                        else if(value.length < 8){
                          return "Please use 8 character long password".tr;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: "confirmPassword".tr,
                      hintText: "Confirm New Password".tr,
                      controller: controller.confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      isPassword: true,
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter your password".tr;
                        }
                        else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(controller.passwordController.text)){
                          return "Please use uppercase,lowercase,spacial character and number".tr;
                        }
                        else if(value.length < 8){
                          return "Please use 8 character long password".tr;
                        }
                        else if(controller.passwordController.text != controller.confirmPasswordController.text){
                          return "Password doesn't match".tr;
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, bottom: 24),
              physics: const ClampingScrollPhysics(),
              child: controller.isSubmit
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.signUpUser();
                        }
                      },
                      title: 'signUp'.tr,
                    ),
            ),
          ),
        );
      },
    );
  }
}
