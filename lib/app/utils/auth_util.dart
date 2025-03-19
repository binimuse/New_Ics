import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_ics/app/utils/constants.dart';
import 'package:new_ics/app/utils/validator_util.dart';

class AuthUtil {
  saveTokenAndUserInfo({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> user,
  }) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: Constants.accessToken, value: accessToken);
    await storage.write(key: Constants.refreshToken, value: refreshToken);
    await storage.write(key: Constants.userData, value: jsonEncode(user));
  }

  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    String? accessToken = await storage.read(key: Constants.accessToken);
    return Future.value(accessToken);
  }

  Future<String?> getRefreshToken() async {
    const storage = FlutterSecureStorage();
    String? refreshToken = await storage.read(key: Constants.refreshToken);
    return Future.value(refreshToken);
  }

  Future<Map<String, dynamic>> getUserData() async {
    const storage = FlutterSecureStorage();
    String? userData = await storage.read(key: Constants.userData);
    Map<String, dynamic> userDataMap = json.decode(userData!);
    return userDataMap;
  }

  Future<String> getUserId() async {
    Map<String, dynamic> userDataMap = await getUserData();
    String id = userDataMap['id'].toString();
    return id;
  }

  Future<bool> isUserPhoneVerified() async {
    Map<String, dynamic> userDataMap = await getUserData();
    bool isPhoneVerified = userDataMap['phone_otp_verified'];
    return isPhoneVerified;
  }

  Future<String> getUserPhone() async {
    Map<String, dynamic> userDataMap = await getUserData();
    String phone = userDataMap['username'];
    return phone;
  }

  updateUserPhoneNumber(String newPhone) async {
    Map<String, dynamic> userDataMap = await getUserData();
    userDataMap['username'] = ValidatorUtil.formatPhoneNumber(newPhone, true);
    userDataMap['phone_otp_verified'] = true;

    const storage = FlutterSecureStorage();
    await storage.write(
      key: Constants.userData,
      value: jsonEncode(userDataMap),
    );
  }

  logOut() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
