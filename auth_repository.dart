import 'package:dio/dio.dart';
class AuthRepository {
  // Create Users / Student
  Future<Map<String, dynamic>> createUser({
    required String nama,
    required String username,
    required String password,
  }) async {
    final Dio dio = Dio();

    final Map<String, dynamic> body = {
      'nama': nama,
      'username': username,
      'password': password,
    };

    final response = dio.post("https://news-rpl-api.vercel.app/api/users", data: body);
  }

  final dataResponse = response.data;

  final.dataUser = dataResponse['user'];

  return {
    'dataUser': Student.fromJson(dataUser)};
  } catch (e) {
    throw Exception(e.toString());
  }
