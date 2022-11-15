class SliderItem {
	int? id;
	String? title;
	String? slug;
	String? route;
	String? urlImage;
	int? order;
	int? productId;
	String? fullUrlImage;
	Product? product;

	SliderItem({this.id, this.title, this.slug, this.route, this.urlImage, this.order, this.productId, this.fullUrlImage, this.product});

	SliderItem.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
		slug = json['slug'];
		route = json['route'];
		urlImage = json['url_image'];
		order = json['order'];
		productId = json['product_id'];
		fullUrlImage = json['full_url_image'];
		product = json['product'] != null ? new Product.fromJson(json['product']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		data['slug'] = this.slug;
		data['route'] = this.route;
		data['url_image'] = this.urlImage;
		data['order'] = this.order;
		data['product_id'] = this.productId;
		data['full_url_image'] = this.fullUrlImage;
		if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
		return data;
	}
}

class Product {
	int? id;
	String? name;
	String? slug;
	String? description;
	String? urlImage;
	String? sku;
	int? price;
	int? isActive;
	String? createdAt;
	String? updatedAt;
	String? deletedAt;
	Attributes? attributes;
	int? stock;

	Product({this.id, this.name, this.slug, this.description, this.urlImage, this.sku, this.price, this.isActive, this.createdAt, this.updatedAt, this.deletedAt, this.attributes, this.stock});

	Product.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		slug = json['slug'];
		description = json['description'];
		urlImage = json['url_image'];
		sku = json['sku'];
		price = json['price'];
		isActive = json['is_active'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		deletedAt = json['deleted_at'];
		attributes = json['attributes'] != null ? new Attributes.fromJson(json['attributes']) : null;
		stock = json['stock'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['slug'] = this.slug;
		data['description'] = this.description;
		data['url_image'] = this.urlImage;
		data['sku'] = this.sku;
		data['price'] = this.price;
		data['is_active'] = this.isActive;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		data['deleted_at'] = this.deletedAt;
		if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
		data['stock'] = this.stock;
		return data;
	}
}

class Attributes {
  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;

  Attributes(
      {this.id,
      this.name,
      this.position,
      this.visible,
      this.variation});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    return data;
  }
}