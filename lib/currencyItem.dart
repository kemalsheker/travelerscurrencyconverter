class CurrencyItem {
  String description;
  String code;
  CurrencyItem(this.description, this.code);
  factory CurrencyItem.fromJson(dynamic json) {
    return CurrencyItem(json['description'] as String, json['code'] as String);
  }
  @override
  String toString() {
    return '{ $description, $code }';
  }
}