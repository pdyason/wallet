class BankCard {
  final String type;
  final String number;
  final String ccv;
  final String country;
  final String label;

  BankCard({required this.type, required this.number, required this.ccv, required this.country, required this.label});

  factory BankCard.sample() {
    return BankCard(
      type: 'Visa',
      number: '4242424242424242',
      ccv: '123',
      country: 'South Africa',
      label: 'Sample Card',
    );
  }

  BankCard.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        number = json['number'],
        ccv = json['ccv'],
        country = json['country'],
        label = json['label'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'number': number,
      'ccv': ccv,
      'country': country,
      'label': label,
    };
  }

  @override
  String toString() => '$type: $number';

  @override
  int get hashCode => Object.hash(type, number, ccv, country, label);

  @override
  operator ==(other) =>
      other is BankCard &&
      other.type == type &&
      other.number == number &&
      other.ccv == ccv &&
      other.country == country &&
      other.label == label;
}
