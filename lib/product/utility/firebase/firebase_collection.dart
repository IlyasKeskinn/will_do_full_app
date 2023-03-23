import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollection {
  version;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(FirebaseCollection.version.name);
}
