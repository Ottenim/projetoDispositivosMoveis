import 'package:barber/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String USERS_COLLECTION = "users";

class UserService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<User> _userCollection;

  UserService() {
    _userCollection = _firestore.collection(USERS_COLLECTION).withConverter<User>(
          fromFirestore: (snapshot, options) => User.fromMap(snapshot.id, snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  //CREATE
  Future<String> addUser(User user) async {
    return (await _userCollection.add(user)).id;
  }

  Future<User?> getUserById(String id) async {
    final userStream = await _userCollection.where('id', isEqualTo: id).get();

    User? user;

    if (userStream.docs.isNotEmpty) {
      user = userStream.docs.first.data();
    }

    return user;
  }

  Future<User?> getUserByCpf(String cpf) async {
    final userStream = await _userCollection.where('cpf', isEqualTo: cpf).get();

    User? user;

    if (userStream.docs.isNotEmpty) {
      user = userStream.docs.first.data();
    }

    return user;
  }

  //READ
  Future<List<User>> getUsers() async {
    final userStream = await _userCollection.orderBy('name', descending: false).get();

    List<User> users = [];

    for (var element in userStream.docs) {
      users.add(element.data());
    }

    return users;
  }

  Future<List<User>> getUsersByCategory(List<int> categories) async {
    if (categories.isEmpty) {
      return [];
    }

    final userStream = await _userCollection.where('userCategory', whereIn: categories).get();

    List<User> users = [];

    for (var element in userStream.docs) {
      users.add(element.data());
    }

    return users;
  }

  //UPDATE
  Future<void> updateUser(String id, User user) async => await _userCollection.doc(id).update(user.toMap());

  //DELETE
  Future<void> deleteUser(String id) async => await _userCollection.doc(id).delete();
}
