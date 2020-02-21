import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Ingrediente {
  @required
  String nombre;
  @required
  double cantidad;

  Ingrediente({this.nombre, this.cantidad});
}

class Receta {
  @required
  String id;
  @required
  String nombre;
  String imagen;
  List<Ingrediente> ingredientes;
  String procedimiento;

  Receta({
    this.id,
    this.nombre,
    this.imagen,
    this.ingredientes,
    this.procedimiento,
  });
}

class Recetas with ChangeNotifier {
  List<Receta> _recetas = [
    Receta(
      id: 'ap',
      nombre: 'Arroz con pollo',
      ingredientes: [
        Ingrediente(nombre: 'Arroz', cantidad: 2),
        Ingrediente(nombre: 'Pollo', cantidad: 1),
      ],
    ),
    Receta(
      id: 'pa',
      nombre: 'Pollo asado',
      ingredientes: [],
      procedimiento: '',
      imagen: '',
    ),
  ];

  //retorna una copia de _recetas
  List<Receta> get recetas {
    return [..._recetas];
  }

  //retorna el total de recetas
  int get totalRecetas => _recetas.length;

  //retorna la cantidad de ingredientes de cada receta
  int cantidadIngredientes(String id) {
    
    int cantidad = 0;
    int index;

    index = _recetas.indexWhere((recetaId) => recetaId.id == id);

    if (index == null) {
      return cantidad;
    }

    cantidad = _recetas.elementAt(index).ingredientes.length;

    return cantidad;
  }
}
