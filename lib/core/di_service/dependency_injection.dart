import 'package:get/get.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/service/socket_service.dart';
import 'package:resid_plus_user/view/screen/edit_profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:resid_plus_user/view/widgets/no_internet/no_internet_controller/no_internet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> initDependency() async{

  final sharedPreference = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreference, fenix: true);
  Get.lazyPut(() => ApiService(sharedPreferences: Get.find()));
  Get.lazyPut(() => EditProfileController(), fenix: true);
  Get.lazyPut(() => SocketService(), fenix: true);

  Get.put<NoInternetController>(NoInternetController(), permanent: true);

  Get.find<SocketService>().connectToSocket();
}