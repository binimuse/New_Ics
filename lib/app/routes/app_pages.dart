import 'package:get/get.dart';

import '../modules/change_visa/bindings/change_visa_binding.dart';
import '../modules/change_visa/views/change_visa_view.dart';
import '../modules/check_status/bindings/check_status_binding.dart';
import '../modules/check_status/views/check_status_view.dart';
import '../modules/complain_page/bindings/complain_page_binding.dart';
import '../modules/complain_page/views/complain_page_view.dart';
import '../modules/evisa/bindings/evisa_binding.dart';
import '../modules/evisa/views/evisa_view.dart';
import '../modules/feedback_page/bindings/feedback_page_binding.dart';
import '../modules/feedback_page/views/feedback_page_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/my_order/bindings/my_order_binding.dart';
import '../modules/my_order/views/my_order_view.dart';
import '../modules/new_origin_id/bindings/new_origin_id_binding.dart';
import '../modules/new_origin_id/views/new_origin_id_view.dart';
import '../modules/new_passport/bindings/new_passport_binding.dart';
import '../modules/new_passport/views/new_passport_view.dart';
import '../modules/new_residence/bindings/new_residence_binding.dart';
import '../modules/new_residence/views/new_residence_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/on_bording/bindings/on_bording_binding.dart';
import '../modules/on_bording/views/on_bording_view.dart';
import '../modules/otp_varification/bindings/otp_varification_binding.dart';
import '../modules/otp_varification/views/otp_varification_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/renew_origin_id/bindings/renew_origin_id_binding.dart';
import '../modules/renew_origin_id/views/renew_origin_id_view.dart';
import '../modules/renew_passport/bindings/renew_passport_binding.dart';
import '../modules/renew_passport/views/renew_passport_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/residency/bindings/residency_binding.dart';
import '../modules/residency/views/residency_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/terms_and_conditions/bindings/terms_and_conditions_binding.dart';
import '../modules/terms_and_conditions/views/terms_and_conditions_view.dart';
import '../modules/visa_cancellation/bindings/visa_cancellation_binding.dart';
import '../modules/visa_cancellation/views/visa_cancellation_view.dart';
import '../modules/visa_extantion/bindings/visa_extantion_binding.dart';
import '../modules/visa_extantion/views/visa_extantion_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ON_BORDING,
      page: () => const OnBordingView(),
      binding: OnBordingBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_STATUS,
      page: () => const CheckStatusView(),
      binding: CheckStatusBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VARIFICATION,
      page: () => const OtpVarificationView(),
      binding: OtpVarificationBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDER,
      page: () => const MyOrderView(),
      binding: MyOrderBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSPORT,
      page: () => const NewPassportView(),
      binding: NewPassportBinding(),
    ),
    GetPage(
      name: _Paths.RENEW_PASSPORT,
      page: () => const RenewPassportView(),
      binding: RenewPassportBinding(),
    ),
    GetPage(
      name: _Paths.NEW_ORIGIN_ID,
      page: () => const NewOriginIdView(),
      binding: NewOriginIdBinding(),
    ),
    GetPage(
      name: _Paths.RENEW_ORIGIN_ID,
      page: () => const RenewOriginIdView(),
      binding: RenewOriginIdBinding(),
    ),
    GetPage(
      name: _Paths.EVISA,
      page: () => const EvisaView(),
      binding: EvisaBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_VISA,
      page: () => const ChangeVisaView(),
      binding: ChangeVisaBinding(),
    ),
    GetPage(
      name: _Paths.VISA_EXTANTION,
      page: () => const VisaExtantionView(),
      binding: VisaExtantionBinding(),
    ),
    GetPage(
      name: _Paths.VISA_CANCELLATION,
      page: () => const VisaCancellationView(),
      binding: VisaCancellationBinding(),
    ),
    GetPage(
      name: _Paths.RESIDENCY,
      page: () => const ResidencyView(),
      binding: ResidencyBinding(),
    ),
    GetPage(
      name: _Paths.NEW_RESIDENCE,
      page: () => const NewResidenceView(),
      binding: NewResidenceBinding(),
    ),
    GetPage(
      name: _Paths.COMPLAIN_PAGE,
      page: () => const ComplainPageView(),
      binding: ComplainPageBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK_PAGE,
      page: () => const FeedbackPageView(),
      binding: FeedbackPageBinding(),
    ),
  ];
}
