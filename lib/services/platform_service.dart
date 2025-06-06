import '../models/platform_model.dart';
import 'base_api_service.dart';

class PlatformService extends BaseApiService {
  Future<List<Platform>> getPlatforms({String language = 'zh'}) async {
    try {
      final response = await get('/api/platform', queryParams: {'language': language});
      
      if (response['code'] == 0 && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Platform.fromJson(json)).toList();
      } else {
        throw Exception(response['msg'] ?? 'Failed to load platforms');
      }
    } catch (e) {
      throw Exception('Failed to load platforms: $e');
    }
  }

  Future<Platform> getPlatformDetails(String platformId, {String language = 'zh'}) async {
    try {
      final response = await get('/api/platform/$platformId', queryParams: {'language': language});
      
      if (response['code'] == 0 && response['data'] != null) {
        return Platform.fromJson(response['data']);
      } else {
        throw Exception(response['msg'] ?? 'Failed to load platform details');
      }
    } catch (e) {
      throw Exception('Failed to load platform details: $e');
    }
  }
} 