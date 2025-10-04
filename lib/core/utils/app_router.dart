import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/home_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/sage/sage_screen.dart';
import '../../features/conversation/conversation_screen.dart';
import '../../features/quest/quest_screen.dart';

// 스플래시 화면 - 자동으로 홈화면으로 이동
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    print('🚀 SplashScreen: 초기화 시작');
    // 2초 후 홈화면으로 이동
    await Future.delayed(const Duration(seconds: 2));
    print('🚀 SplashScreen: 홈화면으로 이동 시도');
    if (mounted) {
      print('🚀 SplashScreen: 홈화면으로 이동 실행');
      context.go(AppRouter.home);
    } else {
      print('❌ SplashScreen: mounted가 false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'KAIROS와 7명의 현자',
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}

// OnboardingScreen은 이제 features/onboarding/onboarding_screen.dart에서 가져옴

// HomeScreen은 이제 features/home/home_screen.dart에서 가져옴

// SageScreen은 이제 features/sage/sage_screen.dart에서 가져옴

// ConversationScreen은 이제 features/conversation/conversation_screen.dart에서 가져옴

// QuestScreen은 이제 features/quest/quest_screen.dart에서 가져옴

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '프로필',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String sage = '/sage/:sageId';
  static const String conversation = '/sage/:sageId/conversation';
  static const String quest = '/quest';
  static const String profile = '/profile';

  static String sageRoute(String sageId) => '/sage/$sageId';
  static String conversationRoute(String sageId) => '/sage/$sageId/conversation';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRouter.splash,
    routes: [
      GoRoute(
        path: AppRouter.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRouter.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRouter.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRouter.sage,
        name: 'sage',
        builder: (context, state) {
          final sageId = state.pathParameters['sageId']!;
          return SageScreen(sageId: sageId);
        },
        routes: [
          GoRoute(
            path: 'conversation',
            name: 'conversation',
            builder: (context, state) {
              final sageId = state.pathParameters['sageId']!;
              return ConversationScreen(sageId: sageId);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRouter.quest,
        name: 'quest',
        builder: (context, state) => const QuestScreen(),
      ),
      GoRoute(
        path: AppRouter.profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('페이지를 찾을 수 없습니다: ${state.error}'),
      ),
    ),
  );
});