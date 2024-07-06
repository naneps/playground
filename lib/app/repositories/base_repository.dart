import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseRepository<T> {
  final FirebaseFirestore firestore;

  BaseRepository(this.firestore, {String? collectionPath});

  CollectionReference get collection;

  Future<void> add(T item);

  Future<void> delete(String id);

  T fromJson(Map<String, dynamic> json);

  Future<List<T>> getAll();

  Future<List<T>> getFiltered({
    required Map<String, dynamic> filters,
    DocumentSnapshot? startAfter,
    int limit = 10,
  });

  Stream<List<T>> streamAll();
  Stream<T> streamOne(String id);

  Map<String, dynamic> toJson(T item);

  Future<void> update(T item);
}
