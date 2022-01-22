import 'package:flutter/material.dart';

class Product {
  int? id;
  String? name;
  String? slug;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  bool? onSale;
  bool? purchasable;
  bool? manageStock;
  int? stockQuantity;
  Dimensions? dimensions;
  List<Categories>? categories;
  List<Images>? images;
  List<Attributes>? attributes;
  String? priceHtml;
  List<int>? relatedIds;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.catalogVisibility,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.onSale,
      this.purchasable,
      this.manageStock,
      this.stockQuantity,
      this.dimensions,
      this.categories,
      this.images,
      this.attributes,
      this.priceHtml,
      this.relatedIds});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    priceHtml = json['price_html'];
    relatedIds = json['related_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['catalog_visibility'] = this.catalogVisibility;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    data['manage_stock'] = this.manageStock;
    data['stock_quantity'] = this.stockQuantity;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['price_html'] = this.priceHtml;
    data['related_ids'] = this.relatedIds;
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Images {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Images(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  Attributes(
      {this.id,
      this.name,
      this.position,
      this.visible,
      this.variation,
      this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}

List<Product> products = [
  Product(
    id: 1,
    name:"ISOXIPRO Whey protein isolate – Vainilla" ,
    price: "179.00",
    description: "Proteína en polvo de suero de leche aislada de 900g  (30 servicios),Contiene 25gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    images: [
      Images(
        id: 1,
        src: "resources/shop/isoxipro-vainilla.jpg",
      )
    ],
    sku: "PWV-1",
    categories: [
      Categories(
        id: 18,
        name: "PROTEINA",
        slug: "proteina"
      )
    ]
  ),
  Product(
    id: 2,
    name:"Muñequera" ,
    price: "39.90",
    description: "",
    images: [
      Images(
        id: 2,
        src: "resources/shop/muñequera.jpg",
      )
    ],
    sku: "MHOX",
    categories: [
      Categories(
        id: 21,
        name: "IMPLEMENTOS",
        slug: "implementos"
      )
    ]
  ),
  Product(
    id: 3,
    name:"Vincha" ,
    price: "24.90",
    description: "",
    images: [
      Images(
        id: 3,
        src: "resources/shop/vincha.jpg",
      )
    ],
    sku: "CH3-1-1",
    categories: [
      Categories(
        id: 21,
        name: "IMPLEMENTOS",
        slug: "implementos"
      )
    ]
  ),
  Product(
    id: 4,
    name:"Polera XOH" ,
    price: "89.00",
    description: "",
    images: [
      Images(
        id: 4,
        src: "resources/shop/polera.jpg",
      )
    ],
    sku: "PXOH",
    categories: [
      Categories(
        id: 21,
        name: "IMPLEMENTOS",
        slug: "implementos"
      )
    ]
  ),
  Product(
    id: 5,
    name:"Shaker" ,
    price: "29.90",
    description: "",
    images: [
      Images(
        id: 5,
        src: "resources/shop/shaker.jpg",
      )
    ],
    sku: "CH3-1",
    categories: [
      Categories(
        id: 21,
        name: "IMPLEMENTOS",
        slug: "implementos"
      )
    ]
  ),
  Product(
    id: 6,
    name:"Toalla Xiprofit" ,
    price: "29.90",
    description: "",
    images: [
      Images(
        id: 6,
        src: "resources/shop/toalla.jpg",
      )
    ],
    sku: "TXP",
    categories: [
      Categories(
        id: 21,
        name: "IMPLEMENTOS",
        slug: "implementos"
      )
    ]
  ),
  Product(
    id: 7,
    name:"PACK ISOXIPRO Whey protein isolate + Shaker + Tobillera" ,
    price: "229.00",
    description: "Proteína en polvo de suero de leche aislada de 900g  (30 servicios),Contiene 25gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    images: [
      Images(
        id: 7,
        src: "resources/shop/pack-isoxipro-shaker-tobillera.jpg",
      )
    ],
    sku: "PIPT-1-1",
    categories: [
      Categories(
        id: 20,
        name: "PROMOCIONES",
        slug: "promociones"
      ),
      Categories(
        id: 18,
        name: "PROTEINA",
        slug: "proteina"
      )
    ]
  ),
  Product(
    id: 8,
    name:"PACK ISOXIPRO Whey protein isolate + Shaker" ,
    price: "209.00",
    description: "Proteína en polvo de suero de leche aislada de 900g  (30 servicios),Contiene 25gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    images: [
      Images(
        id: 8,
        src: "resources/shop/pack-isoxipro-shaker.jpg",
      )
    ],
    sku: "PIPT-1",
    categories: [
      Categories(
        id: 20,
        name: "PROMOCIONES",
        slug: "promociones"
      ),
      Categories(
        id: 18,
        name: "PROTEINA",
        slug: "proteina"
      )
    ]
  ),
  Product(
    id: 9,
    name:"Pack DUO Whey Protein y Colágeno Hidrolizado" ,
    price: "288.00",
    description: "Isoxipro proteína en polvo de suero de leche aislada de 900g (30 servicios), Contiene 25gr de proteína por servicio. Es baja en grasa, sin lactosa, baja carbohidratos y sin azúcar. Materia prima importada WPI 95%.",
    images: [
      Images(
        id: 9,
        src: "resources/shop/pack-duo-isoxipro-colageno.jpg",
      )
    ],
    sku: "PPC",
    categories: [
      Categories(
        id: 20,
        name: "PROMOCIONES",
        slug: "promociones"
      )
    ]
  ),
  Product(
    id: 9,
    name:"Pack DUO Whey Protein Isolate" ,
    price: "338.00",
    description: "¡Llévate 2 proteínas!",
    images: [
      Images(
        id: 10,
        src: "resources/shop/pack-duo-isoxipro.jpg",
      )
    ],
    sku: "PWI",
    categories: [
      Categories(
        id: 20,
        name: "PROMOCIONES",
        slug: "promociones"
      )
    ]
  ),
  Product(
    id: 10,
    name:"ISOXIPRO Whey protein isolate – Chocolate" ,
    price: "179.00",
    description: "Proteína en polvo de suero de leche aislada de 1kg  (33 servicios aproximadamente),Contiene 24gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    images: [
      Images(
        id: 11,
        src: "resources/shop/isoxipro-chocolate.jpg",
      )
    ],
    sku: "PWCH",
    categories: [
      Categories(
        id: 18,
        name: "PROTEINA",
        slug: "proteina"
      )
    ]
  ),
  Product(
    id: 11,
    name:"Colágeno Hidrolizado" ,
    price: "139.00",
    description: "Beneficios del Colágeno Hidrolizado",
    images: [
      Images(
        id: 12,
        src: "resources/shop/colageno-hidrolizado.jpg",
      )
    ],
    sku: "CH2",
    categories: [
      Categories(
        id: 16,
        name: "COLÁGENO",
        slug: "colageno"
      )
    ]
  )
];