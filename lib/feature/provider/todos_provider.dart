import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:will_do_full_app/product/model/categories.dart';
import 'package:will_do_full_app/product/model/priorities.dart';
import 'package:will_do_full_app/product/model/todos.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_collection.dart';

class TodosProvider extends StateNotifier<TodosState> {
  TodosProvider() : super(TodosState());

  final List<Categories> _categories = [];
  List<Categories> get categories => _categories;

  final List<Priorities> _priorities = [];
  List<Priorities> get priorities => _priorities;

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
      //fix
      print('Error adding task: $e');
      return false; // return false if the add operation failed
    }
  }

  Future<bool> updateTask(Todos todos) async {
    try {
      final response = await FirebaseCollection.users.reference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('todos')
          .doc(todos.id)
          .update({
        'title': todos.title,
        'description': todos.description,
        'category': todos.category,
        'categoryColor': todos.categoryColor,
        'priorty': todos.priorty,
      });

      return true; // return true if the update operation was successful
    } catch (e) {
      //fix
      print('Error updating task: $e');
      return false; // return false if the update operation failed
    }
  }

  Future<bool> toggleTask(Todos todos) async {
    try {
      final response = await FirebaseCollection.users.reference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('todos')
          .doc(todos.id)
          .update({
        'complete': todos.complete ?? false,
      });

      return true; // return true if the update operation was successful
    } catch (e) {
      //fix
      print('Error updating task: $e');
      return false; // return false if the update operation failed
    }
  }

  Future<bool> deleteTask(Todos todos) async {
    try {
      final response = await FirebaseCollection.users.reference
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('todos')
          .doc(todos.id)
          .delete();

      return true; // return true if the update operation was successful
    } catch (e) {
      //fix
      print('Error updating task: $e');
      return false; // return false if the update operation failed
    }
  }
}

class TodosState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
