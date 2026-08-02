class Postmodel {
  final String? id;
  final String? userId;
  final String? content;
  final String? imageUrl;
  final DateTime? date;

  Postmodel({
    required this.id,
    required this.userId,
    required this.content,
    required this.imageUrl,
    required this.date,
  });

  factory Postmodel.fromJson(Map<String, dynamic> json) {
    return Postmodel(
      id: json['_id'],
      userId: json['userId'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'date': date?.toIso8601String(),
    };
  }
}
