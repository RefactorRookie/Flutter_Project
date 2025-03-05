class Product {
  int? _totalProduct;
  late List<Products> _products;
  List<Products> get products => _products;

  Product({required totalProduct, required products}){
    _totalProduct = totalProduct;
    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalProduct = json['total_product'];
    if (json['products'] != null) {
      _products = <Products>[];
      json['products'].forEach((v) {
        _products.add(new Products.fromJson(v));
      });
    }
  }

}

class Products {
  int? id;
  String? name;
  int? price;
  String? descriptions;
  String? image;
  String? createdAt;
  String? updatedAt;
  bool? stock;
  int? category;
  String? user;

  Products(
      {this.id,
        this.name,
        this.price,
        this.descriptions,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.stock,
        this.category,
        this.user});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    descriptions = json['descriptions'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stock = json['stock'];
    category = json['category'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['descriptions'] = this.descriptions;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stock'] = this.stock;
    data['category'] = this.category;
    data['user'] = this.user;
    return data;
  }
}