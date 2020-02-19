import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recetas.dart';

class RecetaItem extends StatelessWidget {
  final String nombre;

  RecetaItem(this.nombre);

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(nombre),
          trailing: Icon(Icons.expand_more),
          onTap: () {},
        ),
      ),
    );
  }
}
