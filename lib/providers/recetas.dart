import 'package:flutter/widgets.dart';

import '../providers/ingredientes.dart';

class Recetas {
  @required
  String nombre;
  String imagen;
  List<Ingredientes> ingredientes;
  String procedimiento;

  Recetas({this.nombre, this.imagen, this.ingredientes, this.procedimiento});
}
