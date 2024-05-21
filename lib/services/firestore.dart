import 'package:barber/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  ///Temos que ter um Crud para cada model, ou seja:
  ///Usuario -> Create, Read, Update, Deletereate, Read, Update, Delete
  ///Barbearia -> C
  ///Agendamento -> Create, Read, Update, Delete

  //EX:
  final CollectionReference<User> userCollection = FirebaseFirestore.instance.collection('user').withConverter<User>(
        fromFirestore: (snapshot, options) => User.fromMap(snapshot.data() ?? {}),
        toFirestore: (value, options) => value.toMap(),
      );

  //CREATE
  Future<String> addUser(User user) async {
    return (await userCollection.add(user)).id;
  }

  //READ
  Future<List<User>> getUsers() async {
    final userStream = await userCollection.orderBy('id', descending: false).get();

    List<User> users = [];

    for (var element in userStream.docs) {
      users.add(element.data());
    }

    return users;
  }

  //UPDATE
  Future<void> updateUser(int id, User user) async => await userCollection.doc('$id').update(user.toMap());

  //DELETE
  Future<void> deleteUser(int id) async => await userCollection.doc('$id').delete();
}
