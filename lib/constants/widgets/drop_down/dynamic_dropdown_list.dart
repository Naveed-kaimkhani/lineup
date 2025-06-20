import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/widgets/drop_down/custom_drop_down.dart';


class DynamicDropdownList<T> extends StatelessWidget {
  final List<T> items;


  final T? selectedItem;
  final String Function(T) itemLabelBuilder;
  final double dropdownWidth;
  // final DynamicDropdownController<T> controller = Get.put(DynamicDropdownController<T>());
  final void Function(T?)? onChanged; // 👈 Add this line

  DynamicDropdownList({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.itemLabelBuilder,
    this.onChanged, // 👈 Assign in constructor
    this.dropdownWidth = 300,
  });

  @override
  Widget build(BuildContext context) {
    return  CustomDropdown<T>(
                  hintText: "Select item",
                  items: items,
                  // selectedItem: selectedValue,
                  itemLabelBuilder: itemLabelBuilder,
                  onChanged: (val) {
                    // controller.updateValue(index, val);
                    if (onChanged != null) {
                      onChanged!(val); // 👈 Invoke external onChanged
                    }
                  },






    );
  }
}





