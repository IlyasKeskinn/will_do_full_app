// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:will_do_full_app/product/model/categories.dart';
import 'package:will_do_full_app/product/model/todos.dart';
import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_collection.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_utility.dart';

class HomeProvider extends StateNotifier<HomeState> with FirebaseUtily {
  HomeProvider() : super(const HomeState());

  List<Todos> _todoList = [];
  List<Todos> get todoList => _todoList;

  Future<void> fetchItems() async {
    await fetchTodos();
  }

  Future<void> fetchTodos() async {
    final response = await FirebaseCollection.users.reference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('todos')
        .withConverter<Todos>(
      fromFirestore: (snapshot, options) {
        return Todos().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        if (value == null) {
          throw CustomFirebaseException('$value not null!');
        } else {
          return {};
        }
      },
    ).get();

    final values = response.docs.map((e) => e.data()).toList();
    state = state.copyWith(todos: values);
    _todoList = values.toList();
  }
}

class HomeState extends Equatable {
  const HomeState({this.todos});
  final List<Todos>? todos;

  HomeState copyWith({
    List<Todos>? todos,
    List<Categories>? category,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [todos];
}
