enum CheckboxState { checked, unchecked }

class CheckBoxItem {
  final String text;
  bool? isChecked;

  CheckBoxItem({required this.text, this.isChecked = false});
}

List<CheckBoxItem> getCheckBoxItems() {
  return [
    CheckBoxItem(text: 'No Wifi', isChecked: false),
    CheckBoxItem(text: 'Free Wifi', isChecked: false),
    CheckBoxItem(text: 'No Curfew', isChecked: false),
    CheckBoxItem(text: 'Has Curfew', isChecked: false),
    CheckBoxItem(text: 'No Air Conditioning', isChecked: false),
    CheckBoxItem(text: 'Has Air Conditioning', isChecked: false),
    CheckBoxItem(text: 'Semi Furnish', isChecked: false),
    CheckBoxItem(text: 'Fully Furnished', isChecked: false),
    CheckBoxItem(text: 'No Furnished', isChecked: false),
    CheckBoxItem(text: 'Has Security Cameras', isChecked: false),
    CheckBoxItem(text: 'No Security Cameras', isChecked: false),
    CheckBoxItem(text: 'Has Parking Lot', isChecked: false),
    CheckBoxItem(text: 'No Parking Lot', isChecked: false),
    CheckBoxItem(text: 'Pets Allowed', isChecked: false),
    CheckBoxItem(text: 'No Pets Allowed', isChecked: false),
  ];
}
