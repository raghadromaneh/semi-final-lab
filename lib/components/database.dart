import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('items');

class Database {
  static String? userUid;

  static Future<void> addItem({
    required String Name,
    required String price,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('item').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "Name": Name,
      "price": price,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String Name,
    required String price,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('item').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "Name": Name,
      "price": price,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference ItemCollection =
        _mainCollection.doc(userUid).collection('item');

    return ItemCollection.snapshots();
  }

  static Stream<QuerySnapshot> readUsers() {
    CollectionReference UserCollection =
        FirebaseFirestore.instance.collection("users");

    return UserCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('item').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
