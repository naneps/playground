import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/overlays/loading_dialog.dart';
import 'package:playground/app/models/post_model.dart';

import 'base_repository.dart';

class PostRepository extends BaseRepository<PostModel> {
  PostRepository(super.firestore);

  @override
  CollectionReference get collection => firestore.collection('posts');

  @override
  Future<void> add(PostModel item) async {
    LoadingDialog.show(Get.context!);
    await collection.add(toJson(item)).then((value) {
      value.update({'id': value.id});
    });
    LoadingDialog.hide(Get.context!);
  }

  @override
  Future<void> delete(String id) async {
    await collection.doc(id).delete();
  }

  @override
  PostModel fromJson(Map<String, dynamic> json) => PostModel.fromJson(json);

  @override
  Future<List<PostModel>> getAll() async {
    final querySnapshot =
        await collection.orderBy('createdAt', descending: true).get();
    return querySnapshot.docs
        .map(
          (doc) => fromJson(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  @override
  Future<List<PostModel>> getFiltered({
    required Map<String, dynamic> filters,
    DocumentSnapshot? startAfter,
    int limit = 10,
  }) async {
    Query query = collection;
    filters.forEach((field, value) {
      query = query.where(field, isEqualTo: value);
    });

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    query = query.orderBy('createdAt', descending: true).limit(limit);

    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> likePost(String postId, String userId) async {
    try {
      DocumentReference docRef = collection.doc(postId);
      await docRef.update({
        'likedBy': FieldValue.arrayUnion([userId]),
        'likes': FieldValue.increment(1),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<PostModel>> streamAll() {
    return collection
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<PostModel> streamOne(String id) {
    return collection.doc(id).snapshots().map((snapshot) {
      return fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }

  @override
  Map<String, dynamic> toJson(PostModel item) => item.toJson();

  Future<void> unlikePost(String postId, String userId) async {
    try {
      DocumentReference docRef = collection.doc(postId);
      await docRef.update({
        'likedBy': FieldValue.arrayRemove([userId]),
        'likes': FieldValue.increment(-1),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(PostModel item) async {
    await collection.doc(item.id).update(toJson(item));
  }
}
