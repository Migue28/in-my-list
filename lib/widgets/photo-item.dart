import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Photo extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
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
      directory = await getApplicationDocumentsDirectory();
      path = directory.path;
      fileName = basename(image.path);
    } catch (error) {}

    localPath = '$path/$fileName';

    setState(() {
      _image = image;
    });
    return localPath;
  }

  //Ingresar foto o imagen de la galeria
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Renderizar la imagen seleccionada
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
      ],
    );
  }
}
