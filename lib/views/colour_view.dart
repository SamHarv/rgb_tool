import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColourView extends StatefulWidget {
  const ColourView({super.key});

  @override
  State<ColourView> createState() => _ColourViewState();
}

class _ColourViewState extends State<ColourView> {
  int r = 255, g = 255, b = 255;
  String rgb2hex(int r, int g, int b) =>
      '#${r.toRadixString(16).padLeft(2, '0')}'
      '${g.toRadixString(16).padLeft(2, '0')}'
      '${b.toRadixString(16).padLeft(2, '0')}';

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Color invertedColour = Color.fromARGB(255, 255 - r, 255 - g, 255 - b);
    r + g + b < 384
        ? invertedColour = Colors.white
        : invertedColour = Colors.black;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, r, g, b),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset("images/logo.png"),
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
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hex: ${rgb2hex(r, g, b).toUpperCase()}',
                  style: TextStyle(color: invertedColour, fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: invertedColour),
                  onPressed: () => copyToClipboard(rgb2hex(r, g, b)),
                  tooltip: 'Copy hex value',
                ),
              ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("RGB",
                        style: TextStyle(color: invertedColour, fontSize: 24)),
                    IconButton(
                      icon: Icon(Icons.copy, color: invertedColour),
                      onPressed: () => copyToClipboard('rgb($r, $g, $b)'),
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
