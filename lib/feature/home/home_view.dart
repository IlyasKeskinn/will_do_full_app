import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:will_do_full_app/product/model/todo.dart';
import 'package:will_do_full_app/product/utility/exception/custom_exception.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final CollectionReference todo =
        FirebaseFirestore.instance.collection('todos');
    final response = todo.withConverter(
      fromFirestore: (snapshot, options) {
        return Todo().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        if (value != null) {
          throw CustomFirebaseException('$value not null!');
        } else {
          return value!.toJson();
        }
      },
    ).get();
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: response,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<Todo?>> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Placeholder();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                final values =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemCount: values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: [
                          Title(
                              color: Colors.amber,
                              child: Text(values[index]?.title ?? 'Baslik'))
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Text('data yok');
              }
          }
        },
      ),
    );
  }
}
