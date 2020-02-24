import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CrearRecetasScreen extends StatefulWidget {
  CrearRecetasScreen({Key key}) : super(key: key);

  @override
  _CrearRecetasScreenState createState() => _CrearRecetasScreenState();
}

class _CrearRecetasScreenState extends State<CrearRecetasScreen> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  bool _imagenGaleria = true;

  //Elegir una imagen de la galeria o tomar una foto
  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: _imagenGaleria ? ImageSource.gallery : ImageSource.camera,
      maxHeight: 1000,
      maxWidth: 1000,
      imageQuality: 100,
    );

    setState(() {
      _image = image;
    });
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
              lineas: 2,
            ),
            Divider(),
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: FloatingActionButton(
                      onPressed: () async {
                        setState(() {
                          _imagenGaleria = false;
                        });
                        await getImage();
                      },
                      tooltip: 'Pick Image',
                      child: Icon(Icons.add_a_photo),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: FloatingActionButton(
                      onPressed: () async {
                        setState(() {
                          _imagenGaleria = true;
                        });
                        await getImage();
                      },
                      tooltip: 'Pick Image',
                      child: Icon(Icons.add_photo_alternate),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Guardar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TextFormField que se repetia, asi que solo se piden los valores que cambian.
class CustomTextFormField extends StatelessWidget {
  final String nombre;
  final String hintText;
  final String vacioText;
  final int lineas;

  CustomTextFormField(
      {this.nombre, this.hintText, this.vacioText, this.lineas});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20),
      maxLines: lineas,
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
