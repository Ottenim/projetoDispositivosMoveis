class Agendamento {
  int id;
  String dia;
  String hora;
  int idCliente;
  int idAtendente;

  Agendamento({
    required this.id,
    required this.dia,
    required this.hora,
    required this.idAtendente,
    required this.idCliente,
  });
}
