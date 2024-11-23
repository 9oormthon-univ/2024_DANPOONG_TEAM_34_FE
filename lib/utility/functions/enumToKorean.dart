String enumToKorean(String value) {
  switch (value) {
    case 'FOLD':
      return '출근';
    case 'MORNING':
      return '아침식사';
    case 'LUNCH':
      return '점심식사';
    case 'DINNER':
      return '저녁식사';
    case 'LEAVE':
      return '퇴근';
    case 'PICTURE':
      return '외근';
    case 'MARKET':
      return '외근';
    case 'WALK':
      return '외근';
    default:
      return value;
  }
}
