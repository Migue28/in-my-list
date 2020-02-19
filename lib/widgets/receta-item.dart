import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recetas.dart';

class RecetaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Recetas>(context, listen: false);

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 3,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Consumer<Recetas>(
            builder: (_, receta, __) => Text(receta.nombre),
          ),
          trailing: Icon(Icons.expand_more),
        ),
      ),
    );
  }
}
