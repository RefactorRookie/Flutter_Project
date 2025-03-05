import 'package:e_shop_flutter/data/api/api_client.dart';
import 'package:e_shop_flutter/models/make_order_model.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class MakeOrderRepo extends GetxService{
  final ApiClient apiClient;
  MakeOrderRepo({required this.apiClient});
  
  Future<Response> makeOrder(MakeOrderModel makeOrderModel) async{
    return await apiClient.postData(AppConstants.MAKE_ORDER_ENDPOINT, makeOrderModel.toJson());
  }
}