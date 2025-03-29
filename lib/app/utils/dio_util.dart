import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/data/models/login/me.dart';
import 'package:new_ics/app/data/models/login/refresh_token.dart';
import 'package:new_ics/app/data/services/module_login_signup_service.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/utils/auth_util.dart';
import 'package:new_ics/app/utils/validator_util.dart';

class DioUtil {
  static final DioUtil _instance = DioUtil._internal();
  factory DioUtil() => _instance;
  DioUtil._internal();

  static const int _timeoutInSeconds = 30;
  static const String _contentTypeJson = 'application/json';

  Dio getDio({bool? useAccessToken, bool? forFileUpload}) {
    BaseOptions options = BaseOptions(
      connectTimeout:
          forFileUpload == true
              ? const Duration(seconds: _timeoutInSeconds)
              : null,
      receiveTimeout:
          forFileUpload == true
              ? const Duration(seconds: _timeoutInSeconds)
              : null,
      headers: {'Content-Type': _contentTypeJson},
    );
    Dio dioInstance = Dio(options);

    dioInstance.interceptors.add(
      LogInterceptor(responseBody: true, request: true, requestHeader: true),
    );

    if (useAccessToken == true) {
      dioInstance.interceptors.add(_accessTokenInterceptor());
    }

    return dioInstance;
  }

  InterceptorsWrapper _accessTokenInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = await AuthUtil().getAccessToken();
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          String? newAccessToken = await _refreshToken();
          if (newAccessToken != null) {
            e.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            return handler.resolve(await Dio().fetch(e.requestOptions));
          }
        }
        return handler.next(e);
      },
    );
  }

  Future<String?> _refreshToken() async {
    try {
      String? refreshToken = await AuthUtil().getRefreshToken();
      TokenRefreshResponse tokenRefreshResponse = await LoginSignupService(
        getDio(),
      ).refreshToken(refreshToken: "Bearer $refreshToken");

      // Save the new tokens and user information
      await AuthUtil().saveTokenAndUserInfo(
        accessToken: tokenRefreshResponse.accessToken,
        refreshToken: tokenRefreshResponse.refreshToken,
        user: tokenRefreshResponse.user.toJson(),
      );

      // Update user information
      await getUserInfo();

      return tokenRefreshResponse.accessToken;
    } catch (e) {
      // Log out the user and navigate to the login page if an error occurs
      await AuthUtil().logOut();
      Get.offAllNamed(Routes.ON_BORDING);
      return null;
    }
  }

  Future<List?> handleDioError(DioException error) async {
    final response = error.response;
    if (response != null) {
      try {
        final message = response.data['message'];
        final code = response.statusCode;
        return [code, message];
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> getUserInfo() async {
    try {
      UserMeResponse userMeResponse =
          await LoginSignupService(getDio(useAccessToken: true)).me();

      String? accessToken = await AuthUtil().getAccessToken();
      String? refreshToken = await AuthUtil().getRefreshToken();

      if (accessToken == null || refreshToken == null) {
        throw Exception("Access token or refresh token is null");
      }

      await AuthUtil().saveTokenAndUserInfo(
        accessToken: accessToken,
        refreshToken: refreshToken,
        user: userMeResponse.toJson(),
      );
    } catch (e) {
      ValidatorUtil.handleError(e);
    }
  }
}
