import 'package:flutter/material.dart';
import 'dart:math' as math;

class Carousel3D extends StatefulWidget {
  final List<Widget> children;
  final double height;
  final double itemWidth;
  final double itemHeight;
  final double radius;
  final ValueChanged<int>? onItemSelected;
  final int initialIndex;
  final Duration animationDuration;
  final Curve animationCurve;
  
  const Carousel3D({
    super.key,
    required this.children,
    this.height = 300,
    this.itemWidth = 200,
    this.itemHeight = 250,
    this.radius = 150,
    this.onItemSelected,
    this.initialIndex = 0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<Carousel3D> createState() => _Carousel3DState();
}

class _Carousel3DState extends State<Carousel3D>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  
  double _currentRotation = 0;
  int _currentIndex = 0;
  double _angleStep = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _angleStep = (2 * math.pi) / widget.children.length;
    _currentRotation = -_angleStep * _currentIndex;
    
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    
    _rotationAnimation = Tween<double>(
      begin: _currentRotation,
      end: _currentRotation,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _rotateTo(int index) {
    if (index == _currentIndex) return;
    
    final targetRotation = -_angleStep * index;
    
    // 최단 경로로 회전하도록 계산
    double rotationDiff = targetRotation - _currentRotation;
    
    if (rotationDiff > math.pi) {
      rotationDiff -= 2 * math.pi;
    } else if (rotationDiff < -math.pi) {
      rotationDiff += 2 * math.pi;
    }
    
    final newRotation = _currentRotation + rotationDiff;
    
    _rotationAnimation = Tween<double>(
      begin: _currentRotation,
      end: newRotation,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ));
    
    _animationController.reset();
    _animationController.forward().then((_) {
      _currentRotation = newRotation;
      _currentIndex = index;
    });
    
    widget.onItemSelected?.call(index);
  }

  void _snapToNearestCard() {
    // 현재 회전값을 기준으로 가장 가까운 카드 찾기
    final normalizedRotation = _currentRotation % (2 * math.pi);
    final targetIndex = ((-normalizedRotation / _angleStep) % widget.children.length).round() % widget.children.length;
    
    _rotateTo(targetIndex);
  }

  Widget _buildCarouselItem(int index) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        final rotation = _rotationAnimation.value;
        final itemAngle = _angleStep * index + rotation;

        // --- 여기서부터 수정 ---

        // 3D 위치 계산
        final x = widget.radius * math.sin(itemAngle); // sin으로 변경하여 정면이 0도가 되도록 함
        final z = widget.radius * math.cos(itemAngle); // cos으로 변경

        // Z축 거리를 0~1 사이로 정규화 (정면이 1, 뒷면이 0)
        final normalizedDistance = (z + widget.radius) / (2 * widget.radius);

        // ✨ 변경 1: 스케일 변화를 더 드라마틱하게 (pow 사용)
        // 정면(1.0)과 뒷면(0.4)의 크기 차이를 더 크게 만듭니다.
        final scale = 0.4 + math.pow(normalizedDistance, 2) * 0.6;

        // ✨ 변경 2: 투명도 변화도 더 크게
        // 뒤로 갈수록 훨씬 투명해집니다.
        final opacity = 0.2 + math.pow(normalizedDistance, 3) * 0.8;

        // ✨ 변경 3: 옆 아이템에 기울기(Y축 회전) 효과 추가
        // 아이템의 현재 각도(itemAngle)의 sin 값을 사용하여 기울기를 계산합니다.
        // 정면(sin(0)=0)에서는 기울기가 없고, 양 옆으로 갈수록 기울기가 커집니다.
        final rotationY = itemAngle;

        // ✨ 변경 4: Z축이 멀어질수록 아이템을 살짝 아래로 이동
        final offsetY = (1 - normalizedDistance) * -50;


        return Positioned(
          // 위치 계산시 x값을 중심으로 정렬
          left: (MediaQuery.of(context).size.width - widget.itemWidth) / 2 + x,
          top: (widget.height - widget.itemHeight) / 2 + offsetY, // offsetY 추가
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0), // clamp 범위 수정
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // 원근 효과
                ..translate(0.0, 0.0, -z) // Z축 위치에 따라 앞/뒤로 이동
                ..rotateY(rotationY) // Y축 회전 추가
                ..scale(scale.clamp(0.0, 1.0)), // clamp 범위 수정
              child: GestureDetector(
                onTap: () => _rotateTo(index),
                child: SizedBox(
                  width: widget.itemWidth,
                  height: widget.itemHeight,
                  child: widget.children[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _animationController.stop();
      },
      onPanUpdate: (details) {
        // 드래그 감도 조절
        final sensitivity = 0.005;
        final deltaX = details.delta.dx;
        
        // 새로운 회전값 계산
        final newRotation = _currentRotation + (deltaX * sensitivity);
        
        // 즉시 회전 적용
        setState(() {
          _currentRotation = newRotation;
          _rotationAnimation = AlwaysStoppedAnimation(_currentRotation);
        });
      },
      onPanEnd: (details) {
        // 가장 가까운 카드로 스냅
        _snapToNearestCard();
      },
      child: SizedBox(
        height: widget.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 배경 그라데이션
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
            // 캐로셀 아이템들
            ...List.generate(
              widget.children.length,
              (index) => _buildCarouselItem(index),
            ),
          ],
        ),
      ),
    );
  }
}