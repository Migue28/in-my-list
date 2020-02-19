import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/receta-item.dart';
import '../providers/recetas.dart';

class RecetasScreen extends StatefulWidget {
  static const routeName = '/recetas';

  @override
  _RecetasScreenState createState() => _RecetasScreenState();
}

class _RecetasScreenState extends State<RecetasScreen> {
  @override
  Widget build(BuildContext context) {
    final recetasData = Provider.of<Recetas>(context, listen: false);

    return Scaffold(
      body: Column(
        children: <Widget>[
          
          ListView.builder(
            itemCount: recetasData.totalRecetas,
            itemBuilder: (context, i) =>
                RecetaItem(recetasData.recetas[i].nombre),
          ),
        ],
      ),
    );
  }
}
