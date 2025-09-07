/// 한국어 종성으로 단어가 끝났는지를 반환하는 함수
bool hasFinalConsonant(String text) {
  if (text.isEmpty) {
    return false;
  }
  
  final codeUnit = text.runes.last;
  const startOfSyllables = 0xAC00; // '가'
  
  if (codeUnit < startOfSyllables) {
    return false;
  }
  
  final relativeCode = codeUnit - startOfSyllables;
  final finalConsonantIndex = relativeCode % 28;
  
  return finalConsonantIndex != 0;
}