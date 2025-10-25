import 'dart:io';
import 'package:dio/dio.dart';
import '../models/api_model.dart';
import '../models/analysis_model.dart';
import 'api_service.dart';

class AnalysisService {
  final ApiService _apiService;

  AnalysisService(this._apiService);

  Future<ApiResponse<List<AnalysisHistory>>> getAnalysisHistory({
    int limit = 50,
  }) async {
    try {
      final response = await _apiService.dio.get('/analyses', queryParameters: {
        'limit': limit,
      });
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final analyses = data.map((e) => AnalysisHistory.fromJson(e)).toList();
        return ApiResponse.fromJson(response.data, (data) => analyses);
      } else {
        return ApiResponse.error('Erro ao obter histórico');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<AnalysisHistory>>> getRecentAnalyses({
    int limit = 10,
  }) async {
    try {
      final response = await _apiService.dio.get('/analyses/recent', queryParameters: {
        'limit': limit,
      });
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final analyses = data.map((e) => AnalysisHistory.fromJson(e)).toList();
        return ApiResponse.fromJson(response.data, (data) => analyses);
      } else {
        return ApiResponse.error('Erro ao obter análises recentes');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<AnalysisStats>> getAnalysisStats() async {
    try {
      final response = await _apiService.dio.get('/analyses/stats');
      
      if (response.statusCode == 200) {
        final stats = AnalysisStats.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => stats);
      } else {
        return ApiResponse.error('Erro ao obter estatísticas');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<AnalysisHistory>>> getAnalysisByGrainType(
    String grainType, {
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.dio.get(
        '/analyses/grain-type/$grainType',
        queryParameters: {'limit': limit},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final analyses = data.map((e) => AnalysisHistory.fromJson(e)).toList();
        return ApiResponse.fromJson(response.data, (data) => analyses);
      } else {
        return ApiResponse.error('Erro ao obter análises por tipo de grão');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<Analysis>> getAnalysisById(String id) async {
    try {
      final response = await _apiService.dio.get('/analyses/$id');
      
      if (response.statusCode == 200) {
        final analysis = Analysis.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => analysis);
      } else {
        return ApiResponse.error('Análise não encontrada');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<ProcessImageResponse>> processImage(
    File imageFile,
    String grainType,
  ) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
        'grainType': grainType,
      });

      final response = await _apiService.dio.post(
        '/images/process',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      
      if (response.statusCode == 201) {
        final processResponse = ProcessImageResponse.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => processResponse);
      } else {
        return ApiResponse.error('Erro ao processar imagem');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<ImageInfo>> validateImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await _apiService.dio.post(
        '/images/validate',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final imageInfo = ImageInfo.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => imageInfo);
      } else {
        return ApiResponse.error('Erro ao validar imagem');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<ImageInfo>> getImageInfo(String filename) async {
    try {
      final response = await _apiService.dio.get('/images/info/$filename');
      
      if (response.statusCode == 200) {
        final imageInfo = ImageInfo.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => imageInfo);
      } else {
        return ApiResponse.error('Erro ao obter informações da imagem');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> deleteImage(String filename) async {
    try {
      final response = await _apiService.dio.delete('/images/$filename');
      
      if (response.statusCode == 200) {
        return ApiResponse(message: 'Imagem deletada com sucesso', success: true);
      } else {
        return ApiResponse.error('Erro ao deletar imagem');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<SupportedFormats>> getSupportedFormats() async {
    try {
      final response = await _apiService.dio.get('/images/formats');
      
      if (response.statusCode == 200) {
        final formats = SupportedFormats.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => formats);
      } else {
        return ApiResponse.error('Erro ao obter formatos suportados');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<ComparisonResponse>> compareAnalyses(List<String> analysisIds) async {
    try {
      final response = await _apiService.dio.post('/analyses/compare', data: {
        'analysisIds': analysisIds,
      });
      
      if (response.statusCode == 200) {
        final comparison = ComparisonResponse.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => comparison);
      } else {
        return ApiResponse.error('Erro ao comparar análises');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> deleteAnalysis(String id) async {
    try {
      final response = await _apiService.dio.delete('/analyses/$id');
      
      if (response.statusCode == 200) {
        return ApiResponse(message: 'Análise deletada com sucesso', success: true);
      } else {
        return ApiResponse.error('Erro ao deletar análise');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<int>>> generateReport(String id) async {
    try {
      final response = await _apiService.dio.get(
        '/analyses/$id/report',
        options: Options(responseType: ResponseType.bytes),
      );
      
      if (response.statusCode == 200) {
        final pdfBytes = response.data as List<int>;
        return ApiResponse.fromJson({'message': 'Relatório gerado'}, (data) => pdfBytes);
      } else {
        return ApiResponse.error('Erro ao gerar relatório');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<int>>> exportReport(String id) async {
    try {
      final response = await _apiService.dio.get(
        '/analyses/$id/export',
        options: Options(responseType: ResponseType.bytes),
      );
      
      if (response.statusCode == 200) {
        final pdfBytes = response.data as List<int>;
        return ApiResponse.fromJson({'message': 'Relatório exportado'}, (data) => pdfBytes);
      } else {
        return ApiResponse.error('Erro ao exportar relatório');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }
}
