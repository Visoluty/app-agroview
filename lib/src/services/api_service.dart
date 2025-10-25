import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api_model.dart';
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3055/api';
  late Dio dio;
  String? _token;

  ApiService() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expirado, tentar renovar
          await _refreshToken();
          // Tentar novamente a requisição
          final response = await dio.fetch(error.requestOptions);
          handler.resolve(response);
        } else {
          handler.next(error);
        }
      },
    ));

    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    _token = token;
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('refresh_token');
    _token = null;
  }

  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');
      
      if (refreshToken == null) return false;

      final response = await dio.post('/auth/refresh-token', data: {
        'refreshToken': refreshToken,
      });

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data['data']);
        await _saveToken(authResponse.token);
        await prefs.setString('refresh_token', authResponse.refreshToken);
        return true;
      }
    } catch (e) {
      print('Erro ao renovar token: $e');
    }
    return false;
  }

  Future<ApiResponse<AuthResponse>> login(UserLoginRequest request) async {
    try {
      final response = await dio.post('/auth/login', data: request.toJson());
      
      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data['data']);
        await _saveToken(authResponse.token);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('refresh_token', authResponse.refreshToken);
        
        return ApiResponse.fromJson(response.data, (data) => authResponse);
      } else {
        return ApiResponse.error('Erro no login');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<AuthResponse>> register(UserRegisterRequest request) async {
    try {
      final response = await dio.post('/auth/register', data: request.toJson());
      
      if (response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(response.data['data']);
        await _saveToken(authResponse.token);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('refresh_token', authResponse.refreshToken);
        
        return ApiResponse.fromJson(response.data, (data) => authResponse);
      } else {
        return ApiResponse.error('Erro no cadastro');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<User>> getProfile() async {
    try {
      final response = await dio.get('/auth/profile');
      
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => user);
      } else {
        return ApiResponse.error('Erro ao obter perfil');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<User>> updateProfile({
    String? name,
    String? email,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;

      final response = await dio.put('/auth/profile', data: data);
      
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);
        return ApiResponse.fromJson(response.data, (data) => user);
      } else {
        return ApiResponse.error('Erro ao atualizar perfil');
      }
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');
      
      if (refreshToken != null) {
        await dio.post('/auth/logout', data: {'refreshToken': refreshToken});
      }
      
      await _clearToken();
      return ApiResponse(message: 'Logout realizado com sucesso', success: true);
    } catch (e) {
      await _clearToken();
      return ApiResponse.error('Erro no logout: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> logoutAll() async {
    try {
      await dio.post('/auth/logout-all');
      await _clearToken();
      return ApiResponse(message: 'Logout de todos os dispositivos realizado', success: true);
    } catch (e) {
      await _clearToken();
      return ApiResponse.error('Erro no logout: ${e.toString()}');
    }
  }

  bool get isAuthenticated => _token != null;
}
