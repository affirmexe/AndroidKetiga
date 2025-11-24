import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> getUsers() async {
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/users',
    );
    return response.data;
  }
}
