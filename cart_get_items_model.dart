class Cart {
  int? totalOrder;
  late List<Order> _allOrder;
  List<Order> get allOrders => _allOrder;

  Cart({required totalOrder, required allOrder}){
    totalOrder = totalOrder;
    _allOrder = allOrder;
  }

  Cart.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    if (json['order'] != null) {
      _allOrder = <Order>[];
      json['order'].forEach((v) {
        _allOrder.add(new Order.fromJson(v));
      });
    }
  }

}

class Order {
  int? id;
  String? productName;
  String? productImage;
  int? productPrice;
  int? quantity;
  int? totalPrice;
  String? createdAt;
  String? updatedAt;
  String? user;
  int? productId;

  Order(
      {this.id,
        this.productName,
        this.productImage,
        this.productPrice,
        this.quantity,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.productId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
    productId = json['product_id'];
  }
}