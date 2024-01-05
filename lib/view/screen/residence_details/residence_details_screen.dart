import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/home/home_model/home_model.dart';
import 'package:resid_plus_user/view/screen/residence_details/inner_widget/image_and_number.dart';
import 'package:resid_plus_user/view/screen/residence_details/inner_widget/reviews.dart';
import 'package:resid_plus_user/view/screen/residence_details/residence_details_repo/residence_details_repo.dart';
import 'package:resid_plus_user/view/widgets/design/custom_search.dart';
import 'residence_details_controller/residence_details_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ResidenceDetailsScreen extends StatefulWidget {

  const ResidenceDetailsScreen({
    super.key,
  });

  @override
  State<ResidenceDetailsScreen> createState() => _ResidenceDetailsScreenState();
}

class _ResidenceDetailsScreenState extends State<ResidenceDetailsScreen> {

  late List<Residence> allHotelDataList;
  late int index;

  String startDate = '';
  String endDate = '';

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  int currentIndex = 0;

  @override
  void initState() {
    DeviceUtils.bottomNavUtils();

    allHotelDataList = Get.arguments[0];
    index = Get.arguments[1];

    DeviceUtils.bottomNavUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ResidenceDetailsRepo(apiService: Get.find()));
    Get.put(ResidenceDetailsController(detailsRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<ResidenceDetailsController>(
        builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 64),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 24, bottom: 0),
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "Residence Details".tr,
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
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: allHotelDataList[index].photo?.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageIndex) =>
                            Container(
                              margin:
                              const EdgeInsets.only(right: 10, left: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(allHotelDataList[index]
                                          .photo![itemIndex].publicFileUrl
                                          .toString())),
                                  color: const Color(0xFFECECEC),
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                            ),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          height: 180.0,
                          autoPlay: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DotsIndicator(
                        decorator: DotsDecorator(
                          color: Colors.grey.withOpacity(0.2),
                          activeColor: AppColors.blackPrimary,
                        ),
                        dotsCount: allHotelDataList[index].photo?.length ?? 0,
                        position: currentIndex,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    allHotelDataList[index].residenceName ?? '---',
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const Icon(Icons.star, color: Color(0xFFFBA91D), size: 18),
                                const SizedBox(width: 4),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '(',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF333333),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${allHotelDataList[index].ratings ?? 0}",
                                        style: GoogleFonts.openSans(
                                          color: const Color(0xFF333333),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ')',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF333333),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: allHotelDataList[index].status == "active" ? const Color(0xFFE8EDE6) : const Color(0xFFF2E1E3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Text(
                              allHotelDataList[index].status.toString(),
                              style: GoogleFonts.raleway(
                                color: allHotelDataList[index].status == "active" ? const Color(0xFF6AA259) : const Color(0xFFD7263D),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                height: 1.40,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                const Icon(Icons.place_outlined, color: Color(0xFF818181), size: 18),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    allHotelDataList[index].city ?? "",
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF818181),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          //hour /day
                          Row(
                            children: [
                              Text(
                                "\$ ${allHotelDataList[index].hourlyAmount ?? "---"}/hr",
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF818181),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "\$ ${allHotelDataList[index].dailyAmount ?? "---"}/day",
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF818181),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ImageWithNumber(imageName: "assets/icons/user_group.svg", number: "${allHotelDataList[index].capacity ?? 0}"),
                      ImageWithNumber(
                          imageName: "assets/icons/bed.svg",
                          number: "${allHotelDataList[index].beds ?? 0}"
                      ),
                      ImageWithNumber(
                          imageName: "assets/icons/shower.svg",
                          number: "${allHotelDataList[index].baths ?? 0}"
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'city'.tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF818181),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            allHotelDataList[index].city ?? "",
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF818181),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'municipality'.tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF818181),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              allHotelDataList[index].municipality ?? "",
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF818181),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'quartar'.tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF818181),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            allHotelDataList[index].quirtier ?? "",
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF818181),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Check In'.tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year),
                                    lastDate: DateTime(2028))
                                .then((value) {
                              setState(() {
                                if (value != null) {
                                  startDate = DateFormat("yyyy-MM-dd").format(value);
                                }
                              });
                            });
                          },
                          child: CustomSearchBar(
                            width: MediaQuery.of(context).size.width,
                            iconTxt: "assets/icons/calendar.png",
                            txt: startDate == '' ? "Select Date".tr : startDate,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      //
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final TimeOfDay? timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: startTime ?? TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                            if (timeOfDay != null) {
                              setState(() {
                                startTime = timeOfDay;
                              });
                            }
                          },
                          child: CustomSearchBar(
                            isSvg: true,
                            width: MediaQuery.of(context).size.width,
                            iconTxt: "assets/icons/clock.svg",
                            txt: startTime == null || startTime == const TimeOfDay(hour: 0, minute: 0)
                                ? "Select Time"
                                : startTime!.format(context),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Check Out'.tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year),
                                    lastDate: DateTime(2028))
                                .then((value) {
                              setState(() {
                                if (value != null) {
                                  endDate = DateFormat("yyyy-MM-dd").format(value);
                                }
                              });
                            });
                          },
                          child: CustomSearchBar(
                            width: MediaQuery.of(context).size.width,
                            iconTxt: "assets/icons/calendar.png",
                            txt: endDate == '' ? "Select Date".tr : endDate,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final TimeOfDay? timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: endTime ?? TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                            if (timeOfDay != null) {
                              setState(() {
                                endTime = timeOfDay;
                                if (kDebugMode) {
                                  print(endTime);
                                }
                              });
                            }
                          },
                          child: CustomSearchBar(
                            isSvg: true,
                            width: MediaQuery.of(context).size.width,
                            iconTxt: "assets/icons/clock.svg",
                            txt: endTime == null || endTime == const TimeOfDay(hour: 0, minute: 0)
                                ? "Select Time"
                                : endTime!.format(context),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Residence equipment",
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: allHotelDataList[index].amenities!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: MediaQuery.of(context).size.width,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 8,
                              mainAxisExtent: 30
                          ),
                          itemBuilder: (context, i) => Container(
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 6, horizontal: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.transparentColor,
                                border: Border.all(color: AppColors.blackPrimary),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: FittedBox(
                              child: Text(
                                allHotelDataList[index].amenities?[i].translation?.en ?? "---",
                                style: GoogleFonts.raleway(
                                   color: AppColors.blackPrimary,
                                   fontWeight: FontWeight.w400,
                                   fontSize: 12
                                ),
                              )
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About this residence".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        allHotelDataList[index].aboutResidence ?? "---",
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF818181),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Top Reviews".tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        controller.reviewModel.data?.attributes?.length ?? 0,
                        (index) => Reviews(
                            ratting: controller.reviewModel.data?.attributes?[index].rating?.toDouble() ?? 00.00,
                            userName: controller.reviewModel.data?.attributes?[index].userId?.fullName ?? "",
                            date: DateConverter.isoStringToLocalDateOnly(controller.reviewModel.data?.attributes?[index].createdAt ?? "",
                            ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 24),
                width: MediaQuery.of(context).size.width,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [
                      Color(0xFF787878),
                      Color(0xFF434343),
                      Colors.black
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\$ ',
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "${allHotelDataList[index].dailyAmount ?? 0}",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: " night".tr,
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: startDate,
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: " - ",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: endDate,
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    controller.isSubmit
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (startDate.isEmpty && endDate.isEmpty) {
                                Utils.snackBar("Alert".tr, "Please Enter Date Time".tr);
                              } else if (startDate.isNotEmpty && endDate.isNotEmpty) {
                                controller.addResidenceResult(
                                  id: allHotelDataList[index].id ?? "",
                                  startDate: startDate,
                                  endDate: endDate,
                                  startTime: startTime!.to24hours(),
                                  endTime: endTime!.to24hours(),
                                  data: allHotelDataList,
                                  index: index
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                'Reserve'.tr,
                                style: GoogleFonts.raleway(
                                  color: AppColors.blackPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
