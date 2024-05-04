import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _EmailFieldWidgetState createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'E-mail',
          filled: true,
          fillColor: const Color(0xFF262626),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFFFF112), width: 2),
          ),
          prefixIcon: const Icon(Icons.email_outlined),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        ),
        enableInteractiveSelection: false,
        cursorColor: const Color(0xFFFFF112),
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
        autofocus: true,
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Enter a valid email'
            : null,
      ),
    );
  }
}
