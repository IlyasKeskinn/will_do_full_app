import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';

abstract class IdModel {
  String? id;
}

abstract class BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);
  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw CustomFirebaseException('$snapshot not null');
    }
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
