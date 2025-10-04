enum SageType {
  stella,
  solon,
  orion,
  drKairos,
  gaia,
  selena,
}

class SageConstants {
  static const Map<SageType, String> sageNames = {
    SageType.stella: '스텔라',
    SageType.solon: '솔론',
    SageType.orion: '오리온',
    SageType.drKairos: '닥터 카이로스',
    SageType.gaia: '가이아',
    SageType.selena: '셀레나',
  };

  static const Map<SageType, String> sageDescriptions = {
    SageType.stella: '서양 점성술 기반. 별들의 움직임을 통해 거시적인 운명의 흐름과 개인의 잠재력을 알려주는 자애로운 안내자',
    SageType.solon: '동양 사주명리학/관상학 기반. 타고난 기질과 인생의 길흉화복을 짚어주는 지혜로운 전략가',
    SageType.orion: '타로카드 기반. 현재 상황과 무의식을 상징으로 해석하여 직관적 통찰을 주는 신비로운 통찰가',
    SageType.drKairos: '현대 심리학 기반. 사용자의 사고 패턴을 분석하여 합리적 해결책을 제시하는 논리적인 상담가',
    SageType.gaia: '풍수지리/주역 기반. 공간, 환경과의 조화를 통해 삶의 문제를 해석하는 자연의 대변자',
    SageType.selena: '달의 주기와 달력술 기반. 달의 리듬으로 정서적 균형을 찾아주는 달빛의 여신',
  };

  static const Map<SageType, String> sageSpecialties = {
    SageType.stella: '점성술, 별자리, 운명의 흐름',
    SageType.solon: '사주명리학, 관상학, 인생 전략',
    SageType.orion: '타로카드, 상징 해석, 직관적 통찰',
    SageType.drKairos: '심리학, 인지행동치료, 논리적 분석',
    SageType.gaia: '풍수지리, 주역, 환경과의 조화',
    SageType.selena: '꿈 해몽, 달력술, 정서적 치유',
  };

  static const Map<SageType, List<String>> sageKeywords = {
    SageType.stella: ['별', '운명', '우주', '조화', '사랑', '성장'],
    SageType.solon: ['지혜', '전략', '균형', '시간', '기회', '선택'],
    SageType.orion: ['직감', '변화', '숨겨진 진실', '내면', '깨달음'],
    SageType.drKairos: ['논리', '해결', '성장', '치유', '이해', '발전'],
    SageType.gaia: ['자연', '조화', '흐름', '안정', '근본', '터전'],
    SageType.selena: ['달', '주기', '감정', '직관', '균형', '정화'],
  };

  static const Map<SageType, String> sageImages = {
    SageType.stella: 'assets/sages/Stella.jpg',
    SageType.solon: 'assets/sages/solon.png',
    SageType.orion: 'assets/sages/Orion.png',
    SageType.drKairos: 'assets/sages/Dr. Kairos.png',
    SageType.gaia: 'assets/sages/Gaia.png',
    SageType.selena: 'assets/sages/Selena.jpg',
  };

  static const Map<SageType, String> sageVideos = {
    SageType.stella: 'assets/sages/Stella.mp4',
    SageType.solon: 'assets/sages/solon.mp4',
    SageType.orion: 'assets/sages/Orion.mp4',
    SageType.drKairos: 'assets/sages/Dr. Kairos.mp4',
    SageType.gaia: 'assets/sages/Gaia.mp4',
    SageType.selena: 'assets/sages/Selena.mp4',
  };
}