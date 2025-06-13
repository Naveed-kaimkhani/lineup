import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/drop_down/custom_drop_down.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Base/controller/dynamicdropdown_ontroller.dart';

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








// class DynamicDropdownLis<T> extends StatelessWidget {
//   final List<T> items;
//   final T? selectedItem;
//   final String Function(T) itemLabelBuilder;
//   final double dropdownWidth;
//   final void Function(T?)? onChanged;
//
//   /// List of items to disable (same type as `items`)
//   final List<T> disabledItems;
//
//   DynamicDropdownLis({
//     Key? key,
//     required this.items,
//     required this.selectedItem,
//     required this.itemLabelBuilder,
//     this.onChanged,
//     this.dropdownWidth = 300,
//     this.disabledItems = const [], // default empty list
//   }) : super(key: key);
//
//   bool _isDisabled(T item) {
//     return disabledItems.any((disabled) {
//       // Customize comparison here if needed (e.g. by ID)
//       return item == disabled;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<T>(
//       isExpanded: true,
//       value: selectedItem,
//       hint: Text("Select item"),
//       items: items.map((item) {
//         final isDisabled = _isDisabled(item);
//         return DropdownMenuItem<T>(
//           value: isDisabled ? null : item,
//           enabled: !isDisabled,
//           child: Text(
//             itemLabelBuilder(item),
//             style: TextStyle(
//               color: isDisabled ? Colors.grey : Colors.black,
//             ),
//           ),
//         );
//       }).toList(),
//       onChanged: (val) {
//         if (val != null && !_isDisabled(val)) {
//           onChanged?.call(val);
//         }
//       },
//     );
//   }
// }

