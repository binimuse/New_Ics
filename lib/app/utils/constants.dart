class Constants {
  //base url
  ///URLS
  static const baseUrl = "http://5.75.142.45:4000";
  //language
  static const String selectedLanguage = "SELECTED_LANGUAGE";
  static const String lanAm = "am";
  static const String lanEn = "en";
  static const String lanor = "or";
  static const String lanti = "ti";
  static const String lanso = "so";
  static const String userId = 'userId';
  static const String userAccessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String verifyEmail = 'verifyEmail';

  static const accessToken = "ACCESS_TOKEN";
  static const refreshToken = "REFRESH_TOKEN";
  static const userData = "USER_DATA";
  static const riderData = "RIDER_DATA";

  //login
  static const signInUrl = "/auth/phone/login";
  static const signupuUrl = "/auth/phone/signup";
  static const verifyuUrl = "/auth/verify-user-otp";
  static const resendUrl = "/auth/generate-reset-password-otp";
  static const refersh = "/auth/refresh";
  static const me = "/auth/me";
  static const generateresetpasswordotp = "/auth/generate-reset-password-otp";
  static const resetpassword = "/auth/reset-password";
  static const deactivateURl = "/auth/deactivate-account";
  static const changepassword = "/auth/change-password";

  // static const baseUrl = "http://5.75.142.45:8015";

  // static const baseUrlFile =
  //     "https://motl-user-file-upload.obsv3.et-global-1.ethiotelecom.et/";
  // static const signInUrl = "/auth/phone/login";
  // static const refersh = "/auth/refresh";
  // static const me = "/auth/me";
  // static const generateresetpasswordotp = "/auth/generate-reset-password-otp";
  // static const resetpassword = "/auth/reset-password";
  // static const deactivateURl = "/auth/deactivate-account";
  // static const changepassword = "/auth/change-password";

  // static const tripscheduleUrl =
  //     "/trip-schedule/my-trip-schedule?sorting[property]=created_at&sorting[direction]=desc";
  // static const emergencyTripUrl = "/emergency-trip-assignment";

  // static const detailemergencyTripUrl = "/emergency-trip-assignment/{id}";
  // static const getCheckpointUrl = "/checkpoint/paginated";
  // static const getCargotypetUrl = "/cargo-type/paginated";
  // static const getvehicleUrl =
  //     "/license-vehicle/my-vehicles?limit=100&page=1&banned=false&authorized=true&available=true&closed=false";

  // static const sendTripscheduleURl = "/trip-schedule";
  // static const sendEmergecyTripscheduleURl = "/trip-schedule/assign";
  // static const detailtripscheduleUrl = "/trip-schedule/{id}";
  // static const detailVehilceUrl = "/vehicle/{id}";

  // // static const getvehiclenUrl =
  // //     "/checkpoint-connection/get-path?first_check_point_id={first_check_point_id}&second_check_point_id={second_check_point_id}";

  // static var validationResultKey = "VALIDATION_RESULT_KEY";
  // static var validationMessageKey = "VALIDATION_MESSAGE_KEY";
  // static var email = "EMAIL";
  // static var id = "ID";
  // static var password = "PASSWORD";
  // static var firstName = "FIRST_NAME";
  // static var lastName = "LAST_NAME";
  // static const accessToken = "ACCESS_TOKEN";
  // static const refreshToken = "REFRESH_TOKEN";
  // static const userData = "USER_DATA";
  // static const riderData = "RIDER_DATA";

  // //complaint
  // static const String getServiceTypeUrl = "/complaint-service/paginated";
  // static const sendComplaintURl = "/complaint";
  // static const sendAppealtURl = "/appeal";
  // static const getComplaintUrl = "/complaint/my-complaints";
  // static const getAppealtURl = "/appeal/paginated?page={page}";
  // static const getComplaintresponseURl = "/complaint-response/complaint/{id}";
  // static const getAppelresponseURl = "/appeal-response/appeal/{id}";

  // //feedback
  // static const sendFeedbackURl = "/feedback";

  // //content
  // static const getTermsandservicesURl = "/content/terms-and-services";
  // static const getpolicyURl = "/content/privacy-policy";
  // static const gereasonURl = "/content/user-deactivation-reason";
}
