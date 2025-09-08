// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class ValuRecord {
String textComment;
num rate;
  ValuRecord({
    required this.textComment,
    required this.rate,
  });


  ValuRecord copyWith({
    String? textComment,
    num? rate,
  }) {
    return ValuRecord(
      textComment: textComment ?? this.textComment,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'textComment': textComment,
      'rate': rate,
    };
  }

  factory ValuRecord.fromMap(Map<String, dynamic> map) {
    return ValuRecord(
      textComment: map['textComment'] as String,
      rate: map['rate'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory ValuRecord.fromJson(String source) => ValuRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ValuRecord(textComment: $textComment, rate: $rate)';

  @override
  bool operator ==(covariant ValuRecord other) {
    if (identical(this, other)) return true;
  
    return 
      other.textComment == textComment &&
      other.rate == rate;
  }

  @override
  int get hashCode => textComment.hashCode ^ rate.hashCode;
}
