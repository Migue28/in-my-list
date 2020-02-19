import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recetas.dart';

class RecetaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final recetas = Provider.of<Recetas>(context, listen: false).recetas;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(''),
          trailing: Icon(Icons.expand_more),
          onTap: () {},
        ),
      ),
    );
  }
}
