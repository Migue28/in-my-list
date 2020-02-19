import 'package:flutter/material.dart';
import 'package:in_my_list/screens/recetas-screen.dart';
import 'package:provider/provider.dart';

import './screens/lista-compras-screen.dart';
import './screens/control-screen.dart';
import './providers/recetas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Recetas(),
        ),
      ],
      child: MaterialApp(
        title: 'InMyList',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.purple,
        ),
        home: ControlScreen(),
        routes: {
          RecetasScreen.routeName: (context) => RecetasScreen(),
        },
      ),
    );
  }
}
