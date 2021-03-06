import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Ingrediente {
  @required
  String nombre;
  // @required
  // double cantidad;

  Ingrediente({
    this.nombre,
    /* this.cantidad */
  });
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
  List<Receta> _recetas = [];

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

  Future<void> addReceta(Receta receta) async{
    _recetas.add(
      Receta(
        id: DateTime.now().toIso8601String(),
        imagen: receta.imagen,
        nombre: receta.nombre,
        ingredientes: receta.ingredientes,
        procedimiento: receta.procedimiento,
      ),
    );
    notifyListeners();
  }
}
