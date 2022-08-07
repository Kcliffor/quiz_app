import 'package:flutter/material.dart';

class ListTileCheckBox extends StatelessWidget {
  const ListTileCheckBox({
    Key? key,
    this.title,
    required this.onPressed,
    required this.margin,
    this.isMultipleChoice = false,
    this.selected = false,
  }) : super(key: key);

  final bool selected;
  final String? title;
  final void Function() onPressed;
  final EdgeInsets margin;
  final bool isMultipleChoice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(11.0)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      margin: margin,
      child: ListTile(
        onTap: onPressed,
        title: Row(
          children: [
            Expanded(
              child: Text(
                title ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              width: 20,
              child: CustomCheckBox(
                value: selected,
                isMultipleChoice: isMultipleChoice,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.value,
    required this.isMultipleChoice,
    this.asset,
  }) : super(key: key);

  final bool value;
  final bool isMultipleChoice;
  final String? asset;

  @override
  Widget build(BuildContext context) {
    Widget result = Container();
    if (value) {
      result = const Icon(Icons.check_circle);
    } else {
      if (isMultipleChoice) {
        result = const Icon(Icons.check_box_outline_blank);
      }
    }
    return result;
  }
}
