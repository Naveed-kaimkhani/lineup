import 'package:get/get.dart';

class DynamicDropdownController<T> extends GetxController {
  RxList<T?> selectedValues = <T?>[null].obs;

  void addDropdown() {
    selectedValues.insert(0, null);
  }

  void removeDropdown(int index) {
    selectedValues.removeAt(index);
  }

  void updateValue(int index, T? val) {
    selectedValues[index] = val;
    selectedValues.refresh(); // Sometimes needed for custom objects
  }
}
