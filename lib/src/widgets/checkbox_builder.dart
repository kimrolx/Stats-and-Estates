import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  final String text;
  final bool? isChecked;
  final ValueChanged<bool?> onChanged;

  const MyCheckBox({
    Key? key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(text),
      value: isChecked,
      onChanged: (newValue) {
        onChanged(newValue);
      },
      dense: true,
    );
  }
}
