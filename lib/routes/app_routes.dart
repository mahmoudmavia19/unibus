import 'package:unibus/presentation/admin/admin_profile/admin_profile_screen.dart';
import 'package:unibus/presentation/admin/admin_profile/binding/admin_profile_binding.dart';
import 'package:unibus/presentation/admin/users_manage/users_manage_screen.dart';
import 'package:unibus/presentation/splash_screen/splash_screen.dart';
import 'package:unibus/presentation/splash_screen/binding/splash_binding.dart';
import 'package:get/get.dart';

import '../presentation/admin/companies_management/companies_management_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String initialRoute = '/initialRoute';
  static const String adminProfileScreen = '/admin/adminProfileScreen';
  static const String adminUsersManagementScreen = '/admin/adminUsersManagementScreen';
  static const String adminCompaniesManagementScreen = '/admin/adminCompaniesManagementScreen';


  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage (
      name: adminProfileScreen,
      page: () => AdminProfileScreen(),
      binding: AdminProfileBinding(),
    ),
    GetPage (
      name: adminUsersManagementScreen,
      page: () => UsersManagementScreen(),
     ),
    GetPage (
      name: adminCompaniesManagementScreen,
      page: () => CompanyManagementScreen(),

    )
  ];
}
