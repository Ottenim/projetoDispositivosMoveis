import 'package:barber/ui/widgets/appointment.dart';
import 'package:flutter/material.dart';

class MyAppointmentsPage extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => MyAppointmentsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          behavior: HitTestBehavior.opaque,
        ),
        title: Text('Meus agendamentos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          AgendamentoWidget(
            date: '12/03/2023',
            service: 'Corte',
            attendant: 'Janei',
          ),
          AgendamentoWidget(
            date: '12/04/2023',
            service: 'Corte',
            attendant: 'Janei',
          ),
          AgendamentoWidget(
            date: '12/05/2023',
            service: 'Corte e Barba',
            attendant: 'Janei',
          ),
        ],
      ),
    );
  }
}
