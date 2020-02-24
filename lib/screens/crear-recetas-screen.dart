import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/recetas.dart';

class CrearRecetasScreen extends StatefulWidget {
  CrearRecetasScreen({Key key}) : super(key: key);

  @override
  _CrearRecetasScreenState createState() => _CrearRecetasScreenState();
}

class _CrearRecetasScreenState extends State<CrearRecetasScreen> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  bool _imagenGaleria = true;
  List<String> _ingredientes = [];
  TextEditingController _ingredientesText = new TextEditingController();

  //Lista de ingredientes para renderizar
  Widget getIngredientes(List<String> ingredientes) {
    return new Wrap(
      children: ingredientes
          .map(
            (item) => Dismissible(
              key: ValueKey(item),
              onDismissed: (direction) {
                _ingredientes.removeWhere((element) => element.contains(item));
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    item,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(Icons.clear),
                  onTap: () {},
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  //Elegir una imagen de la galeria o tomar una foto
  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: _imagenGaleria ? ImageSource.gallery : ImageSource.camera,
      maxHeight: 500,
      maxWidth: 500,
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
            getIngredientes(_ingredientes),
            TextFormField(
              controller: _ingredientesText,
              style: TextStyle(fontSize: 20),
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Ingredientes',
                hintText: 'Ejemplo: Cebolla, Arroz...',
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  _ingredientes.add(value.toString());

                  _ingredientesText.clear();
                });
              },
            ),
            Divider(),
            CustomTextFormField(
              nombre: 'Preparación',
              hintText: 'Primero agrega un pizca de sal en el arroz...',
              lineas: 5,
              vacioText: 'la preparación',
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
