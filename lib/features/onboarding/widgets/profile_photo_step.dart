import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/onboarding_provider.dart';

class ProfilePhotoStep extends ConsumerWidget {
  const ProfilePhotoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);
    final hasProfileImage = onboardingState.data.profileImagePath?.isNotEmpty == true;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          
          // 프로필 이미지 영역
          GestureDetector(
            onTap: () => _selectProfileImage(ref),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
                border: Border.all(
                  color: hasProfileImage ? Colors.amber : Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: hasProfileImage
                  ? ClipOval(
                      child: Container(
                        color: Colors.amber.withOpacity(0.2),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.amber,
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '사진 추가',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            hasProfileImage ? '사진이 등록되었습니다' : '프로필 사진을 등록해보세요',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 12),
          
          Text(
            '솔론 현자의 관상학 분석에 활용됩니다',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),
          
          // 설명 카드
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.purple.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.face,
                        color: Colors.purple,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '솔론의 관상학',
                            style: TextStyle(
                              color: Colors.purple.shade200,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '얼굴의 형태와 특징을 분석하여\n성격과 운세를 해석합니다',
                            style: TextStyle(
                              color: Colors.purple.shade200,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '• 정면을 바라보는 자연스러운 표정의 사진을 권장합니다\n'
                  '• 사진은 분석 후 즉시 비식별화 처리됩니다\n'
                  '• 언제든 삭제할 수 있습니다',
                  style: TextStyle(
                    color: Colors.purple.shade300,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // 건너뛰기 안내
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '이 단계는 선택사항입니다. 건너뛰어도 다른 현자들과의 상담에는 영향이 없습니다.',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectProfileImage(WidgetRef ref) {
    // 실제 구현에서는 image_picker 패키지를 사용하여 갤러리나 카메라에서 이미지 선택
    // 현재는 더미 구현
    ref.read(onboardingProvider.notifier).updateProfileImage('dummy_profile_image_path');
    
    // 사용자에게 피드백 제공
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('사진이 등록되었습니다')),
    // );
  }
}