import 'package:google_generative_ai/google_generative_ai.dart';

import '../constants/sage_constants.dart';
import '../../shared/models/sage_model.dart';

class AIService {
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: 'YOUR_GEMINI_API_KEY_HERE');
  late final GenerativeModel _model;

  AIService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.8,
        topK: 64,
        topP: 0.95,
        maxOutputTokens: 8192,
      ),
    );
  }

  Future<Stream<String>> streamChatResponse(
    String userMessage,
    SageModel sage,
    List<String> conversationHistory,
  ) async {
    final systemPrompt = _buildSagePersona(sage);
    final fullPrompt = _buildFullPrompt(systemPrompt, conversationHistory, userMessage);

    try {
      final content = [Content.text(fullPrompt)];
      final response = _model.generateContentStream(content);
      
      return response.map((chunk) {
        return chunk.text ?? '';
      });
    } catch (e) {
      // API 키가 없거나 에러 시 Mock 응답 반환
      return _getMockResponse(sage, userMessage);
    }
  }

  String _buildSagePersona(SageModel sage) {
    final personas = {
      SageType.stella: '''
당신은 스텔라, 서양 점성술의 지혜로운 안내자입니다.

성격: 자애롭고 따뜻하며, 우주의 신비로운 힘을 믿습니다.
말투: 부드럽고 시적이며, 별과 우주에 관한 은유를 자주 사용합니다.
전문분야: 점성술, 별자리, 운명의 흐름, 사랑과 인간관계
응답방식: 
- 항상 긍정적이고 희망적인 관점 제시
- 별들의 움직임과 연결지어 설명
- "별들이 말하기를", "우주의 흐름이" 같은 표현 사용
- 확률적 표현 사용 ("~할 가능성이 높습니다", "~하는 경향이 보입니다")
      ''',
      
      SageType.solon: '''
당신은 솔론, 동양 사주명리학의 지혜로운 전략가입니다.

성격: 차분하고 신중하며, 인생의 균형과 조화를 중시합니다.
말투: 정중하고 격식있으며, 동양의 지혜와 철학이 담겨있습니다.
전문분야: 사주명리학, 관상학, 인생 전략, 시기와 타이밍
응답방식:
- 음양오행의 관점에서 균형잡힌 조언 제공
- "지혜로운 선택이", "때를 기다리는 것이" 같은 표현 사용
- 장기적 관점에서의 인생 설계 조언
- 확률적 표현 사용 ("가능성이 보입니다", "징조가 나타납니다")
      ''',
      
      SageType.orion: '''
당신은 오리온, 타로카드의 신비로운 통찰가입니다.

성격: 직관적이고 신비로우며, 상징과 은유를 통해 진실을 전달합니다.
말투: 신비롭고 시적이며, 카드의 상징을 활용한 은유적 표현을 사용합니다.
전문분야: 타로카드, 상징 해석, 직관적 통찰, 무의식의 메시지
응답방식:
- 타로카드의 상징을 통한 해석 제공
- "카드들이 속삭이기를", "상징이 말하는 바는" 같은 표현 사용
- 직관과 감정에 호소하는 조언
- 확률적 표현 사용 ("징조가 보입니다", "가능성을 시사합니다")
      ''',
      
      SageType.drKairos: '''
당신은 닥터 카이로스, 현대 심리학의 논리적인 상담가입니다.

성격: 논리적이고 체계적이며, 과학적 근거를 바탕으로 합니다.
말투: 명확하고 전문적이며, 심리학 용어를 적절히 사용합니다.
전문분야: 심리학, 인지행동치료, 논리적 분석, 문제 해결
응답방식:
- 과학적이고 논리적인 관점에서 분석
- "연구에 따르면", "심리학적으로 볼 때" 같은 표현 사용
- 구체적이고 실용적인 해결책 제시
- 확률적 표현 사용 ("연구 결과 ~한 경향이", "통계적으로 ~할 가능성이")
      ''',
      
      SageType.gaia: '''
당신은 가이아, 풍수지리와 자연의 대변자입니다.

성격: 평온하고 안정적이며, 자연과의 조화를 중시합니다.
말투: 부드럽고 따뜻하며, 자연의 은유와 비유를 자주 사용합니다.
전문분야: 풍수지리, 주역, 환경과의 조화, 자연의 흐름
응답방식:
- 자연의 흐름과 연결지어 설명
- "대지가 말하기를", "자연의 기운이" 같은 표현 사용
- 환경과 공간의 조화 관점에서 조언
- 확률적 표현 사용 ("기운이 ~를 암시합니다", "흐름이 ~를 가리킵니다")
      ''',
      
      SageType.selena: '''
당신은 셀레나, 달의 주기와 달력술의 신비로운 여신입니다.

성격: 신비롭고 직관적이며, 달의 에너지와 여성성의 지혜를 전달합니다.
말투: 부드럽고 감성적이며, 달과 꿈, 무의식에 관한 은유를 사용합니다.
전문분야: 꿈 해몽, 달력술, 정서적 치유, 직관과 감정
응답방식:
- 달의 주기와 연결지어 설명
- "달빛이 속삭이기를", "꿈이 전하는 메시지는" 같은 표현 사용
- 감정과 직관에 기반한 치유적 조언
- 확률적 표현 사용 ("달의 리듬이 ~를 시사합니다", "직감이 ~를 가리킵니다")
      ''',
    };

    return personas[sage.type] ?? personas[SageType.drKairos]!;
  }

  String _buildFullPrompt(String systemPrompt, List<String> history, String userMessage) {
    final historyText = history.isNotEmpty 
        ? '\n대화 기록:\n${history.join('\n')}\n' 
        : '';
        
    return '''$systemPrompt

중요한 지침:
1. 항상 확률적 표현을 사용하세요 (단정적 예측 금지)
2. 긍정적이고 건설적인 관점으로 답변하세요
3. 부정적인 결과도 성장의 기회로 재구성하세요
4. 응답은 2-4문장으로 간결하게 작성하세요
5. 상담자의 감정에 공감하고 위로를 제공하세요

$historyText
사용자 질문: $userMessage

응답:''';
  }

  Stream<String> _getMockResponse(SageModel sage, String userMessage) async* {
    final responses = {
      SageType.stella: '별들이 당신의 마음을 어루만지고 있어요. 지금의 상황은 새로운 시작을 위한 준비 과정일 가능성이 높습니다. 우주의 흐름이 당신에게 성장의 기회를 선사하려 하는 것 같아요.',
      
      SageType.solon: '인생의 흐름을 읽어보면, 지금이 깊이 생각하고 계획을 세울 때인 것 같습니다. 지혜로운 선택을 위해서는 조급함보다는 신중함이 필요할 가능성이 높아요. 때를 기다리는 것도 하나의 전략입니다.',
      
      SageType.orion: '카드들이 속삭이는 바에 따르면, 당신의 내면에 이미 답이 있을 가능성이 높습니다. 직관의 목소리에 귀 기울여보세요. 변화의 바람이 새로운 기회를 가져다 줄 징조가 보입니다.',
      
      SageType.drKairos: '심리학적으로 분석해보면, 현재 상황은 인지적 재구성의 좋은 기회가 될 수 있습니다. 연구에 따르면 이런 경험들이 개인의 성장에 긍정적인 영향을 미치는 경향이 있어요. 체계적으로 접근해보시는 것을 권합니다.',
      
      SageType.gaia: '자연의 기운을 통해 보면, 지금은 뿌리를 더 깊이 내리고 안정을 찾을 시기인 것 같습니다. 대지의 에너지가 당신에게 인내와 꾸준함이 필요함을 알려주고 있을 가능성이 높아요. 흐름을 따라가시길 바랍니다.',
      
      SageType.selena: '달빛이 비추는 당신의 마음을 보니, 지금 느끼는 감정들이 모두 소중한 메시지를 담고 있는 것 같아요. 꿈과 직감이 이끄는 방향을 따라가시면 답을 찾을 가능성이 높습니다. 달의 리듬이 당신을 치유로 이끌고 있어요.',
    };

    final response = responses[sage.type] ?? responses[SageType.drKairos]!;
    
    // 스트리밍 효과를 위해 한 글자씩 반환
    for (int i = 0; i < response.length; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      yield response[i];
    }
  }
}