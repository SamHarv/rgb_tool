import 'package:flutter/material.dart';

import 'ui/views/colour_view.dart';

void main() => runApp(const Colours());

class Colours extends StatelessWidget {
  const Colours({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: const ColourView(),
        title: "RGB Colour Tool",
      );
}
