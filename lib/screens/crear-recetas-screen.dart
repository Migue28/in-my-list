import 'package:flutter/material.dart';

class CrearRecetasScreen extends StatelessWidget {
  CrearRecetasScreen({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void _saveForm() {
    final isValid = _formKey.currentState.validate();

    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            CustomTextFormField(
              nombre: 'Nombre',
              vacioText: 'el nombre',
              hintText: 'Empada rellena de arroz con salsa de cactus',
            ),
            Divider(),
            CustomTextFormField(
              nombre: 'Imagen',
              vacioText: 'una imagen',
              hintText: 'mi-bella-receta.jpg',
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String nombre;
  final String hintText;
  final String vacioText;

  CustomTextFormField({this.nombre, this.hintText, this.vacioText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20),
      maxLines: 2,
      decoration: InputDecoration(
        labelText: nombre,
        hintText: 'Ejemplo: $hintText',
      ),
      onFieldSubmitted: (value) {
        if (value.isEmpty) {
          return 'Te falta $vacioText.';
        }
        return null;
      },
    );
  }
}
