import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'ui/screens/minesweeper_screen.dart';
import 'ui/screens/menu_screen.dart';
import 'ui/screens/history_screen.dart';
import 'ui/screens/about.dart';
import 'package:provider/provider.dart';
import 'viewmodels/game_view_model.dart';
import 'core/services/storage_service.dart';
import 'ui/screens/settings_screen.dart';
import 'viewmodels/settings_view_model.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  logger.d('Debug: iniciando app');
  logger.i('Info: app iniciada');
  logger.w('Warning: prueba');
  logger.e('Error: prueba');
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SettingsViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/menu',
      // Mapa centralizado de Rutas Nombradas
      routes: {
        '/menu': (context) => const MenuScreen(),
        '/game': (context) => ChangeNotifierProvider(
          create: (context) => GameViewModel(),
          child: const MinesweeperScreen(),
        ),
        '/history': (context) => const HistoryScreen(),
        '/about': (context) => const AboutScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      title: 'Buscaminas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
          secondary: Colors.amber,
          surface: Colors.grey.shade300,
          error: Colors.red.shade300,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 40, 137, 193),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        useMaterial3: true,
      ),
      //home: const MinesweeperScreen(), // Apuntamos a nuestra nueva pantalla
    );
  }
}
