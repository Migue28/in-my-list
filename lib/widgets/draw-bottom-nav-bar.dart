import 'package:flutter/material.dart';

class DrawBottomNavBar extends StatefulWidget {
  
  @override
  _DrawBottomNavBarState createState() => _DrawBottomNavBarState();
}

class _DrawBottomNavBarState extends State<DrawBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
