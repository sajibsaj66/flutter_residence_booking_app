import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/about_us/about_us_controller/about_us_controller.dart';
import 'package:resid_plus_user/view/screen/about_us/about_us_model/about_us_model.dart';
import 'package:resid_plus_user/view/screen/about_us/about_us_repo/about_us_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(AboutUsRepo(apiService: Get.find()));
    Get.put(AboutUsController(aboutUsRepo: Get.find()));
    DeviceUtils.innerUtils();
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
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarContent: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                const SizedBox(width: 8),
                Text(
                  "aboutUs".tr,
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
        body: GetBuilder<AboutUsController>(
          builder: (controller) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  FutureBuilder<AboutUsModel>(
                future: controller.aboutUs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator()); // Show a loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}"); // Show an error message if data fetch fails
                  } else if (!snapshot.hasData) {
                    return const Text("No data available"); // Handle case where no data is available
                  }
                  AboutUsModel aboutUsModel = snapshot.data!;
                  return  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Html(data: aboutUsModel.data?.attributes?.content.toString() ?? "Admin Not Added Any About Us Information"),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
