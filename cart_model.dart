class CartModel {
  String? user;
  int? productId;
  int? quantity;
  int? totalPrice;

  CartModel({
    required this.user,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['user']=user;
    data['product_id']=productId;
    data['quantity']=quantity;
    data['total_price']=totalPrice;

    return data;
  }
}
