import 'package:equatable/equatable.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

class Todo extends Equatable with IdModel, BaseFirebaseModel<Todo> {
  Todo({
    this.title,
    this.description,
    this.category,
    this.categoryId,
    this.complete,
    this.dateMillisenods,
    this.priorty,
    this.id,
  });
  @override
  String? title;
  String? description;
  String? category;
  String? categoryId;
  bool? complete;
  int? dateMillisenods;
  int? priorty;
  @override
  String? id;

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        categoryId,
        complete,
        dateMillisenods,
        priorty,
        id
      ];

  Todo copyWith({
    String? title,
    String? description,
    String? category,
    String? categoryId,
    bool? complete,
    int? dateMillisenods,
    int? priorty,
    String? id,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      complete: complete ?? this.complete,
      dateMillisenods: dateMillisenods ?? this.dateMillisenods,
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
      'dateMillisenods': dateMillisenods,
      'priorty': priorty,
      'id': id,
    };
  }

  @override
  Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      complete: json['complete'] as bool?,
      dateMillisenods: json['dateMillisenods'] as int?,
      priorty: json['priorty'] as int?,
      id: json['id'] as String?,
    );
  }
}
