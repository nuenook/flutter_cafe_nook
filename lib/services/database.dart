import 'package:cafe_nook/models/brew.dart';
import 'package:cafe_nook/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

final String uid;
DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid)
    .setData({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }
  Stream<List<Brew>>  get brews {
    return brewCollection
      .snapshots().map(_brewListFromSnapshot);
  }

  // getuser doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid)
    .snapshots().map(_userDataFromSnapshot);
  }
}