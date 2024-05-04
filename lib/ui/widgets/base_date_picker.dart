import 'package:barber/ui/widgets/base_text_field.dart';
import 'package:barber/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseDatePicker extends StatelessWidget {
  const BaseDatePicker({
    Key? key,
    this.hint,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  final String? hint;
  final DateTime? initialValue;
  final ValueChanged<DateTime?>? onChanged;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    DateTime? selectedValue = initialValue;

    return BaseTextField(
      hint: hint,
      prefixIcon: SvgPicture.asset('assets/icons/calendar.svg'),
      controller: controller,
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedValue ?? DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101),
        );

        controller.text = Helper.formatDate(picked) ?? '';

        selectedValue = picked;

        onChanged?.call(selectedValue);
      },
    );
  }
}
