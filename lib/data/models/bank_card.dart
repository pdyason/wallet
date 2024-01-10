class BankCard {
  final String type;
  final String number;
  final String ccv;
  final String country;
  final String alias;

  BankCard({required this.type, required this.number, required this.ccv, required this.country, required this.alias});

  factory BankCard.sample() {
    return BankCard(
      type: 'VISA',
      number: '4242 4242 4242 4242',
      ccv: '123',
      country: 'South Africa',
      alias: 'Sample Card',
    );
  }

  BankCard.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        number = json['number'],
        ccv = json['ccv'],
        country = json['country'],
        alias = json['alias'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'number': number,
      'ccv': ccv,
      'country': country,
      'alias': alias,
    };
  }

  @override
  String toString() => '$type: $number';

  @override
  int get hashCode => Object.hash(type, number, ccv, country, alias);

  @override
  operator ==(other) =>
      other is BankCard &&
      other.type == type &&
      other.number == number &&
      other.ccv == ccv &&
      other.country == country &&
      other.alias == alias;
}
