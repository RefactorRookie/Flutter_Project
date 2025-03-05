import 'package:e_shop_flutter/data/api/api_client.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class ProductListRepo extends GetxService{
  final ApiClient apiClient;
  ProductListRepo({required this.apiClient});
  
  Future<Response> getProduct() async{
    return await apiClient.getData(AppConstants.PRODUCT_ENDPOINT);
  }
}