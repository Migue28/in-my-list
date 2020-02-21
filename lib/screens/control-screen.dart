import 'package:flutter/material.dart';

import '../screens/lista-compras-screen.dart';
import '../screens/recetas-screen.dart';
import '../screens/crear-recetas-screen.dart';
import '../screens/compras-screen.dart';

class ControlScreen extends StatefulWidget {
  @override
  ControlScreenState createState() => ControlScreenState();
}

class ControlScreenState extends State<ControlScreen> {
  List<Widget> _widgetOption = [
    ListaComprasScreen(),
    RecetasScreen(),
    CrearRecetasScreen(),
    ComprasAnterioresScreen(),
  ];

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
      appBar: AppBar(
        title: Text(
          selectedOptionText(),
        ),
      ),
      body: _widgetOption.elementAt(_selectedIndex),
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
