import 'package:flutter/material.dart';
import 'package:odooproject/screens/SplashScreen.dart';
import 'package:odooproject/screens/home_screen.dart';
import 'package:odooproject/screens/ProductListScreen.dart';
import 'package:odooproject/services/odoo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OdooService.initOdoo();

  // await DatabaseService.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odoo Products App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
