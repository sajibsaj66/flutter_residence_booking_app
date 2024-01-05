import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kkiapay_flutter_sdk/kkiapay/view/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/kkiapayConf.sample.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/helper/date_converter_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_images.dart';
import 'package:resid_plus_user/utils/device_utils.dart';
import 'package:resid_plus_user/view/screen/booking_details/booking_details_controller/booking_details_controller.dart';
import 'package:resid_plus_user/view/screen/booking_details/booking_details_repo/booking_details_repo.dart';
import 'package:resid_plus_user/view/screen/booking_details/inner_widget/booking_details_top_section.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus_user/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:resid_plus_user/view/widgets/image/custom_image.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';


class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final TextEditingController nameController = TextEditingController(text: "Srabon");
  final TextEditingController emailController = TextEditingController(text: "srabon.bdcalling@gmail.com");
  final TextEditingController phoneController = TextEditingController(text: "61000000");

  BookingListModel bookingListModel = BookingListModel();
  int index = 0;
  final paymentType = ["Half Payment", "Full Payment"];
  final paymentRoomType = ["half-payment", "full-payment"];
  int selectPayment = 1;
  @override
  initState(){
    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(BookingRepo(apiService: Get.find()));
    Get.put(BookingController(bookingRepo: Get.find()));
    bookingListModel = Get.arguments[0];
    index = Get.arguments[1];
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
      child: GetBuilder<BookingController>(
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
                appBarContent: GestureDetector(
                  onTap: (){
                  Get.offAndToNamed(AppRoute.homeScreen);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Booking Details",
                        style: GoogleFonts.raleway(
                          color: AppColors.blackPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookingDetailsTopSection(data: bookingListModel.data?.attributes?.bookings?[index],),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Information".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "User Name".tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Flexible(
                              child: Text(
                                bookingListModel.data?.attributes?.bookings?[index].userId?.fullName??"",
                                style: GoogleFonts.openSans(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "User Contact".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Flexible(
                              child: Text(
                                bookingListModel.data?.attributes?.bookings?[index].userId?.phoneNumber??"",
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Person".tr,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Flexible(
                              child: Text(
                                '${bookingListModel.data?.attributes?.bookings?[index].residenceId?.capacity??0}',
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: const Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'In Date',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                                DateConverter.isoStringToLocalDateOnly(bookingListModel.data?.attributes?.bookings?[index].checkInTime??""),
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Out Date',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateConverter.isoStringToLocalDateOnly(
                                  bookingListModel.data?.attributes?.bookings?[index].checkOutTime ??
                                      ""),
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Time',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text("${bookingListModel.data?.attributes?.bookings?[index].totalAmount??0}",
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '\$ ${bookingListModel.data?.attributes?.bookings?[index].totalAmount??""}',
                              style: GoogleFonts.openSans(
                                color: const Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/exclamation.svg"),
                          const SizedBox(width: 8),
                          Text(
                            'You must be pay half of the amount for booking',
                            style: GoogleFonts.raleway(
                              color: AppColors.blackPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          paymentType.length,
                              (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectPayment = index;
                                if (kDebugMode) {
                                  print(selectPayment);
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.black.withOpacity(.2),
                                        width: 1),
                                    color: index == selectPayment
                                        ? AppColors.blackPrimary
                                        : AppColors.whiteColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  paymentType[index],
                                  style: GoogleFonts.raleway(
                                    color: AppColors.blackPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.black20)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              CustomImage(imageSrc: AppImages.kkiapay,imageType: ImageType.png,),
                              SizedBox(width: 10,),
                              CustomText(text: "KKiaPay",fontSize: 16,fontWeight: FontWeight.w500,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
                width: MediaQuery.of(context).size.width,
                decoration: const ShapeDecoration(
                  color: AppColors.transparentColor,
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
                    Expanded(
                      child: CustomElevatedButton(
                        buttonHeight: 48,
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonColor: AppColors.whiteColor,
                        onPressed: (){
                          controller.deleteResidenceResult(id: bookingListModel.data?.attributes?.bookings?[index].id??"");
                        },
                        titleText: "Cancel",
                        titleColor: AppColors.blackPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomElevatedButton(
                          buttonHeight: 48,
                          buttonWidth: MediaQuery.of(context).size.width,
                          buttonColor: AppColors.blackPrimary,
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.white,
                                insetPadding: const EdgeInsets.only(left: 20, right: 20),
                                elevation: 10,
                                shape: const RoundedRectangleBorder(borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 24),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const CustomText(text: "Payment",fontWeight: FontWeight.w700,fontSize: 18,),
                                        const SizedBox(height: 24,),
                                        CustomTextField(title: "Name", hintText: "Enter your name", controller: nameController),
                                        const SizedBox(height: 12),
                                        CustomTextField(title: "Email", hintText: "Enter your email", controller: emailController),
                                        const SizedBox(height: 12),
                                        CustomTextField(title: "Phone Number", hintText: "Enter your phone number", controller: phoneController),
                                        const SizedBox(height: 24),
                                        CustomElevatedButton(
                                            borderColor: AppColors.blackPrimary,
                                            buttonColor: AppColors.blackPrimary,
                                            titleColor: AppColors.whiteColor,
                                            onPressed: (){
                                              final int amount = int.parse('${bookingListModel.data?.attributes?.bookings?[index].totalAmount}');
                                              final double halfAmount = (amount/2).toDouble();
                                              if (kDebugMode) {
                                                print("${25.5.ceil()}");
                                              }
                                              if (kDebugMode) {
                                                print(amount.runtimeType);
                                              }
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>KKiaPay(
                                                  amount: selectPayment == 1? amount : halfAmount.ceil(),
                                                  phone: phoneController.text.trim(),
                                                  name: nameController.text.trim(),
                                                  email: emailController.text.trim(),
                                                  reason: 'transaction reason',
                                                  data: 'Fake data',
                                                  sandbox: true,
                                                  apikey: '7caf8120697911ee8d09fb6ffe60742d',
                                                  callback: (response, context) {
                                                    if (kDebugMode) {
                                                      print("$response");
                                                    }
                                                    switch ( response['status'] ) {
                                                      case PAYMENT_CANCELLED: if (kDebugMode) {
                                                        print(PAYMENT_CANCELLED);
                                                      }
                                                      break;
                                                      case PAYMENT_SUCCESS:
                                                         Get.offAndToNamed(AppRoute.paymentWaitingSuccess,arguments: [response,paymentRoomType[selectPayment],bookingListModel.data?.attributes?.bookings?[index].id]);
                                                        break;
                                                      case PAYMENT_FAILED: if (kDebugMode) {
                                                        print(PAYMENT_FAILED);
                                                      }
                                                      break;
                                                      default:
                                                        break;
                                                    }
                                                  },
                                                  theme: "#222F5A"
                                              )));
                                            },
                                            titleText: "Make Payment"
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          titleText: "Payment"
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
