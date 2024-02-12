import 'package:unibus/presentation/admin/admin_profile/admin_profile_screen.dart';
import 'package:unibus/presentation/admin/admin_profile/binding/admin_profile_binding.dart';
import 'package:unibus/presentation/admin/users_manage/users_manage_screen.dart';
import 'package:unibus/presentation/comapny/drivers_management/binding/driver_binding.dart';
import 'package:unibus/presentation/comapny/drivers_management/drivers_screen.dart';
import 'package:unibus/presentation/comapny/drivers_rate/drivers_rate_screen.dart';
import 'package:unibus/presentation/comapny/price_management/binding/price_binding.dart';
import 'package:unibus/presentation/comapny/profile/binding/profile_binding.dart';
import 'package:unibus/presentation/splash_screen/splash_screen.dart';
import 'package:unibus/presentation/splash_screen/binding/splash_binding.dart';
import 'package:get/get.dart';
import 'package:unibus/presentation/switch_screen.dart';

import '../presentation/admin/companies_management/companies_management_screen.dart';
 import '../presentation/comapny/chat_center/binding/chat_center_binding.dart';
import '../presentation/comapny/chat_center/chat_center_screen.dart';
import '../presentation/comapny/chat_center/chat_room_screen.dart';
import '../presentation/comapny/live_trips/binding/live_trip_binding.dart';
import '../presentation/comapny/live_trips/live_trips.dart';
import '../presentation/comapny/price_management/price_management_screen.dart';
import '../presentation/comapny/profile/profile_screen.dart';
import '../presentation/comapny/student_requests/binding/student_requests_binding.dart';
import '../presentation/comapny/student_requests/student_requests_screen.dart';
import '../presentation/comapny/travels_management/add_trip_management.dart';
import '../presentation/comapny/travels_management/binding/travels_binding.dart';
import '../presentation/comapny/travels_management/ediy_trip_screen.dart';
import '../presentation/comapny/travels_management/tervels_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String initialRoute = '/initialRoute';
  static const String switchScreen = '/SwitchScreen';
  static const String adminProfileScreen = '/admin/adminProfileScreen';
  static const String adminUsersManagementScreen = '/admin/adminUsersManagementScreen';
  static const String adminCompaniesManagementScreen = '/admin/adminCompaniesManagementScreen';

  // company routes
  static const String companyProfileScreen = '/company/companyProfileScreen';
  static const String companyPriceManagementScreen = '/company/companyPriceManagementScreen';
  static const String companyDriversManagementScreen = '/company/companyDriversManagementScreen';
  static const String companyTripManagementScreen = '/company/companyTravelsManagementScreen';
  static const String companyAddTripScreen = '/company/companyAddTripScreen';
  static const String companyEditTripScreen = '/company/companyEditTripScreen';
  static const String companyStudentRequestScreen = '/company/companyStudentRequestScreen';
  static const String companyChatCenter = '/company/companyChatCenter';
  static const String companyChatRoom = '/company/companyChatRoom';
  static const String companyLiveTrip = '/company/companyLiveTrip';
  static const String companyDriversRatingScreen = '/company/companyDriversRatingScreen';

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
    ),
    // company routes
    GetPage (
      name: companyProfileScreen,
      page: () => CompanyProfile(),
      binding: CompanyProfileBinding(),
    ),
    GetPage (
      name: companyPriceManagementScreen,
      page: () => PriceManagementScreen(),
      binding: PriceBinding(),
    ),
    GetPage (
      name: companyDriversManagementScreen,
      page: () => DriverManagementScreen(),
      binding: DriversBinding(),
    ),
    GetPage (
      name: companyTripManagementScreen,
      page: () => TripsManagementScreen(),
      binding: TripsBinding(),
    ),
    GetPage (
      name: companyAddTripScreen,
      page: () => AddTripScreen(),
      binding: TripsBinding(),
    ),
    GetPage (
      name: companyEditTripScreen,
      page: () => EditTripScreen(),
      binding: TripsBinding(),
    ),
    GetPage(
      name: companyStudentRequestScreen,
      page: () => StudentRequestScreen(),
      binding: StudentRequestsBinding(),
    ),
    GetPage (
      name: companyChatCenter,
      page: () => ChatCenterScreen(),
      binding: ChatCenterBinding(),
    ),
    GetPage (
      name: companyChatRoom,
      page: () => ChatRoomScreen(chat: Get.arguments)
    ),
    GetPage (
      name: companyLiveTrip,
      page: () => LiveTripScreen(),
      binding: LiveTripBinding(),
    ),
    GetPage(
      name: switchScreen,
      page: () => SwitchScreen(),
    ),
    GetPage(
      name: companyDriversRatingScreen,
      page: () => DriversRateScreen(),
      binding: DriversBinding(),
    )
  ];
}
