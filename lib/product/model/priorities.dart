import 'package:equatable/equatable.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

class Priorities extends Equatable with IdModel, BaseFirebaseModel<Priorities> {
  Priorities({
    this.name,
    this.priorityLevel,
    this.color,
  });
  String? name;
  int? priorityLevel;
  String? color;

  @override
  List<Object?> get props => [name, priorityLevel, color];

  Priorities copyWith({
    String? name,
    int? priorityLevel,
    String? color,
  }) {
    return Priorities(
      name: name ?? this.name,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'priorityLevel': priorityLevel,
      'color': color,
    };
  }

  @override
  Priorities fromJson(Map<String, dynamic> json) {
    return Priorities(
      name: json['name'] as String?,
      priorityLevel: json['priorityLevel'] as int?,
      color: json['color'] as String?,
    );
  }
}
