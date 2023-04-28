// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:will_do_full_app/product/model/categories.dart';
import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_collection.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_utility.dart';

class AddTaskProvider extends StateNotifier<AddTaskState> with FirebaseUtily {
  AddTaskProvider() : super(const AddTaskState());

  List<Categories> _categories = [];
  List<Categories> get categories => _categories;

  Future<void> FetchCategory() async {
    final response = await FirebaseCollection.category.reference
        .where('userId',
            whereIn: ['', FirebaseAuth.instance.currentUser?.uid ?? ''])
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
}

class AddTaskState extends Equatable {
  const AddTaskState({this.category});
  final List<Categories>? category;

  @override
  List<Object?> get props => [category];

  AddTaskState copyWith({
    List<Categories>? category,
  }) {
    return AddTaskState(
      category: category ?? this.category,
    );
  }
}
