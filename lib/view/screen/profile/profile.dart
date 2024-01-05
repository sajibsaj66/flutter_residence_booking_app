import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/edit_profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:resid_plus_user/view/screen/profile/inner_widget/profile_details_card.dart';
import 'package:resid_plus_user/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus_user/view/screen/profile/profile_model/profile_model.dart';
import 'package:resid_plus_user/view/screen/profile/profile_repo/profile_repo.dart';
import 'package:resid_plus_user/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_button_with_icon.dart';
import 'package:resid_plus_user/view/widgets/image/custom_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiService: Get.find()));
    var pC = Get.put(ProfileController(profileRepo: Get.find()));
    Get.put(EditProfileController());
    pC.profile();
    DeviceUtils.bottomNavUtils();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 64),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsetsDirectional.only(
                start: 20, end: 20, top: 24, bottom: 0),
            color: Colors.transparent,
            child: Text(
              "Profile".tr,
              style: GoogleFonts.raleway(
                color: const Color(0xFF333333),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            var editingController = Get.find<EditProfileController>();
            if (controller.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            ProfileModel profileModel = controller.profileModel;
            String userImage = "${profileModel.data?.attributes?.user?.image?.publicFileUrl}";
            String userName = "${profileModel.data?.attributes?.user?.fullName}";
            String userEmail = "${profileModel.data?.attributes?.user?.email}";
            String userPhone = "${profileModel.data?.attributes?.user?.phoneNumber}";
            String userAddress = "${profileModel.data?.attributes?.user?.address}";
            String dateOfBirth = "${profileModel.data?.attributes?.user?.dateOfBirth}";

            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 24, horizontal: 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        editingController.nameController =
                            TextEditingController(text: userName);
                        editingController.numberController =
                            TextEditingController(text: userPhone);
                        editingController.addressController =
                            TextEditingController(text: userAddress);
                        Get.toNamed(AppRoute.editProfileScreen,
                            arguments: controller.profileModel);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 24, bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.black60,
                              width: 1.0,
                              style: BorderStyle.solid),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 82,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: AppColors.darkColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: userImage.isNotEmpty
                                              ? CachedNetworkImage(
                                                  imageUrl: userImage,
                                                  fit: BoxFit.fill,
                                                  height: 50,
                                                  width: 50)
                                              : const CustomImage(
                                                  imageSrc: AppIcons.profile,
                                                  imageType: ImageType.svg,
                                                  size: 50),
                                        ),
                                        /*CustomText(
                                            text: userName,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            left: 16,maxLines: 2),*/
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            userName,
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.raleway(
                                                color: AppColors.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const CustomImage(imageSrc: AppIcons.editIcon, size: 24)
                                ],
                              ),
                            ),
                            ProfileDetailsCard(
                              topText: "name".tr,
                              bottomText: userEmail,
                            ),
                            ProfileDetailsCard(
                                topText: "Mobile".tr,
                                bottomText: userPhone,
                                icon: Icons.phone),
                            ProfileDetailsCard(
                                icon: Icons.cake_outlined,
                                topText: "dob".tr,
                                bottomText: dateOfBirth),
                            ProfileDetailsCard(
                                icon: Icons.location_on_outlined,
                                topText: "address".tr,
                                bottomText: userAddress),
                          ],
                        ),
                      ),
                    ),
                    /*CustomButtonWithIcon(
                              onPressed: () {
                                Get.toNamed(AppRoute.paymentMethodScreen);
                              },
                              titleText: AppStaticStrings.paymentMethod,
                              iconSrc: AppIcons.paymentMethodIcon),*/
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: CustomButtonWithIcon(
                          onPressed: () {
                            Get.toNamed(AppRoute.historyScreen);
                          },
                          titleText: "History".tr,
                          iconSrc: AppIcons.historyIcon),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      ),
    );
  }
}
