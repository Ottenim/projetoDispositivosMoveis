import 'package:barber/ui/widgets/base_text_field.dart';
import 'package:barber/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseDatePicker extends StatefulWidget {
  const BaseDatePicker({
    Key? key,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final String? hint;
  final DateTime? initialValue;
  final ValueChanged<DateTime?>? onChanged;
  final FormFieldValidator<DateTime>? validator;

  @override
  State<BaseDatePicker> createState() => _BaseDatePickerState();
}

class _BaseDatePickerState extends State<BaseDatePicker> {
  TextEditingController controller = TextEditingController();

  DateTime? selectedValue;

  @override
  void initState() {
    super.initState();

    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      hint: widget.hint,
      prefixIcon: SvgPicture.asset(
        'assets/icons/calendar.svg',
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      controller: controller,
      readOnly: true,
      validator: (value) => widget.validator?.call(selectedValue),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedValue ?? DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101),
        );

        if (picked != null) {
          picked = picked.copyWith(minute: 0, millisecond: 0, microsecond: 0, hour: 0, second: 0);
        }

        controller.text = Helper.formatDate(picked) ?? '';

        selectedValue = picked;

        widget.onChanged?.call(selectedValue);
      },
    );
  }
}
