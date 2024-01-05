import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'inner_widget/all_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState() {
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 24, bottom: 0),
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "settings".tr,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF333333),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AllSetings(onTap: ()=>Get.toNamed(AppRoute.changePasswordScreen), text: "changePassword".tr),
              SizedBox(height: 8.h),
              AllSetings(onTap: () => Get.toNamed(AppRoute.faqScreen),text: "FAQ".tr),
              SizedBox(height: 8.h),
              AllSetings(onTap: ()=> Get.toNamed(AppRoute.languageChange), text: "Language Change".tr),
              SizedBox(height: 8.h),
              AllSetings(onTap: ()=> Get.toNamed(AppRoute.privacyScreen), text: "Privacy Policy".tr),
              SizedBox(height: 8.h),
              AllSetings(onTap: ()=> Get.toNamed(AppRoute.termsScreen) , text: "termsServices".tr),
            ],
          ),
        ),
      ),
    );
  }
}
