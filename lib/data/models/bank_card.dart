class BankCard {
  final String type;
  final String number;
  final String ccv;
  final String country;

  BankCard({required this.type, required this.number, required this.ccv, required this.country});

  factory BankCard.sample() {
    return BankCard(
      type: 'VISA',
      number: '0000 1111 2222 3333',
      ccv: '123',
      country: 'ZA',
    );
  }

  BankCard.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        number = json['number'],
        ccv = json['ccv'],
        country = json['country'];

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'number': number,
      'ccv': ccv,
      'country': country,
    };
  }

  @override
  String toString() {
    return '$type: $number';
  }

  @override
  int get hashCode => Object.hash(type, number, ccv, country);

  @override
  operator ==(other) =>
      other is BankCard && other.type == type && other.number == number && other.ccv == ccv && other.country == country;
}
