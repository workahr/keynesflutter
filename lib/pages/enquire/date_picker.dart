import 'package:flutter/material.dart';

class DatePickerConfig {
  final DateTime? firstDate;
  final DateTime? lastDate;

  DatePickerConfig({this.firstDate, this.lastDate});
}

class DatePickerField extends StatefulWidget {
  final String label;
  final Function(DateTime?) onDateSelected;
  final DatePickerConfig? datePickerConfig;

  const DatePickerField({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.datePickerConfig,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.datePickerConfig?.firstDate ?? DateTime(2000),
      lastDate: widget.datePickerConfig?.lastDate ?? DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
      widget.onDateSelected(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
      decoration: InputDecoration(
        labelText: widget.label,
        floatingLabelStyle: TextStyle(
          color: Colors.black,
          background: Paint()..color = Colors.white,
        ),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
