import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Scheduling extends Equatable {
  final String? id;
  final DateTime? day;
  final TimeOfDay? hour;
  final String? clientId;
  final String? attendantId;
  final String? serviceId;

  const Scheduling({
    this.id,
    this.day,
    this.hour,
    this.attendantId,
    this.clientId,
    this.serviceId,
  });

  factory Scheduling.fromMap(String id, Map<String, dynamic> map) => Scheduling(
        id: id,
        day: map.containsKey('day') ? DateFormat('yyyy-MM-dd').parse(map['day']) : null,
        hour: map.containsKey('hour') ? TimeOfDay.fromDateTime(DateFormat(DateFormat.HOUR24_MINUTE).parse(map['hour'])) : null,
        clientId: map['clientId'],
        attendantId: map['attendantId'],
        serviceId: map['serviceId'],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['day'] = day != null ? DateFormat('yyyy-MM-dd').format(day!) : null;
    map['hour'] = hour != null ? DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.now().copyWith(hour: hour?.hour, minute: hour?.minute)) : null;
    map['clientId'] = clientId;
    map['attendantId'] = attendantId;
    map['serviceId'] = serviceId;
    return map;
  }

  Scheduling copyWith({
    String? id,
    DateTime? day,
    TimeOfDay? hour,
    String? clientId,
    String? attendantId,
    String? serviceId,
  }) {
    return Scheduling(
      id: id ?? this.id,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      attendantId: attendantId ?? this.attendantId,
      clientId: clientId ?? this.clientId,
      serviceId: serviceId ?? this.serviceId,
    );
  }

  @override
  List<Object?> get props => [id];
}
