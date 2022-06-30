import 'dart:convert';

import 'package:data/models/culqi_charge_model.dart';
import 'package:data/models/products_payload_model.dart';
import 'package:data/models/shop_order.dart';
import 'package:data/models/woocommerce_order_model.dart';
import 'package:data/repositories/base_repository.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../models/page_model.dart';

enum ProductsFilter { all, specificCategory }
class ProductsRepository extends BaseRepository {
  final client = Dio();
  final String username = 'test';
  final String password = '123£';

  final auth = {
		'username': 'ck_fa2789b2e112b28e9c91668b8c212e2db1bff48a',
		'password': 'cs_6e5c8f4ea52c8d92282ec356a6712b3c51f3c706'
	};

  ProductsRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);

  Future<List<Product>> fetchProducts(int page, {ProductsFilter filter = ProductsFilter.all, int? categoryId}) async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    final query;

    if (filter == ProductsFilter.all) {
      query = {'page': page, 'limit': 50};
    } else {
      query = {'page': page, 'limit': 50, 'categoryId': categoryId};
    }
    
    return client
        .get('/api/products', queryParameters: query)
        .then(
            (value) => CustomPage.fromJson(value.data as Map<String, dynamic>? ?? {}))
        .then((value) =>
            value.data!.map((e) => Product.fromJson(e)).toList());
  }

  Future<List<Categories>> fetchProductsCategories() async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;


    var response = await client.get(
      '/api/categories'
    );
    
    return (response.data as List? ?? [])
        .map((e) => Categories.fromJson(e))
        .toList();
  }
  
  Future<bool> createWoocommerceOrder (WoocommerceOrder order) async {
    String basicAuth = 'Basic Y2tfZmEyNzg5YjJlMTEyYjI4ZTljOTE2NjhiOGMyMTJlMmRiMWJmZjQ4YTpjc182ZTVjOGY0ZWE1MmM4ZDkyMjgyZWMzNTZhNjcxMmIzYzUxZjNjNzA2';
    client.options.baseUrl = API_WOOCOMMERCE_URL;

    var orderJson = order.toJson();
    var jsonEncoded = json.encode(orderJson);

    try{
      var response = await client.post(
        '/orders',
        options: Options(
          headers: <String, String>{
            'authorization': basicAuth
          }
        ),
        data: jsonEncoded
      );
      
      if(response.statusMessage == "Created"){
        return true;
      }
      else{
        return false;
      }
    }
    catch(ex){
      return false;
    }
  }

  Future<bool> createOrder (ShopOrder order) async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    var orderJson = order.toJson();
    var jsonEncoded = json.encode(orderJson);

    try{
      var response = await client.post(
        '/api/order/payment',
        data: jsonEncoded
      );
      
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    catch(ex){
      return false;
    }
  }

  Future<bool> createCulqiCharge (CulqiCharge charge) async {
    var apiClient = await this.dio;
    apiClient.options.baseUrl = API_CMS;

    var chargeJson = charge.toJson();
    var jsonEncoded = json.encode(chargeJson);

    try{
      var response = await apiClient.post(
        '/api/culqui/create-charge',
        data: jsonEncoded
      );

      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    catch(ex){
      return false;
    }
  }
}