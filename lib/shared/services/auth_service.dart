import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../core/config/app_config.dart';
import '../../data/models/user_model.dart';

abstract class AuthService {
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
  });
  
  Future<AuthResult> signIn({
    required String email,
    required String password,
  });
  
  Future<void> signOut();
  
  Future<bool> isAuthenticated();
  
  Future<UserModel?> getCurrentUser();
  
  Future<void> refreshToken();
}

class ApiAuthService implements AuthService {
  final ApiClient _apiClient;
  
  ApiAuthService(this._apiClient);
  
  @override
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/signup',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );
      
      final user = UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
      final token = response.data['token'] as String;
      
      // 토큰 저장
      await _storeToken(token);
      
      return AuthResult(
        success: true,
        user: user,
        token: token,
      );
    } on ApiException catch (e) {
      return AuthResult(
        success: false,
        error: e.message,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        error: '회원가입에 실패했습니다: $e',
      );
    }
  }
  
  @override
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/signin',
        data: {
          'email': email,
          'password': password,
        },
      );
      
      final user = UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
      final token = response.data['token'] as String;
      
      // 토큰 저장
      await _storeToken(token);
      
      return AuthResult(
        success: true,
        user: user,
        token: token,
      );
    } on ApiException catch (e) {
      return AuthResult(
        success: false,
        error: e.message,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        error: '로그인에 실패했습니다: $e',
      );
    }
  }
  
  @override
  Future<void> signOut() async {
    try {
      await _apiClient.post('/auth/signout');
    } catch (e) {
      // 서버 로그아웃 실패해도 로컬 토큰은 삭제
      print('서버 로그아웃 실패: $e');
    } finally {
      await _removeToken();
    }
  }
  
  @override
  Future<bool> isAuthenticated() async {
    final token = await _getStoredToken();
    return token != null && token.isNotEmpty;
  }
  
  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (!await isAuthenticated()) {
        return null;
      }
      
      final response = await _apiClient.get('/auth/me');
      return UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<void> refreshToken() async {
    try {
      final response = await _apiClient.post('/auth/refresh');
      final newToken = response.data['token'] as String;
      await _storeToken(newToken);
    } on ApiException {
      // 토큰 갱신 실패 시 로그아웃
      await signOut();
      rethrow;
    }
  }
  
  Future<void> _storeToken(String token) async {
    // TODO: Secure Storage에 토큰 저장
    // await SecureStorage.store('auth_token', token);
  }
  
  Future<String?> _getStoredToken() async {
    // TODO: Secure Storage에서 토큰 가져오기
    // return await SecureStorage.get('auth_token');
    return null;
  }
  
  Future<void> _removeToken() async {
    // TODO: Secure Storage에서 토큰 삭제
    // await SecureStorage.delete('auth_token');
  }
}

class MockAuthService implements AuthService {
  @override
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Mock user creation
    final user = UserModel(
      name: name,
      email: email,
      birthDate: DateTime.now(),
      birthTime: null,
      birthPlace: null,
    );
    
    return AuthResult(
      success: true,
      user: user,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
  
  @override
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Mock validation
    if (email.isEmpty || password.isEmpty) {
      return AuthResult(
        success: false,
        error: '이메일과 비밀번호를 입력해주세요.',
      );
    }
    
    // Mock user
    final user = UserModel(
      name: '데모 사용자',
      email: email,
      birthDate: DateTime(1990, 1, 1),
      birthTime: null,
      birthPlace: null,
    );
    
    return AuthResult(
      success: true,
      user: user,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
  
  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock implementation
  }
  
  @override
  Future<bool> isAuthenticated() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true; // Mock: always authenticated
  }
  
  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return UserModel(
      name: '데모 사용자',
      email: 'demo@kairos-sages.com',
      birthDate: DateTime(1990, 1, 1),
      birthTime: null,
      birthPlace: null,
    );
  }
  
  @override
  Future<void> refreshToken() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock implementation
  }
}

class AuthResult {
  final bool success;
  final UserModel? user;
  final String? token;
  final String? error;
  
  const AuthResult({
    required this.success,
    this.user,
    this.token,
    this.error,
  });
}

// 프로바이더
final authServiceProvider = Provider<AuthService>((ref) {
  if (AppConfig.useMockServices) {
    return MockAuthService();
  } else {
    final apiClient = ref.watch(apiClientProvider);
    return ApiAuthService(apiClient);
  }
});