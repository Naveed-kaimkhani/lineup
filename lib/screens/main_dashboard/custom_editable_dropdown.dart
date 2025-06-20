// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CustomEditableDropdown<T> extends StatefulWidget {
//   final List<T?> items;
//   final T? selectedItem;
//   final String Function(T?) itemLabelBuilder;
//   final void Function(T?) onChanged;
//   final double? width;
  
//   const CustomEditableDropdown({
//     Key? key,
//     required this.items,
//     required this.selectedItem,
//     required this.itemLabelBuilder,
//     required this.onChanged,
//     this.width,
//   }) : super(key: key);

//   @override
//   State<CustomEditableDropdown> createState() => _CustomEditableDropdownState();
// }

// class _CustomEditableDropdownState<T> extends State<CustomEditableDropdown<T>> {
//   OverlayEntry? _overlayEntry;
//   final LayerLink _layerLink = LayerLink();
//   bool _isOpen = false;

//   @override
//   void dispose() {
//     _overlayEntry?.remove();
//     super.dispose();
//   }

//   void _toggleDropdown() {
//     if (_isOpen) {
//       _overlayEntry?.remove();
//       _isOpen = false;
//     } else {
//       _overlayEntry = _createOverlayEntry();
//       Overlay.of(context).insert(_overlayEntry!);
//       _isOpen = true;
//     }
//   }

//   OverlayEntry _createOverlayEntry() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         width: widget.width ?? size.width,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: Offset(0, size.height + 5),
//           child: Material(
//             elevation: 4,
//             child: Container(
//               constraints: BoxConstraints(maxHeight: 200),
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemCount: widget.items.length,
//                 itemBuilder: (context, index) {
//                   final item = widget.items[index];
//                   return InkWell(
//                     onTap: () {
//                       widget.onChanged(item);
//                       _overlayEntry?.remove();
//                       _isOpen = false;
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Text(widget.itemLabelBuilder(item)),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: _toggleDropdown,
//         child: Container(
//           height: 50,
//           width: widget.width ?? 200,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.itemLabelBuilder(widget.selectedItem),
//                     style: TextStyle(fontSize: 16),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Icon(Icons.arrow_drop_down),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class ConflictFreeDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemLabelBuilder;
  final void Function(T?)? onChanged;
  final double width;
  final String hintText;

  const ConflictFreeDropdown({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.itemLabelBuilder,
    this.onChanged,
    this.width = 300,
    this.hintText = "Select item",
  }) : super(key: key);

  @override
  State<ConflictFreeDropdown> createState() => _ConflictFreeDropdownState<T>();
}

class _ConflictFreeDropdownState<T> extends State<ConflictFreeDropdown<T>> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _overlayEntry?.remove();
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() => _isOpen = !_isOpen);
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: widget.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return InkWell(
                    onTap: () {
                      widget.onChanged?.call(item);
                      _overlayEntry?.remove();
                      setState(() => _isOpen = false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(widget.itemLabelBuilder(item)),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          height: 50,
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.selectedItem != null 
                        ? widget.itemLabelBuilder(widget.selectedItem as T)
                        : widget.hintText,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}