import 'package:flutter/foundation.dart';

import './ingrediente.dart';

class Receta with ChangeNotifier {
  @required
  String nombre;
  String imagen;
  List<Ingrediente> ingredientes;
  String procedimiento;

  Receta({this.nombre, this.imagen, this.ingredientes, this.procedimiento});
}
