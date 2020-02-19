import 'package:flutter/material.dart';

import '../widgets/draw-bottom-nav-bar.dart';
import '../widgets/receta-item.dart';

class RecetasScreen extends StatelessWidget {
  static const routeName = '/recetas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecetaItem(),
    );
  }
}
