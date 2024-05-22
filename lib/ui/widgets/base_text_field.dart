import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.autofillHints,
    this.validator,
  });

  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        cursorColor: Colors.white,
        enabled: enabled,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onChanged: onChanged,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
          ...inputFormatters ?? [],
        ],
        obscureText: obscureText,
        maxLength: maxLength,
        autofillHints: autofillHints,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          disabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          filled: true,
          hintText: hint,
          errorBorder: InputBorder.none,
          errorStyle: TextStyle(fontSize: 10),
          helperStyle: TextStyle(fontSize: 10),
          helperText: '',
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 24,
            maxWidth: 50,
            minHeight: 24,
            minWidth: 50,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: const Color(0xff262626),
        ),
      ),
    );
  }
}
