import 'package:dio/dio.dart';
import 'package:stark/core/const.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl$endpoint',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }

      throw Exception(
        'Unexpected response format: ${response.data.runtimeType}',
      );
    } on DioException catch (e) {
      print('DIO TYPE: ${e.type}');
      print('DIO ERROR: ${e.error}');
      print('DIO MESSAGE: ${e.message}');
      print('STATUS CODE: ${e.response?.statusCode}');
      print('RESPONSE: ${e.response?.data}');
      rethrow;
    }
  }

  // ************************ sign up ***********************//

  Future<Map<String, dynamic>> signUpPost({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(
        "$baseUrl$endpoint",
        data: data,
        options: Options(headers: {}),
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }

      throw Exception(
        'Unexpected response format: ${response.data.runtimeType}',
      );
    } on DioException catch (e) {
      print('DIO TYPE: ${e.type}');
      print('DIO ERROR: ${e.error}');
      print('DIO MESSAGE: ${e.message}');
      print('STATUS CODE: ${e.response?.statusCode}');
      print('RESPONSE: ${e.response?.data}');
      rethrow;
    }
  }


 //********************************* verify email ***************************//

 Future<void> verifyEmail({
  required String email,
    required String otp,
 }) async{

  try {
    final response = await dio.post('${baseUrl}api/auth/verify-email',
    data: {
      'email': email,
      'otp':otp
    });


      if (response.statusCode != 200 &&
          response.statusCode != 204) {
        throw Exception('Email verification failed');
      }

  } on DioException catch (e) {
     final data = e.response?.data;

      String message = 'Something went wrong';

      if (data is Map<String, dynamic>) {
        message = data['message']?.toString() ?? message;

        final errors = data['errors'];

        if (errors is Map<String, dynamic>) {
          final generalErrors = errors['generalErrors'];

          if (generalErrors is List &&
              generalErrors.isNotEmpty) {
            message = generalErrors.first.toString();
          }
        }
      }

      throw Exception(message);
  }

  
 }
}
