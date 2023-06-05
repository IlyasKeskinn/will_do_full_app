import 'package:equatable/equatable.dart';
import 'package:will_do_full_app/product/utility/base/base_firabase_model.dart';

class Users extends Equatable with IdModel, BaseFirebaseModel<Users> {
  Users({
    this.email,
    this.profileImage,
    this.name,
    this.userId,
  });
  String? email;
  String? profileImage;
  String? name;
  String? userId;

  @override
  List<Object?> get props => [email, profileImage, name, userId];

  Users copyWith({
    String? email,
    String? profileImage,
    String? name,
    String? userId,
  }) {
    return Users(
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'profileImage': profileImage,
      'name': name,
      'userId': userId,
    };
  }

  @override
  Users fromJson(Map<String, dynamic> json) {
    return Users(
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      userId: json['userId'] as String?,
    );
  }
}
