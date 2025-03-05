import 'package:e_shop_flutter/utils/app_constants.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Authorization' : 'Token $token'
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Authorization' : 'Token $token'
    };
  }

  Future<Response> postData(String uri, dynamic body ) async{
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    }
    catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }


  Future<Response> getData(String uri) async{
    try{
      Response response = await get(uri, headers: _mainHeaders);
      return response;
    }
    catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }


  Future<Response> deleteData(String uri) async{
    try{
      Response response = await delete(uri, headers: _mainHeaders);
      return response;
    }
    catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

}