import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class BaseApiService {
  static const String baseUrl = 'https://att-contents.yikart.cn';

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
      developer.log('API Request: ${uri.toString()}', name: 'API');
      
      final response = await http.get(uri);
      developer.log('API Response Status: ${response.statusCode}', name: 'API');
      developer.log('API Response Body: ${response.body}', name: 'API');
      
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        return decodedResponse;
      } else {
        final error = 'Failed to load data: ${response.statusCode}';
        developer.log('API Error: $error', name: 'API', error: error);
        throw Exception(error);
      }
    } catch (e, stackTrace) {
      developer.log(
        'Network error: $e',
        name: 'API',
        error: e.toString(),
        stackTrace: stackTrace,
      );
      throw Exception('Network error: $e');
    }
  }
} 