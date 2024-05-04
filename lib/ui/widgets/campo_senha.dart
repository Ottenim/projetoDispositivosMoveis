import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isHidden,
        decoration: InputDecoration(
          hintText: 'Senha',
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
          prefixIcon: Icon(Icons.lock_outline_rounded),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          suffixIcon: IconButton(
            icon:
                isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: togglePasswordVisibility,
          ),
        ),
        enableInteractiveSelection: false,
        cursorColor: const Color(0xFFFFF112),
        keyboardType: TextInputType.visiblePassword,
        autofillHints: [AutofillHints.password],
        onEditingComplete: () => TextInput.finishAutofillContext(),
        validator: (password) => password != null && password.length < 5
            ? 'Enter min. 5 characters'
            : null,
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
