import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:ui';

import '../../shared/widgets/background_effects.dart';
import '../../shared/widgets/carousel_3d.dart';
import '../../shared/providers/sage_provider.dart';
import '../../shared/models/sage_model.dart';
import '../../core/utils/app_router.dart';
import '../consultation/consultation_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  String _searchQuery = '';
  bool _showRoundtable = false;
  
  late AnimationController _celestialController;
  late AnimationController _parallaxController;
  late AnimationController _pulseController;
  
  double _parallaxOffset = 0.0;
  double _previousPanPosition = 0.0;

  @override
  void initState() {
    super.initState();
    print('🏠 HomeScreen: 초기화됨');
    
    _celestialController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
    
    _parallaxController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _celestialController.dispose();
    _parallaxController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sageState = ref.watch(sageProvider);
    
    // 로딩 상태 처리
    if (sageState.isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
        ),
      );
    }
    
    // 에러 상태 처리
    if (sageState.errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '오류가 발생했습니다',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                sageState.errorMessage!,
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 프로바이더 새로고침
                  ref.invalidate(sageProvider);
                },
                child: Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }
    
    final filteredSages = _searchQuery.isEmpty 
        ? sageState.sages 
        : ref.read(sageProvider.notifier).searchSages(_searchQuery);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 우주 배경
          EnhancedCosmicBackground(
            parallaxController: _parallaxController,
            celestialController: _celestialController,
            parallaxOffset: _parallaxOffset,
          ),
          
          // 메인 콘텐츠 - 3D Carousel 중심
          SafeArea(
            child: Column(
              children: [
                // 상단 여백
                const SizedBox(height: 60),
                
                // 앱 타이틀
                Text(
                  'KAIROS',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w100,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 8,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  '현자들의 원탁',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.6),
                    letterSpacing: 2,
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // 3D Carousel - 메인
                Expanded(
                  child: _build3DCarousel(sageState.sages),
                ),
                
                // 하단 액션 버튼
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _buildActionButton(),
                ),
              ],
            ),
          ),
          
          // 미묘한 파티클 효과
          ParticleOverlayWidget(
            pulseController: _pulseController,
          ),
        ],
      ),
    );
  }

  // 환영 메시지 모달
  void _showWelcomeModal() {
    final welcomeMessages = [
      '영혼의 천구의에 오신 것을 환영합니다',
      '이곳은 시공을 초월한 지혜의 성역입니다',
      '7명의 현자들이 당신을 기다리고 있습니다',
      '그들의 지혜로 당신의 길을 밝혀보세요',
      '우주의 신비가 당신에게 열릴 것입니다',
    ];

    int currentMessageIndex = 0;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentMessageIndex++;
                  if (currentMessageIndex >= welcomeMessages.length) {
                    Navigator.of(context).pop();
                  }
                });
              },
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    child: Container(
                      key: ValueKey(currentMessageIndex),
                      padding: const EdgeInsets.all(40),
                      child: Text(
                        currentMessageIndex < welcomeMessages.length
                            ? welcomeMessages[currentMessageIndex]
                            : '',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          height: 1.6,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _navigateToSage(SageModel sage) {
    ref.read(sageProvider.notifier).selectSage(sage.id);
    context.push(AppRouter.sageRoute(sage.id));
  }

  // 3D Carousel 빌드
  Widget _build3DCarousel(List<SageModel> sages) {
    if (sages.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        return Column(
          children: [
            // 3D Carousel
            Expanded(
              child: Carousel3D(
                children: sages.map((sage) => _buildSageCard(sage)).toList(),
                height: 400,
                itemWidth: 250,
                itemHeight: 350,
                radius: 200,
                initialIndex: 0,
                onItemSelected: (index) {
                  setState(() {
                    _selectedSageIndex = index;
                  });
                },
              ),
            ),
            
            // 선택된 현자 정보
            if (_selectedSageIndex < sages.length)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      sages[_selectedSageIndex].displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sages[_selectedSageIndex].specialtyArea,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  int _selectedSageIndex = 0;

  // 깔끔한 현자 카드
  Widget _buildSageCard(SageModel sage) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(int.parse(sage.primaryColor.replaceFirst('#', '0xFF')))
                .withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 현자 이미지
            Image.asset(
              sage.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Color(int.parse(sage.primaryColor.replaceFirst('#', '0xFF')))
                      .withOpacity(0.3),
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white.withOpacity(0.8),
                  ),
                );
              },
            ),
            
            // 그라데이션 오버레이
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            
            // 현자 정보
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sage.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sage.specialtyArea,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 하단 액션 버튼
  Widget _buildActionButton() {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            if (_selectedSageIndex < ref.read(sageProvider).sages.length) {
              final selectedSage = ref.read(sageProvider).sages[_selectedSageIndex];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ConsultationScreen(sage: selectedSage),
                ),
              );
            }
          },
          child: Center(
            child: Text(
              '상담 시작',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}