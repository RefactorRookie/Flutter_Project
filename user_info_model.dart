class UserInfoModel {
  String? image;
  String? user;
  String? name;
  String? billingAddress;
  String? shippingAddress;
  String? phone;

  UserInfoModel({
    this.image,
    this.user,
    this.name,
    this.billingAddress,
    this.shippingAddress,
    this.phone,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json){
    image = json['image'];
    user = json['user'];
    name = json['name'];
    billingAddress = json['billing_address'];
    shippingAddress = json['shipping_address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["image"] = image;
    data["name"] = name;
    data["billing_address"] = billingAddress;
    data["shipping_address"] = shippingAddress;
    data['phone'] = phone;
    return data;
  }
}
