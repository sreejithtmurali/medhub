import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:medhub/services/reminder_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:statusbarz/statusbarz.dart';

import 'app/app.router.dart';
import 'constants/app_colors.dart';
import 'constants/app_strings.dart';
import 'constants/assets.gen.dart';
import 'constants/fonts.gen.dart';
import 'ui/tools/screen_size.dart';
import 'ui/tools/smart_dialog_config.dart';
import 'ui/widgets/setup_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize before any instantiation
  await ReminderService.initialize();
  await ReminderService().testAlarm(); // Test alarm after initialization

  await requestDNDPermission();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (!kIsWeb && Platform.isAndroid) {
    ByteData data = await PlatformAssetBundle().load(Assets.ca.letsEncryptR3);
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeData(
            primarySwatch: generateMaterialColor(Palette.primary),
            fontFamily: FontFamily.barlow,
            scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
          ),
          builder: FlutterSmartDialog.init(
            builder: (context, child) {
              ScreenSize.init(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: child!,
              );
            },
            toastBuilder: toastBuilder,
            loadingBuilder: loadingBuilder,
          ),
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorObservers: [
            StackedService.routeObserver,
            FlutterSmartDialog.observer,
          ],
        );
      },
    );
  }
}

Future<void> requestDNDPermission() async {
  if (await Permission.accessNotificationPolicy.isDenied) {
    await Permission.accessNotificationPolicy.request();
  }
}