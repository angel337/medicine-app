import 'dart:convert';

class Days {
  bool isSaturday;
  bool isSunday;
  bool isMonday;
  bool isTuesday;
  bool isWednesday;
  bool isThursday;
  bool isFriday;
  Days({
    this.isSaturday = false,
    this.isSunday = false,
    this.isMonday = false,
    this.isTuesday = false,
    this.isWednesday = false,
    this.isThursday = false,
    this.isFriday = false,
  });

  Days copyWith({
    bool? isSaturday,
    bool? isSunday,
    bool? isMonday,
    bool? isTuesday,
    bool? isWednesday,
    bool? isThursday,
    bool? isFriday,
  }) {
    return Days(
      isSaturday: isSaturday ?? this.isSaturday,
      isSunday: isSunday ?? this.isSunday,
      isMonday: isMonday ?? this.isMonday,
      isTuesday: isTuesday ?? this.isTuesday,
      isWednesday: isWednesday ?? this.isWednesday,
      isThursday: isThursday ?? this.isThursday,
      isFriday: isFriday ?? this.isFriday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isSaturday': isSaturday,
      'isSunday': isSunday,
      'isMonday': isMonday,
      'isTuesday': isTuesday,
      'isWednesday': isWednesday,
      'isThursday': isThursday,
      'isFriday': isFriday,
    };
  }

  factory Days.fromMap(Map<String, dynamic> map) {
    return Days(
      isSaturday: map['isSaturday'] ?? false,
      isSunday: map['isSunday'] ?? false,
      isMonday: map['isMonday'] ?? false,
      isTuesday: map['isTuesday'] ?? false,
      isWednesday: map['isWednesday'] ?? false,
      isThursday: map['isThursday'] ?? false,
      isFriday: map['isFriday'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Days.fromJson(String source) => Days.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Days(isSaturday: $isSaturday, isSunday: $isSunday, isMonday: $isMonday, isTuesday: $isTuesday, isWednesday: $isWednesday, isThursday: $isThursday, isFriday: $isFriday)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Days &&
        other.isSaturday == isSaturday &&
        other.isSunday == isSunday &&
        other.isMonday == isMonday &&
        other.isTuesday == isTuesday &&
        other.isWednesday == isWednesday &&
        other.isThursday == isThursday &&
        other.isFriday == isFriday;
  }

  @override
  int get hashCode {
    return isSaturday.hashCode ^
        isSunday.hashCode ^
        isMonday.hashCode ^
        isTuesday.hashCode ^
        isWednesday.hashCode ^
        isThursday.hashCode ^
        isFriday.hashCode;
  }
}
