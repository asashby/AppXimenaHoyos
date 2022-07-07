class ShopOrder {
  String? origin;
  List<ShopItem>? lineItems;
  Shipping? shipping;
  double? costShipping;
  double? total;
  List<int>? promoProducts;
  bool? hasPromo;

  ShopOrder(
      {this.origin,
      this.lineItems,
      this.shipping,
      this.costShipping,
      this.total,
      this.promoProducts,
      this.hasPromo});

  ShopOrder.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    if (json['line_items'] != null) {
      lineItems = <ShopItem>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new ShopItem.fromJson(v));
      });
    }
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    costShipping = json['cost_shipping'];
    total = json['total'];
    hasPromo = json['hasPromo'];
    promoProducts = json['promoProducts'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin'] = this.origin;
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    data['cost_shipping'] = this.costShipping;
    data['total'] = this.total;
    data['hasPromo'] = this.hasPromo;
    data['promoProducts'] = this.promoProducts;
    return data;
  }
}

class ShopItem {
  int? productId;
  String? name;
  int? count;
  String? productImage;
  int? productHasChallengePromo;
  int? productChallengeId;
  String? category;

  ShopItem({this.productId, this.name, this.count, this.productImage, this.productChallengeId, this.productHasChallengePromo, this.category});

  ShopItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    count = json['count'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['count'] = this.count;
    data['product_image'] = this.productImage;
    return data;
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;

  Shipping(
      {this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.country});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}