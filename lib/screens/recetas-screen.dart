import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/receta-item.dart';
import '../providers/recetas.dart';

class RecetasScreen extends StatefulWidget {
  static const routeName = '/recetas';
  const RecetasScreen({Key key}) : super(key: key);

  @override
  _RecetasScreenState createState() => _RecetasScreenState();
}

class _RecetasScreenState extends State<RecetasScreen> {
  @override
  Widget build(BuildContext context) {
    final recetasData = Provider.of<Recetas>(context, listen: false);

    return ListView.builder(
      itemCount: recetasData.recetas.length,
      itemBuilder: (context, i) => RecetaItem(
        nombre: recetasData.recetas[i].nombre,
        cantidadIngredientes:
            recetasData.cantidadIngredientes(recetasData.recetas[i].id),
      ),
    );
  }
}
