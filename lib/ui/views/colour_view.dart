import 'package:colours/config/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/rgb_tool_logic.dart';
import '../widgets/banner_ad_widget.dart';

class ColourView extends StatefulWidget {
  /// UI to display the RGB colour tool

  const ColourView({super.key});

  @override
  State<ColourView> createState() => _ColourViewState();
}

class _ChannelSlider extends StatelessWidget {
  const _ChannelSlider({
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  final String label;
  final int value;
  final Color color;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 32),
            Text(
              '$label: $value',
              style: GoogleFonts.lexend(color: color, fontSize: 24),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.remove, color: color),
              iconSize: 28,
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(minWidth: 52, minHeight: 52),
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
            ),
            IconButton(
              icon: Icon(Icons.add, color: color),
              iconSize: 28,
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(minWidth: 52, minHeight: 52),
              onPressed: value < 255 ? () => onChanged(value + 1) : null,
            ),
            SizedBox(width: 8),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slider(
            activeColor: color,
            value: value.toDouble(),
            min: 0,
            max: 255,
            onChanged: (v) => onChanged(v.toInt()),
          ),
        ),
      ],
    );
  }
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
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 24),
        //   child: Image.asset(logo),
        // ),
        backgroundColor: Colors.transparent,
        title: Row(
          spacing: 16,
          children: [
            SizedBox(),
            SizedBox(height: 30, child: Image.asset(logo)),
            Text(
              'RGB Colour Tool',
              style: GoogleFonts.bangers(
                color: invertedColour,
                fontSize: 28,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display the sliders for red, green, and blue
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ChannelSlider(
                  label: 'Red',
                  value: r,
                  color: invertedColour,
                  onChanged: (v) => setState(() => r = v),
                ),
                _ChannelSlider(
                  label: 'Green',
                  value: g,
                  color: invertedColour,
                  onChanged: (v) => setState(() => g = v),
                ),
                _ChannelSlider(
                  label: 'Blue',
                  value: b,
                  color: invertedColour,
                  onChanged: (v) => setState(() => b = v),
                ),
                // Display the RGB colour value with a copy button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 32),
                        Text(
                          "RGB",
                          style: GoogleFonts.lexend(
                            color: invertedColour,
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy, color: invertedColour),
                          onPressed: () =>
                              logic.copyToClipboard('rgb($r, $g, $b)', context),
                          tooltip: 'Copy RGB value',
                        ),
                      ],
                    ),
                    // Display the hexadecimal colour value with a copy button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Hex: $hex',
                          style: GoogleFonts.lexend(
                            color: invertedColour,
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy, color: invertedColour),
                          onPressed: () => logic.copyToClipboard(hex, context),
                          tooltip: 'Copy hex value',
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),
                // Display the ad if not web version
                kIsWeb
                    ? SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: BannerAdWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
