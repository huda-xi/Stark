import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stark/core/token_manager.dart';
import 'package:stark/features/categories/data/categories_modwl.dart';

class CategoriesDataSource {
   final Dio dio = Dio();

Future<List<CategoriesModel>> getCategories() async {
 
  try {

    final token = await TokenManager.getToken();
    log("Token exists: ${token != null && token.isNotEmpty}");
    final response = await dio.get(
      "https://accessories-eshop.runasp.net/api/categories",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
        }
      )
    );

    final List data =response.data["categories"];

    return data
        .map((e) => CategoriesModel.fromJson(e))
        .toList();
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}}