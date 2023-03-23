import 'package:equatable/equatable.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

class Number extends Equatable with IdModel, BaseFirebaseModel<Number> {
  Number({
    this.number,
  });

  String? number;

  @override
  List<Object?> get props => [number];

  Number copyWith({
    String? number,
  }) {
    return Number(
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  @override
  Number fromJson(Map<String, dynamic> json) {
    return Number(
      number: json['number'] as String?,
    );
  }
}
