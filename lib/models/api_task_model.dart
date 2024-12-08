class ApiTaskModel {
  final int? id;
  final String? title;
  final String? description;
  bool? isCompleted;
  final DateTime? createdAt;

  ApiTaskModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.createdAt,
  });

  factory ApiTaskModel.fromJson(Map<String, dynamic> json) {
    return ApiTaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
