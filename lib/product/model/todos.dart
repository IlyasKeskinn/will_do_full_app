import 'package:equatable/equatable.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

class Todos extends Equatable with IdModel, BaseFirebaseModel<Todos> {
  Todos({
    this.title,
    this.description,
    this.category,
    this.categoryId,
    this.complete,
    this.priorty,
    this.id,
  });
  @override
  String? title;
  String? description;
  String? category;
  String? categoryId;
  bool? complete;
  int? priorty;
  @override
  String? id;

  @override
  List<Object?> get props =>
      [title, description, category, categoryId, complete, priorty, id];

  Todos copyWith({
    String? title,
    String? description,
    String? category,
    String? categoryId,
    bool? complete,
    int? priorty,
    String? id,
  }) {
    return Todos(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      complete: complete ?? this.complete,
      priorty: priorty ?? this.priorty,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'categoryId': categoryId,
      'complete': complete,
      'priorty': priorty,
      'id': id,
    };
  }

  @override
  Todos fromJson(Map<String, dynamic> json) {
    return Todos(
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      complete: json['complete'] as bool?,
      priorty: json['priorty'] as int?,
      id: json['id'] as String?,
    );
  }
}
