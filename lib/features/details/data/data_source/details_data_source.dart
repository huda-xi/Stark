import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:stark/core/const.dart';
import 'package:stark/features/details/data/models/details_model.dart';

class DetailsDataSource {
  final Dio dio=Dio();

  Future <DetailsModel> getDetails(String id) async{

    try {
      final Response response = await dio.get('${baseUrl}api/products/$id');

      return DetailsModel.fromJson(response.data);
    }  on DioException catch (e) {
      log("Status Code: ${e.response?.statusCode}");
      log("Response: ${e.response?.data}");
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}


     