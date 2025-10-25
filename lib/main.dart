import 'package:flutter/material.dart';
import 'src/ui/pages/home_page.dart';

// Se o projeto não estiver compilando quando clicar no Start Debugging, excute: flutter run -d chrome

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agroview',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E8F4A),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E8F4A),
          secondary: Color(0xFF1976D2),
          //background: Color(0xFFFFFFFF),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF1E8F4A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1E8F4A),
          secondary: Color(0xFF1976D2),
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}


/*void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF1E8F4A),

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          accentColor: const Color(0xFF1976D2),
          backgroundColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage();
    );
  }
}*/
