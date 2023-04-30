import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollection {
  version,
  users,
  category,
  priorities,
  todos;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
