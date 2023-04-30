import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

@immutable
class Todos extends Equatable with IdModel, BaseFirebaseModel<Todos> {
  Todos({
    this.title,
    this.description,
    this.category,
    this.categoryId,
    this.complete,
    this.priorty,
    this.id,
    // this.dateMilliseconds,
    // this.timeMilliseconds,
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
  // int? dateMilliseconds;
  // int? timeMilliseconds;

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        categoryId,
        complete,
        priorty,
        id,
        // dateMilliseconds,
        // timeMilliseconds
      ];

  Todos copyWith({
    String? title,
    String? description,
    String? category,
    String? categoryId,
    bool? complete,
    int? priorty,
    String? id,
    // int? dateMilliseconds,
    // int? timeMilliseconds,
  }) {
    return Todos(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      complete: complete ?? this.complete,
      priorty: priorty ?? this.priorty,
      id: id ?? this.id,
      // dateMilliseconds: dateMilliseconds ?? this.dateMilliseconds,
      // timeMilliseconds: timeMilliseconds ?? this.timeMilliseconds,
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
      // 'dateMilliseconds': dateMilliseconds,
      // 'timeMilliseconds': timeMilliseconds
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
      // dateMilliseconds: json['dateMilliseconds'] as int?,
      // timeMilliseconds: json['timeMilliseconds'] as int?,
    );
  }
}
