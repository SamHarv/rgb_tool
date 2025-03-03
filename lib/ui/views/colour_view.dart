import 'package:colours/config/constants.dart';
import 'package:flutter/material.dart';

import '../../logic/rgb_tool_logic.dart';

class ColourView extends StatefulWidget {
  /// UI to display the RGB colour tool

  const ColourView({super.key});

  @override
  State<ColourView> createState() => _ColourViewState();
}

class _ColourViewState extends State<ColourView> {
  // Default colour values for red, green, and blue
  int r = 255, g = 255, b = 255;

  // Logic object to handle the business logic
  final logic = RgbToolLogic();

  @override
  Widget build(BuildContext context) {
    // Get inverted colour for text
    Color invertedColour = logic.getInvertedColour(r, g, b);
    // Get the hexadecimal colour value
    final hex = logic.rgb2hex(r, g, b).toUpperCase();
    return Scaffold(
      // Set background to the selected colour
      backgroundColor: Color.fromARGB(255, r, g, b),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(logo),
        ),
        backgroundColor: Colors.transparent,
        title: Text('RGB Colour Tool',
            style: TextStyle(color: invertedColour, fontSize: 32)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display the hexadecimal colour value with a copy button
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hex: $hex',
                  style: TextStyle(color: invertedColour, fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: invertedColour),
                  onPressed: () => logic.copyToClipboard(hex, context),
                  tooltip: 'Copy hex value',
                ),
              ],
            ),
            // Display the sliders for red, green, and blue
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text('Red: $r',
                        style: TextStyle(color: invertedColour, fontSize: 24)),
                    Slider(
                      activeColor: invertedColour,
                      value: r.toDouble(),
                      min: 0,
                      max: 255,
                      onChanged: (value) => setState(() => r = value.toInt()),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Green: $g',
                        style: TextStyle(color: invertedColour, fontSize: 24)),
                    Slider(
                      activeColor: invertedColour,
                      value: g.toDouble(),
                      min: 0,
                      max: 255,
                      onChanged: (value) => setState(() => g = value.toInt()),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Blue: $b',
                        style: TextStyle(color: invertedColour, fontSize: 24)),
                    Slider(
                      activeColor: invertedColour,
                      value: b.toDouble(),
                      min: 0,
                      max: 255,
                      onChanged: (value) => setState(() => b = value.toInt()),
                    ),
                  ],
                ),
                // Display the RGB colour value with a copy button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("RGB",
                        style: TextStyle(color: invertedColour, fontSize: 24)),
                    IconButton(
                      icon: Icon(Icons.copy, color: invertedColour),
                      onPressed: () =>
                          logic.copyToClipboard('rgb($r, $g, $b)', context),
                      tooltip: 'Copy RGB value',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
