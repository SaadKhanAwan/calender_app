import '../models/ranking_model.dart';
import '../models/ranking_date_model.dart';
import 'base_api_service.dart';

class RankingService extends BaseApiService {
  Future<List<Ranking>> getPlatformRankings({String? platformId, String language = 'zh'}) async {
    try {
      final Map<String, String> queryParams = {'language': language};
      if (platformId != null) {
        queryParams['platformId'] = platformId;
      }

      final response = await get('/api/ranking/platform', queryParams: queryParams);
      
      if (response['code'] == 0 && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Ranking.fromJson(json)).toList();
      } else {
        throw Exception(response['msg'] ?? 'Failed to load rankings');
      }
    } catch (e) {
      throw Exception('Failed to load rankings: $e');
    }
  }

  Future<Ranking> getRankingDetails(String rankingId, {String language = 'zh'}) async {
    try {
      final response = await get(
        '/api/ranking/$rankingId/detail',
        queryParams: {'language': language},
      );
      
      if (response['code'] == 0 && response['data'] != null) {
        return Ranking.fromJson(response['data']);
      } else {
        throw Exception(response['msg'] ?? 'Failed to load ranking details');
      }
    } catch (e) {
      throw Exception('Failed to load ranking details: $e');
    }
  }

  Future<List<String>> getRankingLabels(String rankingId, {String language = 'zh'}) async {
    try {
      final response = await get(
        '/api/ranking/label/$rankingId',
        queryParams: {'language': language},
      );
      
      if (response['code'] == 0 && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((item) => item.toString()).toList();
      } else {
        throw Exception(response['msg'] ?? 'Failed to load ranking labels');
      }
    } catch (e) {
      throw Exception('Failed to load ranking labels: $e');
    }
  }

  Future<List<RankingDate>> getRankingDates(String rankingId, {String language = 'zh'}) async {
    try {
      final response = await get(
        '/api/ranking/hotinfo/$rankingId/dates',
        queryParams: {'language': language},
      );
      
      if (response['code'] == 0 && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => RankingDate.fromJson(json)).toList();
      } else {
        throw Exception(response['msg'] ?? 'Failed to load ranking dates');
      }
    } catch (e) {
      throw Exception('Failed to load ranking dates: $e');
    }
  }
} 