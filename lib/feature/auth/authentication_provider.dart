// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_do_full_app/enums/cache_items.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier() : super(const AuthenticationState());

  Future<void> fetchUserDetail(User? user) async {
    if (user == null) {
      return;
    }
    final token = await user.getIdToken();
    saveUserToken(token);
    await saveUserFirebase(user);
    state = state.copyWith(isRedirecHome: true);
  }

  void saveUserToken(String token) {
    CacheItems.token.write(token);
  }

  Future<void> saveUserFirebase(User? user) async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'email': user.email,
      'name': user.displayName ?? 'Nameless', 
      'userId': user.uid
    });
  }
}

class AuthenticationState extends Equatable {
  const AuthenticationState({this.isRedirecHome});
  final bool? isRedirecHome;

  @override
  List<Object?> get props => [isRedirecHome];

  AuthenticationState copyWith({
    bool? isRedirecHome,
  }) {
    return AuthenticationState(
      isRedirecHome: isRedirecHome ?? this.isRedirecHome,
    );
  }
}
