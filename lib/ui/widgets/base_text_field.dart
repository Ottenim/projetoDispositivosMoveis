import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.textType,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
  });

  final String? hint;
  final Widget? prefixIcon;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final TextInputType? textType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onTap: onTap,
        controller: controller,
        cursorColor: Colors.white,
        enabled: enabled,
        readOnly: readOnly,
        keyboardType: textType,
        onChanged: onChanged,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
          ...inputFormatters ?? [],
        ],
        obscureText: obscureText,
        maxLength: maxLength,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          disabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          filled: true,
          hintText: hint,
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 24,
            maxWidth: 50,
            minHeight: 24,
            minWidth: 50,
          ),
          prefixIcon: prefixIcon,
          fillColor: const Color(0xff262626),
        ),
      ),
    );
  }
}
