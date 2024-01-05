import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus_user/view/screen/checkout/checkout_controller/checkout_controller.dart';
import 'package:resid_plus_user/view/widgets/buttons/custom_elevated_button.dart';

class CheckoutBottomNav extends StatelessWidget {
  const CheckoutBottomNav({super.key, required this.index, required this.bookingListModel});

  final int index;
  final BookingListModel bookingListModel;

  @override
  Widget build(BuildContext context) {
    final data = bookingListModel.data?.attributes?.bookings;
    if (data?[index].status == "pending") {
      return GetBuilder<CheckOutController>(builder: (controller) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
            child: CustomElevatedButton(
              buttonHeight: 48,
              buttonWidth: MediaQuery.of(context).size.width,
              buttonColor: AppColors.whiteColor,
              onPressed: () {controller.deleteResidenceResult(id: data?[index].id ?? "");
              },
              titleText: "Cancel".tr,
              titleColor: AppColors.blackPrimary,
            ),
          ),
        );
      });
    } else if (data?[index].status == "reserved") {
      if(data?[index].paymentTypes == "unknown"){
        return GetBuilder<CheckOutController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
              child: CustomElevatedButton(
                buttonHeight: 48,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonColor: AppColors.whiteColor,
                onPressed: () {
                  Get.offAndToNamed(AppRoute.bookingDetailsScreen,arguments: [bookingListModel,index]);
                },
                titleText: "Make Payment",
                titleColor: AppColors.blackPrimary,
              ),
            ),
          );
        });
      }else{
        return GetBuilder<CheckOutController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
              child: CustomElevatedButton(
                buttonHeight: 48,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonColor: AppColors.whiteColor,
                onPressed: () {
                  controller.checkInResult(id: data?[index].id ?? "");
                },
                titleText: "Check In",
                titleColor: AppColors.blackPrimary,
              ),
            ),
          );
        });
      }
    } else if (data?[index].status == "check-in") {
      if (data?[index].paymentTypes == "half-payment") {
        return GetBuilder<CheckOutController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
              child: CustomElevatedButton(
                buttonHeight: 48,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonColor: AppColors.whiteColor,
                onPressed: () {
                  final double price = (bookingListModel
                              .data?.attributes?.bookings?[index].totalAmount)
                          ?.toDouble() ??
                      00.00;
                  final double totalPrice = (price/ 2).toDouble();
                  final String bookingId =
                      bookingListModel.data?.attributes?.bookings?[index].id ??
                          "";
                  Get.offAndToNamed(AppRoute.duePaymentScreen, arguments: [
                    bookingListModel,
                    index,
                    totalPrice.ceil(),
                    bookingId
                  ]);
                },
                titleText: "Due Payment",
                titleColor: AppColors.blackPrimary,
              ),
            ),
          );
        });
      } else {
        return GetBuilder<CheckOutController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
              child: CustomElevatedButton(
                buttonHeight: 48,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonColor: AppColors.whiteColor,
                onPressed: () {
                  controller.checkOutResult(
                      id: data?[index].id ?? "", context: context);
                },
                titleText: "Checkout",
                titleColor: AppColors.blackPrimary,
              ),
            ),
          );
        });
      }
    } else {
      return GetBuilder<CheckOutController>(builder: (controller) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
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
            child: CustomElevatedButton(
              buttonHeight: 48,
              buttonWidth: MediaQuery.of(context).size.width,
              buttonColor: AppColors.whiteColor,
              onPressed: () =>Get.offAndToNamed(AppRoute.homeScreen),
              titleText: "Back Home",
              titleColor: AppColors.blackPrimary,
            ),
          ),
        );
      });
    }
  }
}
