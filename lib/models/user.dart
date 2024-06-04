import 'package:equatable/equatable.dart';

enum Category { admin, barber, client }

class User extends Equatable {
  final String? id;
  final String? name;
  final Category? category;
  final String? cpf;
  final String? password;

  //fotoPerfil

  const User({
    this.id,
    this.name,
    this.category,
    this.cpf,
    this.password,
  });

  factory User.fromMap(String id, Map<String, dynamic> map) => User(
        id: id,
        name: map['name'],
        category: Category.values[map['category']],
        cpf: map['cpf'],
        password: map['password'],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['category'] = category?.index ?? 0;
    map['cpf'] = cpf;
    map['password'] = password;
    return map;
  }

  User copyWith({
    String? id,
    String? name,
    Category? category,
    String? cpf,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [id];
}