import 'package:get/get.dart';

import '../modules/addreview/bindings/addreview_binding.dart';
import '../modules/addreview/views/addreview_view.dart';
import '../modules/admincity/bindings/admincity_binding.dart';
import '../modules/admincity/views/admincity_view.dart';
import '../modules/adminplaces/bindings/adminplaces_binding.dart';
import '../modules/adminplaces/views/adminplaces_view.dart';
import '../modules/adminsetting/bindings/adminsetting_binding.dart';
import '../modules/adminsetting/views/adminsetting_view.dart';
import '../modules/changepassword/bindings/changepassword_binding.dart';
import '../modules/changepassword/views/changepassword_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const LOGIN = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORD,
      page: () => const ChangepasswordView(),
      binding: ChangepasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADDREVIEW,
      page: () => const AddreviewView(),
      binding: AddreviewBinding(),
    ),
    GetPage(
      name: _Paths.ADMINCITY,
      page: () => const AdmincityView(),
      binding: AdmincityBinding(),
    ),
    GetPage(
      name: _Paths.ADMINPLACES,
      page: () => const AdminplacesView(),
      binding: AdminplacesBinding(),
    ),
    GetPage(
      name: _Paths.ADMINSETTING,
      page: () => const AdminsettingView(),
      binding: AdminsettingBinding(),
    ),
  ];
}
