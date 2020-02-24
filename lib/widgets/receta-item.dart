import 'package:flutter/material.dart';

class RecetaItem extends StatelessWidget {
  final String nombre;
  final int cantidadIngredientes;
  final FileImage fileImage;

  RecetaItem({this.nombre, this.cantidadIngredientes, this.fileImage});

  @override
  Widget build(BuildContext context) {
    //Rectángulo que tiene las recetas
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(),
          title: Text(nombre),
          subtitle: Text('Ingredientes: $cantidadIngredientes'),
          trailing: Icon(Icons.expand_more),
          onTap: () {},
        ),
      ),
    );
  }
}
