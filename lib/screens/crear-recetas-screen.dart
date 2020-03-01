import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../providers/recetas.dart';

class CrearRecetasScreen extends StatefulWidget {
  CrearRecetasScreen({Key key}) : super(key: key);

  @override
  _CrearRecetasScreenState createState() => _CrearRecetasScreenState();
}

class _CrearRecetasScreenState extends State<CrearRecetasScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Ingrediente> _ingredientes = [];
  TextEditingController _ingredientesText = new TextEditingController();
  FocusNode _ingredientesNode = FocusNode();
  var _receta = Receta(
    id: null,
    nombre: '',
    imagen: '',
    ingredientes: [],
    procedimiento: '',
  );

  File _image;
  bool _imagenGaleria = false;

  //Elegir una imagen de la galeria o tomar una foto
  Future getImage() async {
    var directory;
    var path;
    var fileName;
    String localPath;

    File image = await ImagePicker.pickImage(
      source: _imagenGaleria ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 50,
    );

    if (image == null) {
      return;
    }
    //Conseguir la direccion local de la imagen
    try {
      directory = await getExternalStorageDirectory();
      path = directory.path;
      fileName = p.basename(image.path);
      localPath = '$path/$fileName';
      File newImage = await image.copy(localPath);
    } catch (error) {}

    _receta = Receta(
      nombre: _receta.nombre,
      imagen: localPath,
      ingredientes: _receta.ingredientes,
      procedimiento: _receta.procedimiento,
    );

    setState(() {
      _image = image;
    });
  }

  //Lista de ingredientes para renderizar
  Widget getIngredientes(List<Ingrediente> ingredientes) {
    return new Wrap(
      children: ingredientes
          .map(
            (item) => Dismissible(
              key: ValueKey(item.nombre),
              onDismissed: (direction) {
                _ingredientes.removeWhere(
                    (element) => element.nombre.contains(item.nombre));
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    item.nombre,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(Icons.clear),
                  onTap: () {
                    setState(() {
                      _ingredientes.removeWhere(
                          (element) => element.nombre.contains(item.nombre));
                    });
                  },
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  //Guardar formulario
  void _saveForm() async {
    _formKey.currentState.save();
    await Provider.of<Recetas>(
      context,
      listen: false,
    ).addReceta(_receta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear receta'),
        actions: <Widget>[
          GestureDetector(
            onTap: _saveForm,
            child: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //El nombre de la receta
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText:
                        'Ejemplo: Empanada rellena de arroz con salsa de cactus',
                  ),
                  textInputAction: TextInputAction.done,
                  onSaved: (newValue) {
                    _receta = Receta(
                      nombre: newValue,
                      imagen: _receta.imagen,
                      ingredientes: _receta.ingredientes,
                      procedimiento: _receta.procedimiento,
                    );
                  },
                  onFieldSubmitted: (value) {
                    if (value.isEmpty) {
                      return 'Te falta el nombre';
                    }
                    return null;
                  },
                ),
                Divider(),

                Center(
                  child: _image == null
                      ? Text(
                          'No ha elegido ninguna imagen.',
                          style: TextStyle(fontSize: 18),
                        )
                      : Container(
                          width: 350,
                          height: 350,
                          child: Image.file(
                            _image,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
                //Elegir si foto o imagen de galeria
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FloatingActionButton(
                          onPressed: () async {
                            setState(
                              () {
                                _imagenGaleria = false;
                              },
                            );
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
                            setState(
                              () {
                                _imagenGaleria = true;
                              },
                            );
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
                //Renderizar los ingredientes ingresados
                getIngredientes(_ingredientes),
                //Ingresar los ingredientes
                TextFormField(
                  controller: _ingredientesText,
                  style: TextStyle(fontSize: 20),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Ingredientes',
                    hintText: 'Ejemplo: Cebolla, Arroz...',
                  ),
                  focusNode: _ingredientesNode,
                  textInputAction: TextInputAction.next,
                  onSaved: (_) {
                    _receta = Receta(
                      nombre: _receta.nombre,
                      imagen: _receta.imagen,
                      ingredientes: _ingredientes,
                      procedimiento: _receta.procedimiento,
                    );
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      _ingredientes.add(Ingrediente(nombre: value));

                      _ingredientesText.clear();
                    });
                    FocusScope.of(context).requestFocus(_ingredientesNode);
                  },
                ),
                Divider(),
                //Ingresar el procidimiento de la receta
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Preparación',
                    hintText:
                        'Ejemplo: Primero agrega un pizca de sal en el arroz...',
                  ),
                  keyboardType: TextInputType.multiline,
                  onSaved: (newValue) {
                    _receta = Receta(
                      nombre: _receta.nombre,
                      imagen: _receta.imagen,
                      ingredientes: _receta.ingredientes,
                      procedimiento: newValue,
                    );
                  },
                  onFieldSubmitted: (value) {
                    if (value.isEmpty) {
                      return 'Olvidaste la preparación.';
                    }
                    return null;
                  },
                ),
                Divider(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: _saveForm,
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
        ),
      ),
    );
  }
}
