import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridNavigationScreen extends StatefulWidget {
  const GridNavigationScreen({super.key});

  @override
  State<GridNavigationScreen> createState() => _GridNavigationScreenState();
}

class _GridNavigationScreenState extends State<GridNavigationScreen> {
  // FocusNode and TextEditingController for each field
  late final FocusNode _topLeftFocus,
      _topRightFocus,
      _bottomLeftFocus,
      _bottomRightFocus;
  late final TextEditingController _topLeftController,
      _topRightController,
      _bottomLeftController,
      _bottomRightController;

  @override
  void initState() {
    super.initState();

    _topLeftFocus = FocusNode(debugLabel: 'Top-Left');
    _topRightFocus = FocusNode(debugLabel: 'Top-Right');
    _bottomLeftFocus = FocusNode(debugLabel: 'Bottom-Left');
    _bottomRightFocus = FocusNode(debugLabel: 'Bottom-Right');

    // Initialize Controllers with the specified text: C, CF, LF, RF
    _topLeftController = TextEditingController(text: 'C');
    _topRightController = TextEditingController(text: 'CF');
    _bottomLeftController = TextEditingController(text: 'LF');
    _bottomRightController = TextEditingController(text: 'RF');
  }

  @override
  void dispose() {
    _topLeftFocus.dispose();
    _topRightFocus.dispose();
    _bottomLeftFocus.dispose();
    _bottomRightFocus.dispose();

    _topLeftController.dispose();
    _topRightController.dispose();
    _bottomLeftController.dispose();
    _bottomRightController.dispose();

    super.dispose();
  }

  /// Helper to move focus and place cursor at the end of the text, preventing selection.
  void _moveFocusAndSetCursorAtEnd(
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    focusNode.requestFocus();
    // By default, requestFocus() selects all text. To prevent this, we schedule a
    // post-frame callback to manually set the cursor position after the focus change has completed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    });
  }

  /// Main handler for keyboard events.
  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (event is! RawKeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.arrowDown) {
      if (_topLeftFocus.hasFocus)
        _bottomLeftFocus.requestFocus();
      else if (_topRightFocus.hasFocus)
        _bottomRightFocus.requestFocus();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.arrowUp) {
      if (_bottomLeftFocus.hasFocus)
        _topLeftFocus.requestFocus();
      else if (_bottomRightFocus.hasFocus)
        _topRightFocus.requestFocus();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      if (_topLeftFocus.hasFocus)
        _topRightFocus.requestFocus();
      else if (_bottomLeftFocus.hasFocus)
        _bottomRightFocus.requestFocus();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      if (_topRightFocus.hasFocus) {
        // Move focus to the left field and place cursor at the end.
        _moveFocusAndSetCursorAtEnd(_topLeftFocus, _topLeftController);
      } else if (_bottomRightFocus.hasFocus) {
        // Move focus to the left field and place cursor at the end.
        _moveFocusAndSetCursorAtEnd(_bottomLeftFocus, _bottomLeftController);
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Corrected Cursor Navigation')),
      body: Focus(
        onKey: _handleKeyEvent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Use arrow keys to navigate the grid.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              // Top Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _topLeftController,
                      focusNode: _topLeftFocus,
                      decoration: const InputDecoration(labelText: 'Top-Left'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _topRightController,
                      focusNode: _topRightFocus,
                      decoration: const InputDecoration(labelText: 'Top-Right'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Bottom Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _bottomLeftController,
                      focusNode: _bottomLeftFocus,
                      decoration: const InputDecoration(
                        labelText: 'Bottom-Left',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _bottomRightController,
                      focusNode: _bottomRightFocus,
                      decoration: const InputDecoration(
                        labelText: 'Bottom-Right',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
