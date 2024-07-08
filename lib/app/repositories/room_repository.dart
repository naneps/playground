import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/overlays/loading_dialog.dart';
import 'package:playground/app/models/room_playground_model.dart';
import 'package:playground/app/repositories/base_repository.dart';

class RoomRepository extends BaseRepository<RoomPlayGroundModel> {
  RoomRepository(super.firestore);

  @override
  // TODO: implement collection
  CollectionReference get collection => firestore.collection('rooms');

  @override
  Future<void> add(RoomPlayGroundModel item) async {
    LoadingDialog.show(Get.context!);
    await collection.add(toJson(item)).then((value) {
      value.update({'id': value.id});
    });
    LoadingDialog.hide(Get.context!);
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    return collection.doc(id).delete();
  }

  @override
  RoomPlayGroundModel fromJson(Map<String, dynamic> json) {
    return RoomPlayGroundModel.fromMap(json);
  }

  @override
  Future<List<RoomPlayGroundModel>> getAll() {
    // TODO: implement getAll
    return collection.get().then((value) {
      return value.docs
          .map((e) => fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<List<RoomPlayGroundModel>> getFiltered(
      {required Map<String, dynamic> filters,
      DocumentSnapshot<Object?>? startAfter,
      int limit = 10}) {
    // TODO: implement getFiltered
    final query = collection;
    filters.forEach((field, value) {
      query.where(field, isEqualTo: value);
    });

    if (startAfter != null) {
      query.startAfterDocument(startAfter);
    }

    query.orderBy('createdAt', descending: true).limit(limit);
    return query.get().then((value) {
      return value.docs
          .map((e) => fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<List<RoomPlayGroundModel>> streamAll() {
    // TODO: implement streamAll
    return collection.snapshots().map((event) {
      return event.docs
          .map((e) => fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<RoomPlayGroundModel> streamOne(String id) {
    // TODO: implement streamOne
    return collection.doc(id).snapshots().map((event) {
      return fromJson(event.data() as Map<String, dynamic>);
    });
  }

  @override
  Map<String, dynamic> toJson(RoomPlayGroundModel item) {
    return item.toMap();
  }

  @override
  Future<void> update(RoomPlayGroundModel item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
