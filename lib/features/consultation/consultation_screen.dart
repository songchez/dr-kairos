import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:math' as math;

import '../../shared/models/sage_model.dart';
import '../../shared/widgets/background_effects.dart';
import '../../shared/providers/ai_provider.dart';
import '../../core/constants/sage_constants.dart';

class ConsultationScreen extends ConsumerStatefulWidget {
  final SageModel sage;

  const ConsultationScreen({
    super.key,
    required this.sage,
  });

  @override
  ConsumerState<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends ConsumerState<ConsultationScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  late AnimationController _breathingController;
  late AnimationController _typingController;
  late AnimationController _particleController;
  late VideoPlayerController _videoController;
  
  List<ChatMessage> _messages = [];
  bool _isTyping = false;
  String _currentStreamingMessage = '';
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    
    _breathingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // 비디오 초기화
    _initializeVideo();

    // 현자 인사말
    _addWelcomeMessage();
  }

  void _initializeVideo() {
    final videoPath = SageConstants.sageVideos[widget.sage.type];
    if (videoPath != null) {
      try {
        _videoController = VideoPlayerController.asset(videoPath);
        _videoController.initialize().then((_) {
          if (mounted) {
            setState(() {
              _isVideoInitialized = true;
            });
            _videoController.setLooping(true);
            _videoController.setVolume(0.0); // 음소거
            _videoController.play();
          }
        }).catchError((error) {
          print('비디오 로드 에러: $error');
          if (mounted) {
            setState(() {
              _isVideoInitialized = false;
            });
          }
        });
      } catch (e) {
        print('비디오 컨트롤러 생성 에러: $e');
        setState(() {
          _isVideoInitialized = false;
        });
      }
    } else {
      setState(() {
        _isVideoInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _breathingController.dispose();
    _typingController.dispose();
    _particleController.dispose();
    if (_isVideoInitialized) {
      _videoController.dispose();
    }
    super.dispose();
  }

  void _addWelcomeMessage() {
    final welcomeMessages = {
      'stella': '안녕하세요. 별들이 당신을 기다리고 있었네요. 무엇이 궁금하신가요?',
      'solon': '어서 오십시오. 시간의 흐름 속에서 당신의 운명을 읽어드리겠습니다.',
      'orion': '환영합니다. 카드들이 당신의 이야기를 들려주고 싶어 하네요.',
      'drKairos': '안녕하세요. 함께 문제를 체계적으로 분석해보겠습니다.',
      'gaia': '자연의 기운과 함께 찾아주셨군요. 어떤 도움이 필요하신가요?',
      'selena': '달빛 아래에서 만나뵙게 되어 반갑습니다. 마음이 편안해지길 바라요.',
    };
    
    _messages.add(ChatMessage(
      text: welcomeMessages[widget.sage.id] ?? widget.sage.statusMessage,
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _messageController.clear();
      _isTyping = true;
      _currentStreamingMessage = '';
    });

    _scrollToBottom();
    _sendAIMessage(text);
  }

  Future<void> _sendAIMessage(String userMessage) async {
    _typingController.repeat();
    
    try {
      // AI 응답 스트림 받기
      final responseStream = await ref.read(conversationProvider.notifier)
          .sendMessage(userMessage, widget.sage);
      
      String fullResponse = '';
      
      // 스트리밍으로 응답 받기
      await for (final chunk in responseStream) {
        if (mounted) {
          setState(() {
            _currentStreamingMessage += chunk;
          });
          fullResponse += chunk;
          _scrollToBottom();
        }
      }
      
      // 완료된 응답을 메시지 리스트에 추가
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: fullResponse,
            isUser: false,
            timestamp: DateTime.now(),
          ));
          _isTyping = false;
          _currentStreamingMessage = '';
        });
        _typingController.stop();
        
        // 대화 기록에 응답 추가
        ref.read(conversationProvider.notifier)
            .addResponseToHistory(fullResponse, widget.sage);
        
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: '죄송합니다. 잠시 후 다시 시도해주세요.',
            isUser: false,
            timestamp: DateTime.now(),
          ));
          _isTyping = false;
          _currentStreamingMessage = '';
        });
        _typingController.stop();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 캐릭터 영상 배경
          if (_isVideoInitialized)
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            ),
          
          // 영상이 없는 경우 이미지 배경
          if (!_isVideoInitialized)
            Positioned.fill(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 배경 이미지
                  Image.asset(
                    widget.sage.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(int.parse(widget.sage.primaryColor.replaceFirst('#', '0xFF'))).withOpacity(0.3),
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 120,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      );
                    },
                  ),
                  // 부드러운 애니메이션 효과 (호흡 효과)
                  AnimatedBuilder(
                    animation: _breathingController,
                    builder: (context, child) {
                      final scale = 1.0 + (_breathingController.value * 0.02);
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 1.5,
                              colors: [
                                Color(int.parse(widget.sage.primaryColor.replaceFirst('#', '0xFF')))
                                    .withOpacity(0.1),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          
          // 반투명 오버레이 (가독성을 위해)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // 상단 현자 정보 (간소화)
                _buildSimpleCharacterInfo(),
                
                // 대화 내용 및 입력 영역
                Expanded(
                  child: _buildChatSection(),
                ),
              ],
            ),
          ),
          
          // 뒤로가기 버튼
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleCharacterInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Text(
            widget.sage.displayName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w300,
              shadows: [
                Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.sage.specialtyArea,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              shadows: const [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          
          // 타이핑 인디케이터
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AnimatedBuilder(
                animation: _typingController,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(3, (index) {
                          final delay = index * 0.3;
                          final opacity = (math.sin((_typingController.value * 2 * math.pi) + delay) + 1) / 2;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(opacity),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          '생각하는 중...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCharacterSection() {
    return Container(
      height: 280,
      child: Stack(
        children: [
          // 캐릭터 이미지
          Center(
            child: AnimatedBuilder(
              animation: _breathingController,
              builder: (context, child) {
                final scale = 1.0 + (_breathingController.value * 0.05);
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 180,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(int.parse(widget.sage.primaryColor.replaceFirst('#', '0xFF')))
                              .withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.sage.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(int.parse(widget.sage.primaryColor.replaceFirst('#', '0xFF')))
                                .withOpacity(0.3),
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // 현자 이름
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  widget.sage.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.sage.specialtyArea,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // 타이핑 인디케이터
          if (_isTyping)
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: _typingController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(3, (index) {
                            final delay = index * 0.3;
                            final opacity = (math.sin((_typingController.value * 2 * math.pi) + delay) + 1) / 2;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(opacity),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            '생각하는 중...',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChatSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // 대화 내용
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  // 스트리밍 메시지 표시
                  return _buildStreamingMessage();
                }
                return _buildChatBubble(_messages[index]);
              },
            ),
          ),
          
          // 입력 영역
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(widget.sage.imagePath),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser 
                    ? Color(int.parse(widget.sage.primaryColor.replaceFirst('#', '0xFF'))).withOpacity(0.8)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamingMessage() {
    if (_currentStreamingMessage.isEmpty) return const SizedBox();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(widget.sage.imagePath),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                _currentStreamingMessage + '|',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '메시지를 입력하세요...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onSubmitted: (_) => _sendMessage(),
                maxLines: null,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Color(int.parse(widget.sage.primaryColor.replaceFirst('#', '0xFF'))).withOpacity(0.8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}