class ProductDetails {
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

  ProductDetails(
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

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
}