class BankCardType {
  final String type;
  final List<int> prefixNumbers;
  final List<Map<String, int>> prefixNumberRanges;
  final List<int> lengths;

  BankCardType(
      {required this.type, required this.prefixNumbers, required this.prefixNumberRanges, required this.lengths});

  BankCardType.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        prefixNumbers = json['prefixNumbers'] as List<int>,
        prefixNumberRanges = json['prefixNumberRanges'] as List<Map<String, int>>,
        lengths = json['lengths'] as List<int>;

  @override
  String toString() {
    return type;
  }
}
