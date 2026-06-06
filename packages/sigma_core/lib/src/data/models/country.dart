class Country {
  final String name;
  final String code;
  final String phoneCode;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.phoneCode,
    required this.flag,
  });
}

const List<Country> manualCountries = [
  Country(name: 'Brasil', code: 'BR', phoneCode: '55', flag: '🇧🇷'),
  Country(name: 'Portugal', code: 'PT', phoneCode: '351', flag: '🇵🇹'),
  Country(name: 'Estados Unidos', code: 'US', phoneCode: '1', flag: '🇺🇸'),
  Country(name: 'Angola', code: 'AO', phoneCode: '244', flag: '🇦🇴'),
  Country(name: 'Moçambique', code: 'MZ', phoneCode: '258', flag: '🇲🇿'),
  Country(name: 'Cabo Verde', code: 'CV', phoneCode: '238', flag: '🇨🇻'),
];
