import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String userId;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.userId,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map, String documentId) {
    return NoteModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
    };
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    String? userId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}
