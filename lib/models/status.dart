import 'dart:convert';

class Status {
  bool isTaken;
  bool isNotTaken;
  bool isUnmarked;
  Status({
    this.isTaken = false,
    this.isNotTaken = false,
    this.isUnmarked = true,
  });

  Status copyWith({
    bool? isTaken,
    bool? isNotTaken,
    bool? isUnmarked,
  }) {
    return Status(
      isTaken: isTaken ?? this.isTaken,
      isNotTaken: isNotTaken ?? this.isNotTaken,
      isUnmarked: isUnmarked ?? this.isUnmarked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isTaken': isTaken,
      'isNotTaken': isNotTaken,
      'isUnmarked': isUnmarked,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      isTaken: map['isTaken'] ?? false,
      isNotTaken: map['isNotTaken'] ?? false,
      isUnmarked: map['isUnmarked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) => Status.fromMap(json.decode(source));

  @override
  String toString() =>
      'Status(isTaken: $isTaken, isNotTaken: $isNotTaken, isUnmarked: $isUnmarked)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Status &&
        other.isTaken == isTaken &&
        other.isNotTaken == isNotTaken &&
        other.isUnmarked == isUnmarked;
  }

  @override
  int get hashCode =>
      isTaken.hashCode ^ isNotTaken.hashCode ^ isUnmarked.hashCode;
}
