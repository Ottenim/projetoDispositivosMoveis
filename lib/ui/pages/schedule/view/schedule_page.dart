import 'package:barber/infra/extensions/integer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String selectedProfessional = 'Janei';
  DateTime selectedDate = DateTime.now();
  String selectedTime = '15:00';
  String selectedService = 'Corte de cabelo';
  final servicePrices = {'Corte de cabelo': 25, 'Corte de barba': 15};

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

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
        title: Text('Agendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _subtitulo("Selecione o profissional"),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProfessionalSelection(
                          'Janei', 'assets/images/janei.jpg'),
                      _buildProfessionalSelection(
                          'Juninho', 'assets/images/juninho.jpg'),
                    ],
                  ),
                  SizedBox(height: 15),
                  _buildDateTimePicker(context),
                  SizedBox(height: 15),
                  _buildTimePicker(),
                  SizedBox(height: 15),
                  _buildServicePicker(),
                  SizedBox(height: 15),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Color(0xFFFFF112),
              ),
              onPressed: () {},
              child: Text(
                'Continuar',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalSelection(String name, String imagePath) {
    bool isSelected = selectedProfessional == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedProfessional = name;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor:
                isSelected ? Color(0xFFFFF112) : Colors.transparent,
            child: CircleAvatar(
              radius: 33,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subtitulo('Selecione a data'),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFF333333),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  DateFormat('dd/MM/yyyy').format(selectedDate),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subtitulo('Selecione a hora'),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedTime,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF333333),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          dropdownColor: Color(0xFF333333),
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          items: ['15:00', '15:30', '16:00']
              .map((time) => DropdownMenuItem<String>(
                    value: time,
                    child: Text(time,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ))
              .toList(),
          onChanged: (time) {
            setState(() {
              selectedTime = time!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildServicePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subtitulo('Selecione o serviço'),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedService,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF333333),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          dropdownColor: Color(0xFF333333),
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          items: servicePrices.keys
              .map((service) => DropdownMenuItem<String>(
                    value: service,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(service,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF112),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'R\$${servicePrices[service]}',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: (service) {
            setState(() {
              selectedService = service!;
            });
          },
        ),
      ],
    );
  }

  Widget _subtitulo(String subtitulo) {
    return Row(
      children: [
        Text(
          subtitulo,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        10.toSizedBoxW(),
        Expanded(
          child: Container(
            height: 1,
            color: Color(0xffFFF112),
          ),
        ),
      ],
    );
  }
}
