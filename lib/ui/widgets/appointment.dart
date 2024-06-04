import 'package:flutter/material.dart';

class AgendamentoWidget extends StatelessWidget {
  final String date;
  final String service;
  final String attendant;

  AgendamentoWidget({
    required this.date,
    required this.service,
    required this.attendant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF333333),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF112),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.calendar_today, color: Colors.black),
        ),
        title: Text(
          'Data: $date\nServiço: $service\nProfissional: $attendant',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        trailing: GestureDetector(
          onTap: () {
            // Função onTap vazia por enquanto
          },
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          behavior: HitTestBehavior.opaque,
        ),
      ),
    );
  }
}
