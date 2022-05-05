class ShopProduct {
  int? productId;
  String? name;
  int? count;

  ShopProduct({this.productId, this.name, this.count});

  ShopProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}