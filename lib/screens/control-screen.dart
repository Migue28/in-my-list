import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
