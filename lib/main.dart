import 'package:flutter/material.dart';

void main() => runApp(const Colours());

class Colours extends StatelessWidget {
  const Colours({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: const ColourPage());
}

class ColourPage extends StatefulWidget {
  const ColourPage({super.key});

  @override
  State<ColourPage> createState() => _ColourPageState();
}

class _ColourPageState extends State<ColourPage> {
  int r = 255, g = 255, b = 255;
  String rgb2hex(int r, int g, int b) =>
      '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    Color invertedColour = Color.fromARGB(255, 255 - r, 255 - g, 255 - b);
    if (r < 196 && r > 60 && g < 196 && g > 60 && b < 196 && b > 60) {
      invertedColour = Colors.white;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, r, g, b),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('RGB Colour Tool',
            style: TextStyle(color: invertedColour, fontSize: 32)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hex: ${rgb2hex(r, g, b).toUpperCase()}',
              style: TextStyle(color: invertedColour, fontSize: 24),
            ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
