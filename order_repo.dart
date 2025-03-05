import 'package:e_shop_flutter/data/api/api_client.dart';
import 'package:e_shop_flutter/models/cart_model.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderRepo extends GetxService{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> uploadCartItems(CartModel cartModel) async{
    return await apiClient.postData(AppConstants.ORDER_ENDPOINT, cartModel.toJson());
  }

  Future<Response> getCartItems() async{
    return await apiClient.getData(AppConstants.ORDER_ENDPOINT);
  }
}