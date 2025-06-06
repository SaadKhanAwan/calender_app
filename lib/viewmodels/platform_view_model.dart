import 'package:flutter/foundation.dart';
import '../models/platform_model.dart';
import '../services/platform_service.dart';

class PlatformViewModel extends ChangeNotifier {
  final PlatformService _platformService = PlatformService();
  
  List<Platform> _platforms = [];
  Platform? _selectedPlatform;
  bool _isLoading = false;
  bool _isLoadingDetails = false;
  String _error = '';
  String _detailsError = '';
  String _currentLanguage = 'zh';

  List<Platform> get platforms => _platforms;
  Platform? get selectedPlatform => _selectedPlatform;
  bool get isLoading => _isLoading;
  bool get isLoadingDetails => _isLoadingDetails;
  String get error => _error;
  String get detailsError => _detailsError;
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
    } catch (e) {
      _detailsError = e.toString();
      _selectedPlatform = null;
    } finally {
      _isLoadingDetails = false;
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
    notifyListeners();
  }
} 