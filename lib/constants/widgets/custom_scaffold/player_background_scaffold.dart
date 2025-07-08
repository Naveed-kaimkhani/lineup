import 'package:flutter/material.dart';

class PlayerBackgroundScaffold extends StatelessWidget {
  final Widget body;
  const PlayerBackgroundScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 250, 250),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double imageWidth = screenWidth * 0.6; // Adjust as needed
          double imageHeight = constraints.maxHeight;

          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/image_player.png',
                  fit: BoxFit.contain,
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
              Positioned.fill(child: SafeArea(child: body)),
            ],
          );
        },
      ),
    );
  }
}
