import 'package:equatable/equatable.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

class Categories extends Equatable with IdModel, BaseFirebaseModel<Categories> {
  Categories({
    this.name,
    this.categoryColor,
    this.categoryIcon,
    this.userId,
  });
  String? name;
  String? categoryColor;
  String? categoryIcon;
  String? userId;

  @override
  List<Object?> get props => [name, categoryColor, categoryIcon, userId];

  Categories copyWith({
    String? name,
    String? categoryColor,
    String? categoryIcon,
    String? userId,
  }) {
    return Categories(
      name: name ?? this.name,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'categoryColor': categoryColor,
      'categoryIcon': categoryIcon,
      'userId': userId,
    };
  }

  @override
  Categories fromJson(Map<String, dynamic> json) {
    return Categories(
      name: json['name'] as String?,
      categoryColor: json['categoryColor'] as String?,
      categoryIcon: json['categoryIcon'] as String?,
      userId: json['userId'] as String?,
    );
  }
}
