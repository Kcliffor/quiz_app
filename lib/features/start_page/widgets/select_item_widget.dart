import 'package:flutter/material.dart';

class SelectItemWidget extends StatefulWidget {
  const SelectItemWidget({
    Key? key,
    required this.title,
    required this.hintTitle,
    required this.items,
    required this.selected,
  }) : super(key: key);

  final String title;
  final String hintTitle;
  final List<String> items;
  final ValueChanged<String> selected;

  @override
  State<SelectItemWidget> createState() => _SelectItemWidgetState();
}

class _SelectItemWidgetState extends State<SelectItemWidget> {
  String? _dropdownValue;

  dropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
      widget.selected.call(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButton(
          hint: Text(widget.hintTitle),
          isExpanded: true,
          onChanged: dropDownCallBack,
          value: _dropdownValue,
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
