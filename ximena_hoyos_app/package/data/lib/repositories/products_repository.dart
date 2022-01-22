import 'dart:convert';

import 'package:data/models/product_model.dart';
import 'package:data/repositories/base_repository.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ProductsRepository extends BaseRepository {
  final client = Dio();
  final String username = 'test';
  final String password = '123£';

  final auth = {
		'username': 'ck_fa2789b2e112b28e9c91668b8c212e2db1bff48a',
		'password': 'cs_6e5c8f4ea52c8d92282ec356a6712b3c51f3c706'
	};

  ProductsRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);

  Future<List<Product>> fetchProducts() async {
    String basicAuth = 'Basic Y2tfZmEyNzg5YjJlMTEyYjI4ZTljOTE2NjhiOGMyMTJlMmRiMWJmZjQ4YTpjc182ZTVjOGY0ZWE1MmM4ZDkyMjgyZWMzNTZhNjcxMmIzYzUxZjNjNzA2';
    client.options.baseUrl = API_WOOCOMMERCE_URL;
    
    var response = await client.get(
      '/products',
      options: Options(
        headers: <String, String>{
          'authorization': basicAuth
        }
      ),
      queryParameters: {
        'per_page': '50',
        'stock_status': 'instock'
      }
    );
    
    
    return (response.data as List? ?? [])
        .map((e) => Product.fromJson(e))
        .toList();
  }
}