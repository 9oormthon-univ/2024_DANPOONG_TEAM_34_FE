enum ERecycle {
  paper(en: 'Paper', ko: '종이'),
  plastic(en: 'Plastic', ko: '플라스틱'),
  glass(en: 'Glass', ko: '유리'),
  can(en: 'Can', ko: '캔'),
  clothing(en: 'Clothing', ko: '의류');

  final String en;
  final String ko;

  const ERecycle({
    required this.en,
    required this.ko,
  });

  @override
  toString() => ko;

  static ERecycle fromEn(String en) {
    switch (en) {
      case 'Paper':
        return ERecycle.paper;
      case 'Plastic':
        return ERecycle.plastic;
      case 'Glass':
        return ERecycle.glass;
      case 'Can':
        return ERecycle.can;
      case 'Clothing':
        return ERecycle.clothing;
      default:
        throw Exception('Unknown ERecycle: $en');
    }
  }
}
