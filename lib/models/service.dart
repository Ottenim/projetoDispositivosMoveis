import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final String? id;
  final String? name;
  final double? value;
  final String? info;
  final int? duration;

  const Service({
    this.id,
    this.name,
    this.value,
    this.info,
    this.duration,
  });

  factory Service.fromMap(String id, Map<String, dynamic> map) => Service(
        id: id,
        name: map['name'],
        info: map['info'],
        duration: map['duration'],
        value: map['value'],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['info'] = info;
    map['duration'] = duration ?? 0;
    map['value'] = value;
    return map;
  }

  Service copyWith({
    String? id,
    String? name,
    double? value,
    String? info,
    int? duration,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      info: info ?? this.info,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [name, duration, value, info];
}
