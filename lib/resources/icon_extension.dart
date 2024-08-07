import 'package:flutter/material.dart';

import '../domain/models/models.dart';

extension IconDataExtension on Icon {
  Icon byCategory(CategoryCourseModel category) {
    switch (category) {
      case CategoryCourseModel.mobile:
        return const Icon(Icons.mobile_friendly);
      case CategoryCourseModel.web:
        return const Icon(Icons.web);
      case CategoryCourseModel.cloud:
        return const Icon(Icons.filter_drama_outlined);
    }
  }
}
