import 'package:unibus/presentation/admin/admin_profile/admin_profile_screen.dart';
import 'package:unibus/presentation/admin/admin_profile/binding/admin_profile_binding.dart';
import 'package:unibus/presentation/admin/auth/login/admin_login_screen.dart';
import 'package:unibus/presentation/admin/users_manage/users_manage_screen.dart';
import 'package:unibus/presentation/comapny/auth/login/binding/company_login_binding.dart';
import 'package:unibus/presentation/comapny/auth/login/company_login_screen.dart';
import 'package:unibus/presentation/comapny/auth/register/company_register_screen.dart';
import 'package:unibus/presentation/comapny/drivers_management/binding/driver_binding.dart';
import 'package:unibus/presentation/comapny/drivers_management/drivers_screen.dart';
import 'package:unibus/presentation/comapny/drivers_rate/drivers_rate_screen.dart';
import 'package:unibus/presentation/comapny/price_management/binding/price_binding.dart';
import 'package:unibus/presentation/comapny/profile/binding/profile_binding.dart';
import 'package:unibus/presentation/driver/home/binding/home_binding.dart';
import 'package:unibus/presentation/driver/home/home_screen.dart';
import 'package:unibus/presentation/splash_screen/splash_screen.dart';
import 'package:unibus/presentation/splash_screen/binding/splash_binding.dart';
import 'package:get/get.dart';
import 'package:unibus/presentation/switch_screen.dart';
import 'package:unibus/presentation/user/auth/forget_password/binding/forget_password_binding.dart';
import 'package:unibus/presentation/user/auth/forget_password/forget_password_screen.dart';
import 'package:unibus/presentation/user/auth/login/user_login_screen.dart';
import 'package:unibus/presentation/user/auth/register/binding/user_register_binding.dart';
import 'package:unibus/presentation/user/company_district/binding/company_district_binding.dart';
import 'package:unibus/presentation/user/company_district/company_district.dart';
import 'package:unibus/presentation/user/company_trips/binding/company_trip_binding.dart';
import 'package:unibus/presentation/user/company_trips/company_trips_screen.dart';
import 'package:unibus/presentation/user/main/binding/user_main_binding.dart';
import 'package:unibus/presentation/user/main/main_screen.dart';
import 'package:unibus/presentation/user/user_profile/binding/user_profile_binding.dart';
import 'package:unibus/presentation/user/user_profile/user_profile.dart';
import '../presentation/admin/auth/login/binding/admin_login_binding.dart';
import '../presentation/admin/companies_management/companies_management_screen.dart';
import '../presentation/comapny/auth/register/binding/company_register_binding.dart';
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
import '../presentation/driver/auth/login/binding/driver_login_binding.dart';
import '../presentation/driver/auth/login/driver_login_screen.dart';
import '../presentation/user/auth/login/binding/user_login_binding.dart';
import '../presentation/user/auth/register/user_register_screen.dart';
import '../presentation/user/payment_screen/payment_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String initialRoute = '/initialRoute';
  static const String switchScreen = '/SwitchScreen';
  static const String adminProfileScreen = '/admin/adminProfileScreen';
  static const String adminUsersManagementScreen = '/admin/adminUsersManagementScreen';
  static const String adminCompaniesManagementScreen = '/admin/adminCompaniesManagementScreen';
  static const String adminLoginScreen = '/admin/adminLoginScreen';

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
  static const String companyLoginScreen = '/company/companyLoginScreen';
  static const String companyRegisterScreen = '/company/companyRegisterScreen';
  // user routes
  static const String userProfileScreen = '/user/userProfileScreen';
  static const String userMain = '/user/userMain';
  static const String userCompanyTripsScreen = '/user/userCompanyTripsScreen';
  static const String userCompanyDistrictsScreen = '/user/userCompanyDistrictsScreen';
  static const String userPaymentScreen = '/user/userPaymentScreen';
  static const String userLoginScreen = '/user/userLoginScreen';
  static const String userRegisterScreen = '/user/userRegisterScreen';
  static const String forgetPasswordScreen = '/user/forgetPasswordScreen';
  // driver routes
  static const String driverLoginScreen = '/driver/driverLoginScreen';
  static const String driverRegisterScreen = '/driver/driverRegisterScreen';
  static const String driverHomeScreen = '/driver/driverHomeScreen';


  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: adminLoginScreen,
      page: () => AdminLoginPage(),
      bindings: [
        AdminLoginBinding(),
      ]
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
    GetPage(
      name: companyLoginScreen,
      page: () => CompanyLoginPage(),
      binding: CompanyLoginBinding(),
    ),
    GetPage(
      name: companyRegisterScreen,
      page: () => CompanyRegisterPage(),
      binding: CompanyRegisterBinding(),
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
    ),
    // user routes
    GetPage(
      name: userProfileScreen,
      page: () => UserProfileScreen(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: userMain,
      page: () => MainScreen(),
      binding: UserMainBinding(),
    ),
    GetPage (
      name: userCompanyTripsScreen,
      page: () => CompanyTripScreen(),
      binding: CompanyTripsBinding()
    ),
    GetPage(
      name: userCompanyDistrictsScreen,
      page: () => CompanyDistrictScreen(),
      binding: CompanyDistrictBinding(),
    ),
    GetPage(
      name: userPaymentScreen,
      page: () => PaymentScreen(),

    ),
     GetPage(
       name: userLoginScreen,
       page: () => UserLoginPage(),
       binding: UserLoginBinding(),

     ),
    GetPage(
      name: userRegisterScreen,
      page: () => UserRegisterPage(),
      binding: UserRegisterBinding(),

    ),
    // driver routes
    GetPage(
      name: driverLoginScreen,
      page: () => DriverLoginPage(),
      binding: DriverLoginBinding(),
    ),
    GetPage(
      name: driverHomeScreen,
      page: () => DriverHomeScreen(),
      binding: DriverHomeBinding()
     ),
   ];
}
