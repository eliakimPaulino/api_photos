import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/models.dart';

class PhotosRepository {
  final http.Client _httpClient;

  PhotosRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const String _unsplashBaseUrl = 'https://api.unsplash.com';
  static const int numPerPage = 10;

  Future<List<Photo>> searchPhotos({
    required String query,
    int page = 1,
  }) async {
    try {
      final url =
          '$_unsplashBaseUrl/search/photos?client_id=${dotenv.get('UNSPLASH_ACCESS_TOKEN')}&page=$page&per_page=$numPerPage&query=$query';
      final response = await _httpClient.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final results =
            List<Map<String, dynamic>>.from(data['results'] as List);
        print(results);
        return results.map(Photo.fromMap).toList();
      }
      throw const CustomException('Something went wrong!');
    } catch (_) {
      throw const CustomException('Something went wrong!');
    }
  }
}
