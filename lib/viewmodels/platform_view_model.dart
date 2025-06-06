import 'package:flutter/foundation.dart';
import '../models/platform_model.dart';
import '../models/ranking_model.dart';
import '../models/ranking_date_model.dart';
import '../services/platform_service.dart';
import '../services/ranking_service.dart';

class PlatformViewModel extends ChangeNotifier {
  final PlatformService _platformService = PlatformService();
  final RankingService _rankingService = RankingService();
  
  List<Platform> _platforms = [];
  Platform? _selectedPlatform;
  List<Ranking> _rankings = [];
  Ranking? _selectedRanking;
  List<String> _labels = [];
  List<RankingDate> _rankingDates = [];
  bool _isLoading = false;
  bool _isLoadingDetails = false;
  bool _isLoadingRankings = false;
  bool _isLoadingRankingDetails = false;
  bool _isLoadingLabels = false;
  bool _isLoadingDates = false;
  String _error = '';
  String _detailsError = '';
  String _rankingsError = '';
  String _rankingDetailsError = '';
  String _labelsError = '';
  String _datesError = '';
  String _currentLanguage = 'zh';

  List<Platform> get platforms => _platforms;
  Platform? get selectedPlatform => _selectedPlatform;
  List<Ranking> get rankings => _rankings;
  Ranking? get selectedRanking => _selectedRanking;
  List<String> get labels => _labels;
  List<RankingDate> get rankingDates => _rankingDates;
  bool get isLoading => _isLoading;
  bool get isLoadingDetails => _isLoadingDetails;
  bool get isLoadingRankings => _isLoadingRankings;
  bool get isLoadingRankingDetails => _isLoadingRankingDetails;
  bool get isLoadingLabels => _isLoadingLabels;
  bool get isLoadingDates => _isLoadingDates;
  String get error => _error;
  String get detailsError => _detailsError;
  String get rankingsError => _rankingsError;
  String get rankingDetailsError => _rankingDetailsError;
  String get labelsError => _labelsError;
  String get datesError => _datesError;
  String get currentLanguage => _currentLanguage;

  Future<void> fetchPlatforms({String? language}) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (language != null) {
        _currentLanguage = language;
      }

      _platforms = await _platformService.getPlatforms(language: _currentLanguage);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _platforms = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPlatformDetails(String platformId) async {
    try {
      _isLoadingDetails = true;
      _detailsError = '';
      notifyListeners();

      _selectedPlatform = await _platformService.getPlatformDetails(
        platformId,
        language: _currentLanguage,
      );
      
      // Fetch rankings for the selected platform
      await fetchPlatformRankings(platformId);
    } catch (e) {
      _detailsError = e.toString();
      _selectedPlatform = null;
    } finally {
      _isLoadingDetails = false;
      notifyListeners();
    }
  }

  Future<void> fetchPlatformRankings(String? platformId) async {
    try {
      _isLoadingRankings = true;
      _rankingsError = '';
      notifyListeners();

      _rankings = await _rankingService.getPlatformRankings(
        platformId: platformId,
        language: _currentLanguage,
      );
    } catch (e) {
      _rankingsError = e.toString();
      _rankings = [];
    } finally {
      _isLoadingRankings = false;
      notifyListeners();
    }
  }

  void setLanguage(String language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      fetchPlatforms();
      if (_selectedPlatform != null) {
        fetchPlatformDetails(_selectedPlatform!.id);
      }
    }
  }

  void clearSelectedPlatform() {
    _selectedPlatform = null;
    _detailsError = '';
    _rankings = [];
    _rankingsError = '';
    _selectedRanking = null;
    _rankingDetailsError = '';
    _labels = [];
    _labelsError = '';
    _rankingDates = [];
    _datesError = '';
    notifyListeners();
  }

  Future<void> fetchRankingDetails(String rankingId) async {
    try {
      _isLoadingRankingDetails = true;
      _rankingDetailsError = '';
      notifyListeners();

      _selectedRanking = await _rankingService.getRankingDetails(
        rankingId,
        language: _currentLanguage,
      );

      // After getting ranking details, fetch its labels and dates
      await Future.wait([
        fetchRankingLabels(rankingId),
        fetchRankingDates(rankingId),
      ]);
    } catch (e) {
      _rankingDetailsError = e.toString();
      _selectedRanking = null;
    } finally {
      _isLoadingRankingDetails = false;
      notifyListeners();
    }
  }

  Future<void> fetchRankingLabels(String rankingId) async {
    try {
      _isLoadingLabels = true;
      _labelsError = '';
      notifyListeners();

      _labels = await _rankingService.getRankingLabels(
        rankingId,
        language: _currentLanguage,
      );
    } catch (e) {
      _labelsError = e.toString();
      _labels = [];
    } finally {
      _isLoadingLabels = false;
      notifyListeners();
    }
  }

  Future<void> fetchRankingDates(String rankingId) async {
    try {
      _isLoadingDates = true;
      _datesError = '';
      notifyListeners();

      _rankingDates = await _rankingService.getRankingDates(
        rankingId,
        language: _currentLanguage,
      );
    } catch (e) {
      _datesError = e.toString();
      _rankingDates = [];
    } finally {
      _isLoadingDates = false;
      notifyListeners();
    }
  }

  void clearSelectedRanking() {
    _selectedRanking = null;
    _rankingDetailsError = '';
    _labels = [];
    _labelsError = '';
    _rankingDates = [];
    _datesError = '';
    notifyListeners();
  }
} 