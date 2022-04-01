import 'dart:convert';

class FrequencyType {
  bool isDaily;
  bool isSpecificDays;
  FrequencyType({
    this.isDaily = false,
    this.isSpecificDays = false,
  });

  FrequencyType copyWith({
    bool? isDaily,
    bool? isSpecificDays,
  }) {
    return FrequencyType(
      isDaily: isDaily ?? this.isDaily,
      isSpecificDays: isSpecificDays ?? this.isSpecificDays,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDaily': isDaily,
      'isSpecificDays': isSpecificDays,
    };
  }

  factory FrequencyType.fromMap(Map<String, dynamic> map) {
    return FrequencyType(
      isDaily: map['isDaily'] ?? false,
      isSpecificDays: map['isSpecificDays'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FrequencyType.fromJson(String source) =>
      FrequencyType.fromMap(json.decode(source));

  @override
  String toString() =>
      'FrequencyType(isDaily: $isDaily, isSpecificDays: $isSpecificDays)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FrequencyType &&
        other.isDaily == isDaily &&
        other.isSpecificDays == isSpecificDays;
  }

  @override
  int get hashCode => isDaily.hashCode ^ isSpecificDays.hashCode;
}
