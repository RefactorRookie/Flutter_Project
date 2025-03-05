import 'package:e_shop_flutter/data/api/api_client.dart';
import 'package:e_shop_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class ProductDetailsRepo extends GetxService{
  final ApiClient apiClient;
  ProductDetailsRepo({required this.apiClient});

  Future<Response> getProduct(String id) async{
    return await apiClient.getData("/api/v1/product/$id/");
  }
}