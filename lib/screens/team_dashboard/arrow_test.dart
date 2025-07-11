import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldGridScreen extends StatefulWidget {
  const TextFieldGridScreen({super.key});

  @override
  State<TextFieldGridScreen> createState() => _TextFieldGridScreenState();
}

class _TextFieldGridScreenState extends State<TextFieldGridScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  int _currentFocusIndex = 0;

  @override
  void initState() {
    super.initState();

    for (var node in _focusNodes) {
      node.addListener(() {
        if (node.hasFocus) {
          final newIndex = _focusNodes.indexOf(node);
          if (newIndex != _currentFocusIndex) {
            // Select all text when focus changes via keyboard
            _controllers[newIndex].selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controllers[newIndex].text.length,
            );
          }
          _currentFocusIndex = newIndex;
        }
      });
    }
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final key = event.logicalKey;

      if (key == LogicalKeyboardKey.arrowRight) {
        _moveFocusRight();
      } else if (key == LogicalKeyboardKey.arrowLeft) {
        _moveFocusLeft();
      } else if (key == LogicalKeyboardKey.arrowDown) {
        _moveFocusDown();
      } else if (key == LogicalKeyboardKey.arrowUp) {
        _moveFocusUp();
      }
    }
  }

  void _moveFocusRight() {
    final newIndex = (_currentFocusIndex + 1) % 4;
    _focusNodes[newIndex].requestFocus();
  }

  void _moveFocusLeft() {
    final newIndex = (_currentFocusIndex - 1) % 4;
    _focusNodes[newIndex < 0 ? 3 : newIndex].requestFocus();
  }

  void _moveFocusDown() {
    final newIndex =
        _currentFocusIndex < 2 ? _currentFocusIndex + 2 : _currentFocusIndex;
    _focusNodes[newIndex].requestFocus();
  }

  void _moveFocusUp() {
    final newIndex =
        _currentFocusIndex >= 2 ? _currentFocusIndex - 2 : _currentFocusIndex;
    _focusNodes[newIndex].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField Grid with Selection')),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _handleKeyEvent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTextField(0, 'Field 1'),
                    const SizedBox(width: 16),
                    _buildTextField(1, 'Field 2'),
                  ],
                ),
                const SizedBox(height: 16),
                // Second row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTextField(2, 'Field 3'),
                    const SizedBox(width: 16),
                    _buildTextField(3, 'Field 4'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(int index, String hintText) {
    return SizedBox(
      width: 150,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
        onTap: () {
          // Select all text when tapped directly
          _controllers[index].selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controllers[index].text.length,
          );
        },
      ),
    );
  }
}
