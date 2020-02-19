import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../models/ingrediente.dart';
import '../models/receta.dart';

class Recetas with ChangeNotifier {
  List<Receta> _recetas = [
    Receta(
      nombre: 'Arroz con pollo',
      ingredientes: [
        Ingrediente(nombre: 'Arroz', cantidad: 2),
        Ingrediente(nombre: 'Pollo', cantidad: 1),
      ],
    ),
    Receta(
      nombre: 'Pollo asado',
      ingredientes: [],
      procedimiento: '',
      imagen: '',
    ),
  ];

  //retorna una copia de _recetas
  List<Receta> get recetas {
    print('Recetas $_recetas');
    return [..._recetas];
  }

  //retorna el total de recetas
  int get totalRecetas => _recetas.length;
}
