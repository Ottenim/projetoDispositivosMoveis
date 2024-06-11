import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Scheduling extends Equatable {
  final String? id;
  final DateTime? day;
  final TimeOfDay? hour;
  final int? clientId;
  final int? attendantId;

  const Scheduling({
    this.id,
    this.day,
    this.hour,
    this.attendantId,
    this.clientId,
  });

  factory Scheduling.fromMap(String id, Map<String, dynamic> map) => Scheduling(
        id: id,
        day: map['day'],
        hour: map['hour'],
        clientId: map['clientId'],
        attendantId: map['attendantId'],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['day'] = day;
    map['hour'] = hour;
    map['clientId'] = clientId;
    map['attendantId'] = attendantId;
    return map;
  }

  Scheduling copyWith({
    String? id,
    DateTime? day,
    TimeOfDay? hour,
    int? clientId,
    int? attendantId,
  }) {
    return Scheduling(
      id: id ?? this.id,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      attendantId: attendantId ?? this.attendantId,
      clientId: clientId ?? this.clientId,
    );
  }

  @override
  List<Object?> get props => [id];
}
