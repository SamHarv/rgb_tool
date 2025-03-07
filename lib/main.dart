import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ui/views/colour_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(const Colours());
}

class Colours extends StatelessWidget {
  const Colours({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: const ColourView(),
        title: "RGB Colour Tool",
      );
}
