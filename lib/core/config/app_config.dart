enum AppEnvironment {
  development,
  staging,
  production,
}

class AppConfig {
  static AppEnvironment _environment = AppEnvironment.development;
  
  static AppEnvironment get environment => _environment;
  
  static void setEnvironment(AppEnvironment env) {
    _environment = env;
  }
  
  // API 설정
  static String get apiBaseUrl {
    switch (_environment) {
      case AppEnvironment.development:
        return 'http://localhost:8000/api';
      case AppEnvironment.staging:
        return 'https://staging-api.kairos-sages.com/api';
      case AppEnvironment.production:
        return 'https://api.kairos-sages.com/api';
    }
  }
  
  // 인증 설정
  static String get authEndpoint => '$apiBaseUrl/auth';
  
  // WebSocket 설정
  static String get websocketUrl {
    switch (_environment) {
      case AppEnvironment.development:
        return 'ws://localhost:8000/ws';
      case AppEnvironment.staging:
        return 'wss://staging-api.kairos-sages.com/ws';
      case AppEnvironment.production:
        return 'wss://api.kairos-sages.com/ws';
    }
  }
  
  // 디버그 모드
  static bool get isDebugMode {
    switch (_environment) {
      case AppEnvironment.development:
        return true;
      case AppEnvironment.staging:
        return true;
      case AppEnvironment.production:
        return false;
    }
  }
  
  // 로깅 레벨
  static LogLevel get logLevel {
    switch (_environment) {
      case AppEnvironment.development:
        return LogLevel.debug;
      case AppEnvironment.staging:
        return LogLevel.info;
      case AppEnvironment.production:
        return LogLevel.error;
    }
  }
  
  // 애널리틱스 설정
  static bool get analyticsEnabled {
    switch (_environment) {
      case AppEnvironment.development:
        return false;
      case AppEnvironment.staging:
        return true;
      case AppEnvironment.production:
        return true;
    }
  }
  
  // Mock 서비스 사용 여부
  static bool get useMockServices {
    switch (_environment) {
      case AppEnvironment.development:
        return true; // 개발 중에는 Mock 서비스 사용
      case AppEnvironment.staging:
        return false;
      case AppEnvironment.production:
        return false;
    }
  }
  
  // AI 모델 설정
  static String get aiModelVersion {
    switch (_environment) {
      case AppEnvironment.development:
        return 'gpt-3.5-turbo';
      case AppEnvironment.staging:
        return 'gpt-4';
      case AppEnvironment.production:
        return 'gpt-4';
    }
  }
  
  // 캐시 설정
  static Duration get cacheExpiration {
    switch (_environment) {
      case AppEnvironment.development:
        return const Duration(minutes: 5);
      case AppEnvironment.staging:
        return const Duration(hours: 1);
      case AppEnvironment.production:
        return const Duration(hours: 24);
    }
  }
}

enum LogLevel {
  debug,
  info,
  warning,
  error,
}