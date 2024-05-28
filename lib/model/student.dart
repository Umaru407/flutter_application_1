class Student {
  final int? id;
  final String? name;
  final int? score;

  Student({this.id, this.name, this.score});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }
}