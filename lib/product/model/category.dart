import 'package:equatable/equatable.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

class Categories extends Equatable with IdModel, BaseFirebaseModel<Categories> {
  Categories({
    this.category,
  });

  String? category;

  @override
  List<Object?> get props => [category];

  Categories copyWith({
    String? category,
  }) {
    return Categories(
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
    };
  }

  @override
  Categories fromJson(Map<String, dynamic> json) {
    return Categories(
      category: json['category'] as String?,
    );
  }
}
