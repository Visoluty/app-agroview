import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/analysis_model.dart';
import '../models/api_model.dart';
import '../services/analysis_service.dart';

class AnalysisViewModel extends ChangeNotifier {
  final AnalysisService _analysisService;
  
  List<AnalysisHistory> _analysisHistory = [];
  List<AnalysisHistory> _recentAnalyses = [];
  AnalysisStats? _stats;
  Analysis? _currentAnalysis;
  ProcessImageResponse? _processResult;
  
  bool _isLoading = false;
  bool _isProcessingImage = false;
  String? _error;

  AnalysisViewModel(this._analysisService);

  List<AnalysisHistory> get analysisHistory => _analysisHistory;
  List<AnalysisHistory> get recentAnalyses => _recentAnalyses;
  AnalysisStats? get stats => _stats;
  Analysis? get currentAnalysis => _currentAnalysis;
  ProcessImageResponse? get processResult => _processResult;
  bool get isLoading => _isLoading;
  bool get isProcessingImage => _isProcessingImage;
  String? get error => _error;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setProcessingImage(bool processing) {
    _isProcessingImage = processing;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> loadAnalysisHistory({int limit = 50}) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.getAnalysisHistory(limit: limit);
      
      if (response.success && response.data != null) {
        _analysisHistory = response.data!;
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError('Erro ao carregar histórico: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadRecentAnalyses({int limit = 10}) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.getRecentAnalyses(limit: limit);
      
      if (response.success && response.data != null) {
        _recentAnalyses = response.data!;
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError('Erro ao carregar análises recentes: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadAnalysisStats() async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.getAnalysisStats();
      
      if (response.success && response.data != null) {
        _stats = response.data;
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError('Erro ao carregar estatísticas: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadAnalysisById(String id) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.getAnalysisById(id);
      
      if (response.success && response.data != null) {
        _currentAnalysis = response.data;
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError('Erro ao carregar análise: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadAnalysisByGrainType(String grainType, {int limit = 20}) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.getAnalysisByGrainType(grainType, limit: limit);
      
      if (response.success && response.data != null) {
        _analysisHistory = response.data!;
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError('Erro ao carregar análises por tipo: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> processImage(File imageFile, String grainType) async {
    _setProcessingImage(true);
    _setError(null);

    try {
      final response = await _analysisService.processImage(imageFile, grainType);
      
      if (response.success && response.data != null) {
        _processResult = response.data;
        _setProcessingImage(false);
        return true;
      } else {
        _setError(response.message);
        _setProcessingImage(false);
        return false;
      }
    } catch (e) {
      _setError('Erro ao processar imagem: ${e.toString()}');
      _setProcessingImage(false);
      return false;
    }
  }

  Future<bool> validateImage(File imageFile) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.validateImage(imageFile);
      
      if (response.success) {
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Erro ao validar imagem: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> deleteAnalysis(String id) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.deleteAnalysis(id);
      
      if (response.success) {
        // Remove da lista local
        _analysisHistory.removeWhere((analysis) => analysis.id == id);
        _recentAnalyses.removeWhere((analysis) => analysis.id == id);
        
        // Se for a análise atual, limpa
        if (_currentAnalysis?.id == id) {
          _currentAnalysis = null;
        }
        
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Erro ao deletar análise: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> deleteImage(String filename) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.deleteImage(filename);
      
      if (response.success) {
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Erro ao deletar imagem: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<ComparisonResponse?> compareAnalyses(List<String> analysisIds) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.compareAnalyses(analysisIds);
      
      if (response.success && response.data != null) {
        _setLoading(false);
        return response.data;
      } else {
        _setError(response.message);
        _setLoading(false);
        return null;
      }
    } catch (e) {
      _setError('Erro ao comparar análises: ${e.toString()}');
      _setLoading(false);
      return null;
    }
  }

  Future<List<int>?> generateReport(String id) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.generateReport(id);
      
      if (response.success && response.data != null) {
        _setLoading(false);
        return response.data;
      } else {
        _setError(response.message);
        _setLoading(false);
        return null;
      }
    } catch (e) {
      _setError('Erro ao gerar relatório: ${e.toString()}');
      _setLoading(false);
      return null;
    }
  }

  Future<List<int>?> exportReport(String id) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _analysisService.exportReport(id);
      
      if (response.success && response.data != null) {
        _setLoading(false);
        return response.data;
      } else {
        _setError(response.message);
        _setLoading(false);
        return null;
      }
    } catch (e) {
      _setError('Erro ao exportar relatório: ${e.toString()}');
      _setLoading(false);
      return null;
    }
  }

  void clearCurrentAnalysis() {
    _currentAnalysis = null;
    _processResult = null;
    notifyListeners();
  }

  void clearError() {
    _setError(null);
  }

  void clearProcessResult() {
    _processResult = null;
    notifyListeners();
  }
}
