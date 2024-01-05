import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/notification.dart';
import 'package:resid_plus_user/view/screen/language_change/language/language.dart';
import 'package:resid_plus_user/view/screen/language_change/language_change_controller/language_change_controller.dart';
import 'core/di_service/dependency_injection.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependency();
  await ScreenUtil.ensureScreenSize();
  await Get.put(LanguageController()).initStorage();

  SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  ]);

  await NotificationHelper.initLocalNotification(flutterLocalNotificationsPlugin);

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});
  final data = GetStorage();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppRoute.splashScreen,
      navigatorKey: Get.key,
      translations: Languages(),
      getPages: AppRoute.routes,
      locale: Get.find<LanguageController>().language.val ? const Locale("en" , "US") : const Locale("fr", "CA"),
      fallbackLocale:const Locale("en" , "US"),
    );
  }
}
