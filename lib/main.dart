import 'package:canvas_grid_math/app/main_page.dart';
import 'package:canvas_grid_math/app/main_page_controlller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainPageControlller(),
        ),
      ],
      child: const MaterialApp(
        title: 'Canvas Grid Math',
        home: MainPage(),
      ),
    );
  }
}
