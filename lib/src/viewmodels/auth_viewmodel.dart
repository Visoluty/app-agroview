import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/api_model.dart';
import '../services/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService apiService;
  
  User? _user;
  bool _isLoading = false;
  String? _error;

  AuthViewModel(this.apiService);

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => apiService.isAuthenticated;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final request = UserLoginRequest(email: email, password: password);
      final response = await apiService.login(request);

      if (response.success && response.data != null) {
        _user = response.data!.user;
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Erro inesperado: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password, String userType) async {
    _setLoading(true);
    _setError(null);

    try {
      final request = UserRegisterRequest(
        name: name,
        email: email,
        password: password,
        userType: userType,
      );
      final response = await apiService.register(request);

      if (response.success && response.data != null) {
        _user = response.data!.user;
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Erro inesperado: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<void> loadUserProfile() async {
    if (!isAuthenticated) return;

    _setLoading(true);
    _setError(null);

    try {
      final response = await apiService.getProfile();
      
      if (response.success && response.data != null) {
        _user = response.data;
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError('Erro ao carregar perfil: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateProfile({String? name, String? email}) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await apiService.updateProfile(name: name, email: email);
      
      if (response.success && response.data != null) {
        _user = response.data;
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Erro inesperado: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    _setError(null);

    try {
      await apiService.logout();
      _user = null;
    } catch (e) {
      _setError('Erro no logout: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logoutAll() async {
    _setLoading(true);
    _setError(null);

    try {
      await apiService.logoutAll();
      _user = null;
    } catch (e) {
      _setError('Erro no logout: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _setError(null);
  }
}
