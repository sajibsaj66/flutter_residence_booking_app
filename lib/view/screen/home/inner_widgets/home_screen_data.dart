import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_hotel_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_new_hotel_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_new_personal_house_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_new_residence_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_personal_house_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_popular_hotel_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_popular_personal_house_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_popular_residence_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_residence_section.dart';

class HomeScreenData extends StatefulWidget {
  const HomeScreenData({super.key});

  @override
  State<HomeScreenData> createState() => _HomeScreenDataState();
}

class _HomeScreenDataState extends State<HomeScreenData> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: GetBuilder<HomeController>(
      builder: (controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 24),
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 8, vertical: 8),
              decoration: ShapeDecoration(
                color: const Color(0xFFFDFBFB),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFFE2E2E2)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      controller.tabList.length,
                      (index) => Flexible(
                            child: GestureDetector(
                              onTap: () => controller.changeTabValue(index),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                margin: index == 2 ? const EdgeInsetsDirectional.only(end: 0) : const EdgeInsetsDirectional.only(end: 12),
                                decoration: ShapeDecoration(
                                  gradient: index == controller.selectedTabIndex ? const LinearGradient(begin: Alignment(-0.00, -1.00), end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFF787878),
                                      Color(0xFF434343),
                                      Colors.black
                                    ],
                                  ) : const LinearGradient(begin: Alignment(-0.00, -1.00), end: Alignment(0, 1),
                                  colors: [
                                    Color(0xFFFDFBFB),
                                    Color(0xFFFDFBFB),
                                    Color(0xFFFDFBFB)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)
                              ),
                            ),
                            child: Text(
                              controller.tabList[index].tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                color: index == controller.selectedTabIndex ? Colors.white : AppColors.blackPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ),
                      ),
                    )
                  )
              ),
            ),
          ),
          Flexible(
            child: controller.selectedTabIndex == 0 ? SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                  children: [
                    controller.allHotelDataList.isNotEmpty ? const Column(
                      children: [
                        HomeHotelSection(),
                        SizedBox(height: 24),
                      ],
                    ) : const SizedBox(),
                    controller.allResidencesDataList.isNotEmpty ? const Column(
                      children: [
                        HomeResidenceSection(),
                        SizedBox(height: 24),
                      ],
                    ) : const SizedBox(),
                    controller.allPersonalHouseDataList.isNotEmpty ? const HomePersonalHouseSection() : const SizedBox(),
                  ],
                ),
              ) : controller.selectedTabIndex == 1 ? SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  controller.newHotelDataList.isNotEmpty ? const Column(
                    children: [
                      HomeNewHotelSection(),
                      SizedBox(height: 24),
                    ],
                  ) : const SizedBox(),
                  controller.newResidencesDataList.isNotEmpty ?
                  const Column(
                    children: [
                      HomeNewResidenceSection(),
                      SizedBox(height: 24),
                    ],
                  ) : const SizedBox(),
                  controller.newPersonalHouseDataList.isNotEmpty ? const HomeNewPersonalHouseSection() : const SizedBox(),
                ],
              ),
            ) : controller.selectedTabIndex == 2 ? SingleChildScrollView(
                padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    controller.popularHotelDataList.isNotEmpty ? const Column(
                      children: [
                        HomePopularHotelSection(),
                        SizedBox(height: 24),
                      ],
                    ) : const SizedBox(),
                    controller.popularResidencesDataList.isNotEmpty ?
                    const Column(
                      children: [
                        HomePopularResidenceSection(),
                        SizedBox(height: 24),
                      ],
                    ) : const SizedBox(),
                    controller.popularPersonalHouseDataList.isNotEmpty ? const HomePopularPersonalHouseSection() : const SizedBox(),
                  ],
                ),
              ) : const SizedBox(),
            )
        ],
      ),
    ));
  }
}
