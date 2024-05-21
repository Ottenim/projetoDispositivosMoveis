import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Scheduling extends Equatable {
  final int? id;
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

  Scheduling copyWith({
    int? id,
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
