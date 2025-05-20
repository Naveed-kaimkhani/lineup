import 'package:flutter/material.dart';

class DynamicDropdownList<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?>? onChanged;
  final double? dropdownWidth;
  final String? hint;

  const DynamicDropdownList({
    Key? key,
    required this.items,
    this.selectedItem,
    required this.itemLabelBuilder,
    this.onChanged,
    this.dropdownWidth,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dropdownWidth ?? double.infinity,
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        hint: Text(hint ?? 'Select an option'),
        items: items
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(itemLabelBuilder(item)),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
