import 'package:flutter/material.dart';

import '../screens/lista-compras-screen.dart';
import '../screens/recetas-screen.dart';
import '../screens/crear-recetas-screen.dart';
import '../screens/compras-anteriores-screen.dart';

class ControlScreen extends StatefulWidget {
  @override
  ControlScreenState createState() => ControlScreenState();
}

class ControlScreenState extends State<ControlScreen> {
  //Lista de pantallas en el navbar
  List<Widget> _widgetOption = [
    ListaComprasScreen(
      key: PageStorageKey('Lista de Compras'),
    ),
    RecetasScreen(
      key: PageStorageKey('Recetas'),
    ),
    CrearRecetasScreen(
      key: PageStorageKey('Crear recetas'),
    ),
    ComprasAnterioresScreen(
      key: PageStorageKey('Compras anteriores'),
    ),
  ];

  PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  selectedOptionText() {
    String title;

    switch (_selectedIndex) {
      case 0:
        title = 'Lista de Compras';
        break;
      case 1:
        title = 'Recetas';
        break;
      case 2:
        title = 'Crear Recetas';
        break;
      case 3:
        title = 'Compras Anteriores';
        break;
    }

    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_widgetOption[_selectedIndex] == _widgetOption[2])
          ? null
          : AppBar(
              title: Text(
                selectedOptionText(),
              ),
            ),
      body: PageStorage(
        child: _widgetOption[_selectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Lista de compra'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Recetas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text('Crear receta'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Compras anteriores'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
      ),
    );
  }
}
