import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/support/support_controller/support_controller.dart';
import 'package:resid_plus_user/view/screen/support/support_model/support_model.dart';
import 'package:resid_plus_user/view/screen/support/support_repo/support_repo.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SupportRepo(apiService: Get.find()));
    Get.put(SupportController(supportRepo: Get.find()));
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
                const Icon(Icons.arrow_back_ios,
                    color: AppColors.blackPrimary, size: 18),
                const SizedBox(width: 8),
                Text(
                  "support".tr,
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
        body: GetBuilder<SupportController>(
          builder: (controller) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  FutureBuilder<SupportModel>(
                future: controller.support(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show a loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Text(
                        "Error: ${snapshot.error}"); // Show an error message if data fetch fails
                  } else if (!snapshot.hasData) {
                    return const Text(
                        "No data available"); // Handle case where no data is available
                  }
                  SupportModel supportModel = snapshot.data!;
                  return  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Html(data: supportModel.data?.attributes?.content.toString() ?? "Admin Not Added Any Support Information"),
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
