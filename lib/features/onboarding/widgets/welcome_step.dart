import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAnimationBuilder<double>(
              control: Control.play,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.5 + (value * 0.5),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.amber.withOpacity(0.3),
                            Colors.amber.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 80,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            
            CustomAnimationBuilder<Offset>(
              control: Control.play,
              tween: Tween<Offset>(
                begin: const Offset(0, 50),
                end: Offset.zero,
              ),
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Transform.translate(
                  offset: value,
                  child: Column(
                    children: [
                      Text(
                        '당신만의 별자리를\n만들어보세요',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '몇 가지 질문에 답하시면\n7명의 현자들이 당신에게 맞는\n맞춤형 조언을 제공해드립니다',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
            
            CustomAnimationBuilder<double>(
              control: Control.play,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Opacity(
                  opacity: value,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildFeatureIcon(Icons.psychology, '개인화된\n분석'),
                            _buildFeatureIcon(Icons.forum, '7명의\n현자'),
                            _buildFeatureIcon(Icons.insights, '맞춤형\n조언'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '점성술, 사주, 타로, 심리학 등\n다양한 관점에서 당신을 이해합니다',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white60,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.amber,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}