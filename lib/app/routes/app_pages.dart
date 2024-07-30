import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/addimage/bindings/addimage_binding.dart';
import '../modules/addimage/views/addimage_view.dart';
import '../modules/allfoodcategory/bindings/allfoodcategory_binding.dart';
import '../modules/allfoodcategory/views/allfoodcategory_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/edituser/bindings/edituser_binding.dart';
import '../modules/edituser/views/edituser_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/imagetranf/bindings/imagetranf_binding.dart';
import '../modules/imagetranf/views/imagetranf_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/tambahan/bindings/tambahan_binding.dart';
import '../modules/tambahan/views/tambahan_view.dart';
import '../modules/userinfo/bindings/userinfo_binding.dart';
import '../modules/userinfo/views/userinfo_view.dart';
import '../modules/viewimage/bindings/viewimage_binding.dart';
import '../modules/viewimage/views/viewimage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.landing,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.userinfo,
      page: () => const UserinfoView(),
      binding: UserinfoBinding(),
    ),
    GetPage(
      name: _Paths.addimage,
      page: () => const AddimageView(),
      binding: AddimageBinding(),
    ),
    GetPage(
      name: _Paths.allfoodcategory,
      page: () => const AllfoodcategoryView(),
      binding: AllfoodcategoryBinding(),
    ),
    GetPage(
      name: _Paths.detail,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.tambahan,
      page: () => TambahanView(),
      binding: TambahanBinding(),
    ),
    GetPage(
      name: _Paths.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.imagetranf,
      page: () => const ImagetranfView(),
      binding: ImagetranfBinding(),
    ),
    GetPage(
      name: _Paths.order,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.viewimage,
      page: () => const ViewimageView(),
      binding: ViewimageBinding(),
    ),
    GetPage(
      name: _Paths.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.edituser,
      page: () => const EdituserView(),
      binding: EdituserBinding(),
    ),
    GetPage(
      name: _Paths.about,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
