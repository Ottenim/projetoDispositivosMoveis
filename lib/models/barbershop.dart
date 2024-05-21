import 'package:equatable/equatable.dart';

class Barbershop extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? latitude;
  final String? longitude;

  // foto;

  const Barbershop({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  Barbershop copyWith({
    int? id,
    String? name,
    String? address,
    String? latitude,
    String? longitude,
  }) {
    return Barbershop(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
