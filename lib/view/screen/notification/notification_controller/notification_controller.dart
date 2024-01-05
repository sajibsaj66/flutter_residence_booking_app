import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/notification/notification_model/notification_response_model.dart';
import 'package:resid_plus_user/view/screen/notification/notification_repo/notification_repo.dart';

class NotificationController extends GetxController{

  NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  bool isLoading = false;
  NotificationResponseModel model = NotificationResponseModel();
  List<AllNotification> notificationList = [];

  initialData() async{
    isLoading = true;
    update();

    await fetchNotificationData();

    isLoading = false;
    update();
  }

  fetchNotificationData() async{

    ApiResponseModel responseModel = await notificationRepo.getNotification();
    if(responseModel.statusCode == 200){
      model = NotificationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<AllNotification>? tempList = model.data?.attributes?.allNotification;
      if(tempList != null && tempList.isNotEmpty){
        notificationList.addAll(tempList);
      }
    }
  }
}