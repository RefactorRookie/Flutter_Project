import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signin_body.dart';
import '../../models/signup_body.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  String? authToken;

  Future<Response> registration(SignUpBody signUpBody) async{
    return await apiClient.post(AppConstants.REGISTER_ENDPOINT, signUpBody.toJson());
  }

  Future<String> getUserToken() async{
    String token;
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    authToken = token;
    return token;
  }

  bool userLoggedIn() {
    getUserToken();
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<Response> login(SignInBody signInBody) async{
    return await apiClient.post(AppConstants.LOGIN_ENDPOINT, signInBody.toJson());
  }

  Future<bool> saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveEmailAndPassowrd(String email, String password) async{
    try{
      await sharedPreferences.setString(AppConstants.EMAIL, email);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }
    catch(e){
      throw e;
    }
  }

  Future<void> clearToken() async{
    await sharedPreferences.clear();
  }
}