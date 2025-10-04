import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../models/sage_model.dart';
import '../../core/themes/app_theme.dart';

class SageAvatar extends StatelessWidget {
  final SageModel sage;
  final double size;
  final bool isActive;
  final bool showStatus;
  final VoidCallback? onTap;

  const SageAvatar({
    super.key,
    required this.sage,
    this.size = 80.0,
    this.isActive = false,
    this.showStatus = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvatar(context),
          if (showStatus) ...[
            const SizedBox(height: 8),
            _buildStatus(context),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final primaryColor = _parseColor(sage.primaryColor);
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            primaryColor.withOpacity(0.3),
            primaryColor.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 활성화 상태의 펄스 효과
          if (isActive)
            CustomAnimationBuilder<double>(
              control: Control.loop,
              tween: Tween<double>(begin: 0.8, end: 1.2),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, value, _) {
                return Container(
                  width: size * value,
                  height: size * value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                );
              },
            ),
          
          // 메인 아바타
          Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.2),
              border: Border.all(
                color: primaryColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: _buildAvatarContent(context, primaryColor),
          ),
          
          // 가용성 표시
          if (!sage.isAvailable)
            Container(
              width: size * 0.8,
              height: size * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: const Icon(
                Icons.schedule,
                color: Colors.white70,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent(BuildContext context, Color primaryColor) {
    return ClipOval(
      child: Image.asset(
        sage.imagePath,
        width: size * 0.8,
        height: size * 0.8,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // 이미지 로드 실패 시 대체 콘텐츠
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor.withOpacity(0.8),
                  primaryColor.withOpacity(0.4),
                ],
              ),
            ),
            child: Center(
              child: Text(
                sage.name[0],
                style: TextStyle(
                  fontSize: size * 0.3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: size * 1.5),
      child: Column(
        children: [
          Text(
            sage.displayName,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (sage.statusMessage.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              sage.statusMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          
          // 신뢰도 표시
          if (sage.trustLevel > 0) ...[
            const SizedBox(height: 4),
            _buildTrustIndicator(),
          ],
        ],
      ),
    );
  }

  Widget _buildTrustIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final filled = index < (sage.trustLevel * 5).round();
        return Icon(
          filled ? Icons.star : Icons.star_border,
          size: 12,
          color: filled ? Colors.amber : Colors.white30,
        );
      }),
    );
  }

  Color _parseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
    } catch (e) {
      return AppTheme.accentColor;
    }
  }
}

class SageAvatarGrid extends StatelessWidget {
  final List<SageModel> sages;
  final String? selectedSageId;
  final Function(SageModel)? onSageTap;
  final double avatarSize;
  final int crossAxisCount;

  const SageAvatarGrid({
    super.key,
    required this.sages,
    this.selectedSageId,
    this.onSageTap,
    this.avatarSize = 80.0,
    this.crossAxisCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: sages.length,
      itemBuilder: (context, index) {
        final sage = sages[index];
        return SageAvatar(
          sage: sage,
          size: avatarSize,
          isActive: sage.id == selectedSageId,
          onTap: () => onSageTap?.call(sage),
        );
      },
    );
  }
}