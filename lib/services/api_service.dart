import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/repo_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.github.com',
    headers: {'Accept': 'application/vnd.github+json'},
  ));

  Future<UserModel> fetchUser(String username) async {
    try {
      final res = await _dio.get('/users/$username');
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<RepoModel>> fetchRepos(String username) async {
    try {
      final res = await _dio.get('/users/$username/repos?per_page=200');
      final list = (res.data as List).map((e) => RepoModel.fromJson(e)).toList();
      return list;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final status = e.response!.statusCode;
      if (status == 404) return Exception('Not found (404).');
      if (status == 403) return Exception('Rate limited or forbidden (403).');
      return Exception('API error: $status');
    } else {
      return Exception('Network error: ${e.message}');
    }
  }
}
