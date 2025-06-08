import 'package:get/get.dart';
import 'package:scan_alphabet/app/modules/scan/bindings/scan_binding.dart';
import 'package:scan_alphabet/app/modules/scan/views/result_view.dart';
import 'package:scan_alphabet/app/modules/scan/views/scan_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MENU_SCAN,
      page: () => ScanView(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => ResultView(),
    ),
  ];
}
