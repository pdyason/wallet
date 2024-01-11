class BankCardType {
  final String type;
  final List<String> prefixNumbers;
  final List<Map<String, String>> prefixNumberRanges;
  final List<int> lengths;

  BankCardType({
    required this.type,
    required this.prefixNumbers,
    required this.prefixNumberRanges,
    required this.lengths,
  });

  factory BankCardType.fromJson(Map<String, dynamic> json) {
    return BankCardType(
      type: json['type'],
      prefixNumbers: List<String>.from(json['prefixNumbers']),
      prefixNumberRanges: List<Map<String, String>>.from(
        json['prefixNumberRanges'].map(
          (range) => {
            'start': range['start'] as String,
            'end': range['end'] as String,
          },
        ),
      ),
      lengths: List<int>.from(json['lengths']),
    );
  }

  @override
  String toString() => type;

  List<String> getPrefixes() {
    var pn = prefixNumbers.toList();
    List<String> pr = [];
    for (var range in prefixNumberRanges) {
      assert(range['start']!.length == range['end']!.length, true);
      assert(range['start']![0] == range['start']![0], true);
      assert(range['start']![0] != '0', true);
      var start = int.parse(range['start']!);
      var end = int.parse(range['end']!);
      assert(start < end, true);
      for (var n = start; n <= end; n++) {
        pr.add(n.toString());
      }
    }
    return pn + pr;
  }
}
