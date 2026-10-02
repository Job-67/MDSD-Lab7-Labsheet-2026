import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/favorites_model.dart';
import 'models/cart_model.dart';
import 'repositories/item_repository_api.dart';
import 'main_scaffold.dart';

void main() {
  runApp(
    // สร้าง FavoritesModel และ CartModel ให้ทุก Widget ใต้ MyApp เข้าถึงได้
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesModel()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Marketplace',
      debugShowCheckedModeBanner: false, // ปิดริบบิ้น DEBUG มุมขวาบน ไม่ให้บังไอคอนหัวใจใน AppBar
      home: MainScaffold(repository: ItemRepositoryApi()),
    );
  }
}
