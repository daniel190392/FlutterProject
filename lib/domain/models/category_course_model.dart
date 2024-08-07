import 'package:continental_app/resources/resources.dart';

enum CategoryCourseModel {
  mobile,
  web,
  cloud;

  factory CategoryCourseModel.byName(String name) {
    for (var value in CategoryCourseModel.values) {
      if (value.name == name) return value;
    }
    throw ArgumentError.value(name, "name", "No enum value with that name");
  }
}

extension CategoryCourseModelExtension on Equatable {}
