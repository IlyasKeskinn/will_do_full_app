// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:will_do_full_app/product/model/priorities.dart';
import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_collection.dart';
import 'package:will_do_full_app/product/utility/firebase/firebase_utility.dart';

class PriorityProvider extends StateNotifier<PriorityState> with FirebaseUtily {
  PriorityProvider() : super(const PriorityState());

  List<Priorities> _priorities = [];
  List<Priorities> get priorities => _priorities;

  Future<void> fetchItems() async {
    await fetchPriority();
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
}

class PriorityState extends Equatable {
  const PriorityState({this.priority});
  final List<Priorities>? priority;

  @override
  List<Object?> get props => [priority];

  PriorityState copyWith({
    List<Priorities>? priority,
  }) {
    return PriorityState(
      priority: priority ?? priority,
    );
  }
}
