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
            TextFormField(
              style: TextStyle(fontSize: 20),
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText:
                    'Ejemplo: Arroz suizo con sal lunar y salsa de cactus.',
              ),
              onFieldSubmitted: (value) {
                if (value.isEmpty) {
                  return 'Te falta el nombre.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
