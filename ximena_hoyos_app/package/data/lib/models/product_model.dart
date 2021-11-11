import 'package:flutter/material.dart';

class Product{
  final String image, title, description, sku, category;
  final int id;
  final double price;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.sku,
    required this.category
  });
}

List<Product> products = [
  Product(
    id: 1,
    title:"ISOXIPRO Whey protein isolate – Vainilla" ,
    price: 179.00,
    description: "Proteína en polvo de suero de leche aislada de 900g  (30 servicios),Contiene 25gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    image: "resources/shop/isoxipro-vainilla.jpg",
    sku: "PWV-1",
    category: "PROTEINA"),
  Product(
    id: 2,
    title:"Muñequera" ,
    price: 39.90,
    description: "",
    image: "resources/shop/muñequera.jpg",
    sku: "MHOX",
    category: "IMPLEMENTOS"),
  Product(
    id: 3,
    title:"Vincha" ,
    price: 24.90,
    description: "",
    image: "resources/shop/vincha.jpg",
    sku: "CH3-1-1",
    category: "IMPLEMENTOS"),
  Product(
    id: 4,
    title:"Polera XOH" ,
    price: 89.00,
    description: "",
    image: "resources/shop/polera.jpg",
    sku: "PXOH",
    category: "IMPLEMENTOS"),
  Product(
    id: 5,
    title:"Shaker" ,
    price: 29.90,
    description: "",
    image: "resources/shop/shaker.jpg",
    sku: "CH3-1",
    category: "IMPLEMENTOS"),
  Product(
    id: 6,
    title:"Toalla Xiprofit" ,
    price: 29.90,
    description: "",
    image: "resources/shop/toalla.jpg",
    sku: "TXP",
    category: "IMPLEMENTOS"),
  Product(
    id: 7,
    title:"PACK ISOXIPRO Whey protein isolate + Shaker + Tobillera" ,
    price: 229.00,
    description: "Proteína en polvo de suero de leche aislada de 900g  (30 servicios),Contiene 25gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    image: "resources/shop/pack-isoxipro-shaker-tobillera.jpg",
    sku: "PIPT-1-1",
    category: "PROMOCIONES, PROTEINA"),
  Product(
    id: 8,
    title:"PACK ISOXIPRO Whey protein isolate + Shaker" ,
    price: 209.00,
    description: "Proteína en polvo de suero de leche aislada de 900g  (30 servicios),Contiene 25gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    image: "resources/shop/pack-isoxipro-shaker.jpg",
    sku: "PIPT-1",
    category: "PROMOCIONES, PROTEINA"),
  Product(
    id: 9,
    title:"Pack DUO Whey Protein y Colágeno Hidrolizado" ,
    price: 288.00,
    description: "Isoxipro proteína en polvo de suero de leche aislada de 900g (30 servicios), Contiene 25gr de proteína por servicio. Es baja en grasa, sin lactosa, baja carbohidratos y sin azúcar. Materia prima importada WPI 95%.",
    image: "resources/shop/pack-duo-isoxipro-colageno.jpg",
    sku: "PPC",
    category: "PROMOCIONES"),
  Product(
    id: 9,
    title:"Pack DUO Whey Protein Isolate" ,
    price: 338.00,
    description: "¡Llévate 2 proteínas!",
    image: "resources/shop/pack-duo-isoxipro.jpg",
    sku: "PWI",
    category: "PROMOCIONES"),
  Product(
    id: 10,
    title:"ISOXIPRO Whey protein isolate – Chocolate" ,
    price: 179.00,
    description: "Proteína en polvo de suero de leche aislada de 1kg  (33 servicios aproximadamente),Contiene 24gr de proteína por servicio. Nuestra proteína es aislada durante el procesado se elimina la mayor parte de la grasa y la lactosa. Este aislado permite obtener mayor cantidad de proteína en el producto final. Es libre de grasa, libre de lactosa, baja carbohidratos y sin azúcar. No contiene aminoácidos de relleno. Suero de leche importado Certified de origing USA-Halal -Kosher-Non-GMO",
    image: "resources/shop/isoxipro-chocolate.jpg",
    sku: "PWCH",
    category: "PROTEINA"),
  Product(
    id: 11,
    title:"Colágeno Hidrolizado" ,
    price: 139.00,
    description: "Beneficios del Colágeno Hidrolizado",
    image: "resources/shop/colageno-hidrolizado.jpg",
    sku: "CH2",
    category: "COLÁGENO")
];