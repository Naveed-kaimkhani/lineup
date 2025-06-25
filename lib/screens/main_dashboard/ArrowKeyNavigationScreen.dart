import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArrowKeyNavigationScreen extends StatefulWidget {
  @override
  _ArrowKeyNavigationScreenState createState() =>
      _ArrowKeyNavigationScreenState();
}

class _ArrowKeyNavigationScreenState extends State<ArrowKeyNavigationScreen> {
  // FocusNodes for each TextField
  final List<List<FocusNode>> fieldFocusNodes = List.generate(
    2,
    (_) => List.generate(2, (_) => FocusNode()),
  );

  // Controllers for each TextField
  final List<List<TextEditingController>> controllers = List.generate(
    2,
    (_) => List.generate(2, (_) => TextEditingController()),
  );

  @override
  void dispose() {
    for (var row in fieldFocusNodes) {
      for (var node in row) {
        node.dispose();
      }
    }
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void handleKey(RawKeyEvent event, int row, int col) {
    if (event is RawKeyDownEvent) {
      int newRow = row;
      int newCol = col;

      switch (event.logicalKey.keyLabel) {
        case 'Arrow Up':
          newRow = (row - 1).clamp(0, 1);
          break;
        case 'Arrow Down':
          newRow = (row + 1).clamp(0, 1);
          break;
        case 'Arrow Left':
          newCol = (col - 1).clamp(0, 1);
          break;
        case 'Arrow Right':
          newCol = (col + 1).clamp(0, 1);
          break;
        default:
          return;
      }

      FocusScope.of(context).requestFocus(fieldFocusNodes[newRow][newCol]);
    }
  }

  Widget buildTextField(int row, int col) {
    final listenerFocusNode = FocusNode(
      skipTraversal: true,
      canRequestFocus: false,
    ); // Dummy focus node for RawKeyboardListener

    return RawKeyboardListener(
      focusNode: listenerFocusNode,
      onKey: (event) => handleKey(event, row, col),
      child: TextField(
        focusNode: fieldFocusNodes[row][col],
        controller: controllers[row][col],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Field ${row * 2 + col + 1}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Arrow Key Navigation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 150, child: buildTextField(0, 0)),
                const SizedBox(width: 20),
                SizedBox(width: 150, child: buildTextField(0, 1)),
              ],
            ),
            const SizedBox(height: 20),
            // Row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 150, child: buildTextField(1, 0)),
                const SizedBox(width: 20),
                SizedBox(width: 150, child: buildTextField(1, 1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
