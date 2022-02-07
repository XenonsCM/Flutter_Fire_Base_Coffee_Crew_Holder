import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proje_denemesi_fire_base/models/brew.dart';
import 'package:proje_denemesi_fire_base/models/user.dart';

class DatabaseService {
  String uid;
  DatabaseService({required this.uid});
  // collection reference

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strenght) async {
    return await brewCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strenght": strenght,
    });
  }

  //Brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Brew(
          name: e.get("name") ?? "",
          strength: e.get("strenght") ?? 0,
          sugars: e.get("sugars") ?? "0");
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get("name"),
        sugars: snapshot.get("sugars"),
        strength: snapshot.get("strenght"));
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
