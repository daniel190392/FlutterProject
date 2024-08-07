import 'dart:convert';

import '../../resources/resources.dart';
import 'category_course_model.dart';

class CourseModel extends Equatable {
  final String identifier;
  final String title;
  final CategoryCourseModel category;

  const CourseModel({
    required this.identifier,
    required this.title,
    required this.category,
  });

  CourseModel.newCourse({
    required this.title,
    required this.category,
  }) : identifier = uuidGenerated.uuid;

  CourseModel copyWith({
    String? identifier,
    String? title,
    CategoryCourseModel? category,
  }) =>
      CourseModel(
        identifier: identifier ?? this.identifier,
        title: title ?? this.title,
        category: category ?? this.category,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': identifier,
      'name': title,
      'category': category.name,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    try {
      return CourseModel(
        identifier: map['id'] as String,
        title: map['name'] as String,
        category: CategoryCourseModel.byName(map['category'] as String),
      );
    } catch (exception) {
      throw const FormatException('Invalid JSON');
    }
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [identifier, title, category];
}
