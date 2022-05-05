class WoocommerceOrder {
  String? paymentMethod;
  String? paymentMethodTitle;
  String? status;
  String? currency;
  bool? setPaid;
  Billing? billing;
  Shipping? shipping;
  List<LineItems>? lineItems;
  List<ShippingLines>? shippingLines;

  WoocommerceOrder(
      {this.paymentMethod,
      this.paymentMethodTitle,
      this.status,
      this.currency,
      this.setPaid,
      this.billing,
      this.shipping,
      this.lineItems,
      this.shippingLines});

  WoocommerceOrder.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    status = json['status'];
    currency = json['currency'];
    setPaid = json['set_paid'];
    billing =
        json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(new ShippingLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['set_paid'] = this.setPaid;
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Billing {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? email;
  String? phone;

  Billing(
      {this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.email,
      this.phone});

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
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
    data['email'] = this.email;
    data['phone'] = this.phone;
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

class LineItems {
  int? productId;
  int? quantity;
  String? name;
  int? productHasChallengePromo;
  int? productChallengeId;

  LineItems({this.productId, this.quantity, this.name, this.productHasChallengePromo, this.productChallengeId});

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    return data;
  }
}

class ShippingLines {
  String? methodId;
  String? methodTitle;
  String? total;

  ShippingLines({this.methodId, this.methodTitle, this.total});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['total'] = this.total;
    return data;
  }
}