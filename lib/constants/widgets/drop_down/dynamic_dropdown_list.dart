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
  final DynamicDropdownController<T> controller = Get.put(DynamicDropdownController<T>());
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
    return Obx(() => Column(
      children: [
        ...controller.selectedValues
            .asMap()
            .entries
            .map((entry) {
          int index = entry.key;
          T? selectedValue = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomDropdown<T>(
                    hintText: "Select item",
                    items: items,
                    selectedItem: selectedValue,
                    itemLabelBuilder: itemLabelBuilder,
                    onChanged: (val) {
                      controller.updateValue(index, val);
                      if (onChanged != null) {
                        onChanged!(val); // 👈 Invoke external onChanged
                      }
                    },

                  ),
                ),
                const SizedBox(width: 8),
                if (controller.selectedValues.length > 1 && selectedValue != null)
                  InkWell(
                    onTap: () => controller.removeDropdown(index),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                if (controller.selectedValues.length > 1 && selectedValue == null)
                  SizedBox(width: 38.w),
              ],
            ),
          );
        })
            .toList()
            .reversed,



      ],
    ));
  }
}
