import 'package:equatable/equatable.dart';

enum UserCategory { admin, barber, client }

class User extends Equatable {
  final String? id;
  final String? name;
  final UserCategory? userCategory;
  final String? cpf;
  final String? password;

  //fotoPerfil

  const User({
    this.id,
    this.name,
    this.userCategory,
    this.cpf,
    this.password,
  });

  factory User.fromMap(String id, Map<String, dynamic> map) => User(
        id: id,
        name: map['name'],
        userCategory: UserCategory.values[map['userCategory']],
        cpf: map['cpf'],
        password: map['password'],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['userCategory'] = userCategory?.index ?? 2;
    map['cpf'] = cpf;
    map['password'] = password;
    return map;
  }

  User copyWith({
    String? id,
    String? name,
    UserCategory? userCategory,
    String? cpf,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      userCategory: userCategory ?? this.userCategory,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [id, userCategory];
}
