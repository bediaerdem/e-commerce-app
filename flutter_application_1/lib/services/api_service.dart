import 'dart:convert';

import 'package:flutter_application_1/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://dummyjson.com/products";

  Future<ProductsModel> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data =jsonDecode(response.body);
      return ProductsModel.fromJson(data);
    } else {
      throw Exception("An error occurred accessing the API.");
    }
  }
}