import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/service/socket_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_icons.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:resid_plus_user/view/screen/home/home_repo/home_repo.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/drawer.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_screen_data.dart';
import 'package:resid_plus_user/view/screen/notification/notification_screen.dart';
import 'package:resid_plus_user/view/screen/profile/profile.dart';
import 'package:resid_plus_user/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus_user/view/screen/profile/profile_repo/profile_repo.dart';
import 'package:resid_plus_user/view/screen/search/search.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:resid_plus_user/view/widgets/design/custom_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    DeviceUtils.bottomNavUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiService: Get.find()));
    Get.put(HomeController(homeRepo: Get.find()));
    Get.put(ProfileRepo(apiService: Get.find()));
    Get.put(SocketService());
    final controller = Get.put(HomeController(homeRepo: Get.find()));
    final profileController = Get.put(ProfileController(profileRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
      profileController.profile();
      getNotification();
    });
    super.initState();
  }

  String userUid = "";

  getNotification() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userUid = pref.getString(SharedPreferenceHelper.userIdKey).toString();
    Get.find<SocketService>().connectToSocket();
    Get.find<SocketService>().joinRoom(userUid);
    Get.find<SocketService>().showNotification();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          drawer: const HomeScreenDrawer(),
          key: _scaffoldKey,
          appBar: CustomAppBar(
              appBarContent: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: SvgPicture.asset(AppImages.menu),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () => Get.to(() => const SearchScreen()),
                              child: const CustomSearchBar(isSvg: true)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () => Get.offAndToNamed(AppRoute.notificationScreen),
                          child: SvgPicture.asset(AppIcons.bellIcon)),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => Get.to(() => const ProfileScreen()),
                        child: GetBuilder<ProfileController>(builder: (controller) {
                          if (controller.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }
                          return Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: controller.profileModel.data?.attributes?.user?.image?.publicFileUrl != null ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(controller.profileModel.data?.attributes?.user?.image?.publicFileUrl ?? ""
                                    )
                                ) : const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/profile_image.png")
                                )
                            ),
                          );
                        }),
                      )
                    ],
                  )
                ],
              )),
          body: GetBuilder<HomeController>(builder: (controller) {
            return controller.isLoading
                ? const Center(
              child: CircularProgressIndicator(
                  color: AppColors.blackPrimary),
            )
                : controller.allHotelDataList.isNotEmpty ||
                controller.allResidencesDataList.isNotEmpty ||
                controller.allPersonalHouseDataList.isNotEmpty ||
                controller.newHotelDataList.isNotEmpty ||
                controller.newResidencesDataList.isNotEmpty ||
                controller.newPersonalHouseDataList.isNotEmpty ||
                controller.popularHotelDataList.isNotEmpty ||
                controller.popularResidencesDataList.isNotEmpty ||
                controller.popularPersonalHouseDataList.isNotEmpty ? const HomeScreenData() : Center(
              child: Text(
                "No data found",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: AppColors.blackPrimary,
                  fontWeight: FontWeight.w500
                ),
              ),
            );
          }),
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
        );
      }),
    );
  }
}
