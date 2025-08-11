// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tasmi3Session {
num circle_id;
String date;
  Tasmi3Session({
    required this.circle_id,
    required this.date,
  });

  Tasmi3Session copyWith({
    num? circle_id,
    String? date,
  }) {
    return Tasmi3Session(
      circle_id: circle_id ?? this.circle_id,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'circle_id': circle_id,
      'date': date,
    };
  }

  factory Tasmi3Session.fromMap(Map<String, dynamic> map) {
    return Tasmi3Session(
      circle_id: map['circle_id'] as num,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tasmi3Session.fromJson(String source) => Tasmi3Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Tasmi3Session(circle_id: $circle_id, date: $date)';

  @override
  bool operator ==(covariant Tasmi3Session other) {
    if (identical(this, other)) return true;
  
    return 
      other.circle_id == circle_id &&
      other.date == date;
  }

  @override
  int get hashCode => circle_id.hashCode ^ date.hashCode;
}
