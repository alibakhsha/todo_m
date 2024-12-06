

class ApiTaskModel {
  final int id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;

  ApiTaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  factory ApiTaskModel.fromJson(Map<String, dynamic> json) {
    return ApiTaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        createdAt: DateTime.parse(json['createdAt']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
