import 'package:barber/ui/widgets/base_text_field.dart';
import 'package:barber/utils/helper.dart';
import 'package:flutter/material.dart';

class BaseTimePicker extends StatelessWidget {
  const BaseTimePicker({
    Key? key,
    this.hint,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  final String? hint;
  final TimeOfDay? initialValue;
  final ValueChanged<TimeOfDay?>? onChanged;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    TimeOfDay? selectedValue = initialValue;

    return BaseTextField(
      hint: hint,
      prefixIcon: Icon(Icons.access_time),
      controller: controller,
      readOnly: true,
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: initialValue ?? TimeOfDay.now(),
        );

        controller.text = Helper.formatTime(context, picked) ?? '';

        selectedValue = picked;

        onChanged?.call(selectedValue);
      },
    );
  }
}
