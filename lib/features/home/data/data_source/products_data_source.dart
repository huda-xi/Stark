// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:stark/core/token_manager.dart';
// import 'package:stark/features/home/data/models/products_model.dart';

// class ProductsDataSource {
//    final Dio dio = Dio();

// Future<List<ProductsModel>> getProducts() async {
 
//   try {

//     final token = await TokenManager.getToken();
//     final response = await dio.get(
//       "https://accessories-eshop.runasp.net/api/products",
//        options: Options(
//         headers: {
//           "Authorization": "Bearer $token",
//           'Accept': 'application/json',
//         }
//       )
     
//     );

//     final List data =response.data["items"];

//     return data
//         .map((e) => ProductsModel.fromJson(e))
//         .toList();
//   } catch (e) {
//     if (e is DioException) {
//     log("Status Code: ${e.response?.statusCode}");
//     log("Response: ${e.response?.data}");
//   }
//   else {log("$e");}
//     rethrow;
//   }
// }}


import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stark/core/token_manager.dart';
import 'package:stark/features/home/data/models/products_model.dart';

class ProductsDataSource {
  final Dio dio = Dio();

  Future<List<ProductsModel>> getProducts() async {
    try {
      final token = await TokenManager.getToken();

      log('Token exists: ${token != null && token.isNotEmpty}');

      if (token == null || token.isEmpty) {
        throw Exception('Token is missing. Please login first.');
      }

      final response = await dio.get(
        'https://accessories-eshop.runasp.net/api/products',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      log('Status: ${response.statusCode}');
      log('Response type: ${response.data.runtimeType}');
      log('Response data: ${response.data}');

      final responseData = response.data;

      if (responseData is! Map<String, dynamic>) {
        throw Exception(
          'Expected a JSON object, got ${responseData.runtimeType}',
        );
      }

      final items = responseData['items'];

      if (items is! List) {
        throw Exception(
          'Expected items to be a List, got ${items.runtimeType}',
        );
      }

      return items
          .map(
            (e) => ProductsModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    } on DioException catch (e) {
      log('Status Code: ${e.response?.statusCode}');
      log('Response: ${e.response?.data}');
      rethrow;
    } catch (e, stackTrace) {
      log('Products Error: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
