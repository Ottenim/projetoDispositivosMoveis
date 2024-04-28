import 'package:barber/domain/usuario/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  ///Temos que ter um Crud para cada model, ou seja:
  ///Usuario -> Create, Read, Update, Delete
  ///Barbearia -> Create, Read, Update, Delete
  ///Agendamento -> Create, Read, Update, Delete

  //EX:
  final CollectionReference usuario =
      FirebaseFirestore.instance.collection('usuario');
  //CREATE
  Future<void> addUsuario(Usuario user) {
    return usuario.add(user);
  }

  //READ
  Stream<QuerySnapshot> getUsuarioStream() {
    final usuarioStream = usuario.orderBy('id', descending: false).snapshots();

    return usuarioStream;
  }

  //UPDATE
  Future<void> updateUsuario(int id, Usuario user) {
    return usuario.doc('$id').update({
      'id': user.id,
      'nome': user.nome,
      'cpf': user.cpf,
      'senha': user.senha,
      'categoria': user.categoria
    });
  }

  //DELETE
  Future<void> deleteUsuario(int id) {
    return usuario.doc('$id').delete();
  }
}
