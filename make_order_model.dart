class MakeOrderModel {
  String? user;
  List<int>? orderDetails;
  int? totalPrice;
  String? paymentStatus;

  MakeOrderModel(
      {required this.user, required this.orderDetails, required this.totalPrice, required this.paymentStatus});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['order_details'] = this.orderDetails;
    data['total_price'] = this.totalPrice;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}