// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:will_do_full_app/product/model/categories.dart';
import 'package:will_do_full_app/product/model/priorities.dart';
import 'package:will_do_full_app/product/model/todos.dart';
import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_collection.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_utility.dart';

class AddTaskProvider extends StateNotifier<AddTaskState> with FirebaseUtily {
  AddTaskProvider() : super(const AddTaskState());

  List<Categories> _categories = [];
  List<Categories> get categories => _categories;

  List<Priorities> _priorities = [];
  List<Priorities> get priorities => _priorities;

  Future<void> fetchItems() async {
    await fetchCategory();
    await fetchPriority();
  }

  Future<void> fetchCategory() async {
    final response = await FirebaseCollection.category.reference
        .where(
          'userId',
          whereIn: ['', FirebaseAuth.instance.currentUser?.uid ?? ''],
        )
        .withConverter<Categories>(
          fromFirestore: (snapshot, options) =>
              Categories().fromFirebase(snapshot),
          toFirestore: (value, options) {
            if (value == null) {
              throw CustomFirebaseException('$value not null');
            } else {
              return {};
            }
          },
        )
        .get();
    final values = response.docs.map((e) => e.data()).toList();
    state = state.copyWith(category: values);
    _categories = values.toList();
  }

  Future<void> fetchPriority() async {
    final response = await FirebaseCollection.priorities.reference
        .orderBy('priorityLevel')
        .withConverter<Priorities>(
          fromFirestore: (snapshot, options) =>
              Priorities().fromFirebase(snapshot),
          toFirestore: (value, options) {
            if (value == null) {
              throw CustomFirebaseException('$value not null');
            } else {
              return {};
            }
          },
        )
        .get();
    final values = response.docs.map((e) => e.data()).toList();
    state = state.copyWith(priority: values);
    _priorities = values.toList();
  }

  Future<bool> addTask(Todos? todos) async {
    try {
      final response = await FirebaseCollection.users.reference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('todos')
          .add(
            Todos(
              title: todos!.title,
              description: todos.description,
              category: todos.category,
              categoryColor: todos.categoryColor,
              complete: todos.complete,
              priorty: todos.priorty,
            ).toJson(),
          );

      return true; // return true if the add operation was successful
    } catch (e) {
      print('Error adding task: $e');
      return false; // return false if the add operation failed
    }
  }
}

class AddTaskState extends Equatable {
  const AddTaskState({this.category, this.priority});
  final List<Categories>? category;
  final List<Priorities>? priority;

  @override
  List<Object?> get props => [category, priority];

  AddTaskState copyWith({
    List<Categories>? category,
    List<Priorities>? priority,
  }) {
    return AddTaskState(
      category: category ?? this.category,
      priority: priority ?? priority,
    );
  }
}
