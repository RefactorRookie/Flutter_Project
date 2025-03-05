class OrderHistory {
  int? totalOrder;
  late List<History> _allOrder;
  List<History> get allOrder => _allOrder;

  OrderHistory({required totalOrder, required allOrder});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    if (json['order'] != null) {
      _allOrder = <History>[];
      json['order'].forEach((v) {
        _allOrder.add(new History.fromJson(v));
      });
    }
  }
}

class History {
  int? id;
  int? totalAmount;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  String? user;

  History(
      {this.id,
        this.totalAmount,
        this.paymentStatus,
        this.createdAt,
        this.updatedAt,
        this.user});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_amount'] = this.totalAmount;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}