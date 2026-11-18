class QRHistoryModel {
  final String id;
  final String content;
  final String type;
  final DateTime createdAt;

  const QRHistoryModel({
    required this.id,
    required this.content,
    required this.type,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory QRHistoryModel.fromJson(Map<String, dynamic> json) {
    return QRHistoryModel(
      id: json['id'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
