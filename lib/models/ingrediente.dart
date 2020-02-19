import 'package:flutter/foundation.dart';

class Ingrediente with ChangeNotifier {
  @required
  String nombre;
  @required
  int cantidad;

  Ingrediente({this.nombre, this.cantidad});
}
