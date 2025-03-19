import 'package:dio/dio.dart' hide Headers;
import 'package:new_ics/app/data/models/login/change_password.dart';
import 'package:new_ics/app/data/models/login/deactivate_account.dart';
import 'package:new_ics/app/data/models/login/generate_reset_password_otp.dart';
import 'package:new_ics/app/data/models/login/me.dart';
import 'package:new_ics/app/data/models/login/refresh_token.dart';
import 'package:new_ics/app/data/models/login/reset_password.dart';
import 'package:new_ics/app/data/models/login/sign_in.dart';
import 'package:new_ics/app/data/models/login/sign_up.dart';
import 'package:new_ics/app/utils/constants.dart';

import 'package:retrofit/retrofit.dart';

part 'module_login_signup_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class LoginSignupService {
  factory LoginSignupService(Dio dio) = _LoginSignupService;

  @POST(Constants.signInUrl)
  Future<SignInResponse> signIn({@Body() required SignInRequest signInRequest});

  @POST(Constants.signupuUrl)
  Future<SignUpResponse> signUp({@Body() required SignUpRequest signUpRequest});

  @POST(Constants.refersh)
  Future<TokenRefreshResponse> refreshToken({
    @Header('Authorization') required String refreshToken,
  });
  @GET(Constants.me)
  Future<UserMeResponse> me();

  @POST(Constants.generateresetpasswordotp)
  Future<GenerateResetPasswordOtpResponse> generateresetpasswordOtp({
    @Body()
    required GenerateResetPasswordOtpRequest generateResetPasswordOtpRequest,
  });

  @POST(Constants.resetpassword)
  Future<ResetpasswordResponse> resetpasswordOtp({
    @Body() required ResetpasswordRequest resetpasswordRequest,
  });

  @POST(Constants.deactivateURl)
  Future<DeactivateAccountResponse> deactivateAccount({
    @Body() required DeactivateAccountRequest deactivateAccount,
  });

  @POST(Constants.changepassword)
  Future<ChangePasswordResponse> changepassword({
    @Body() required ChangePasswordRequest changepassword,
  });
}
