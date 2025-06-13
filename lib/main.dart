import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/weather_viewmodel.dart';
import 'repositories/weather_repository.dart';
import 'services/weather_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AppProvider());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => WeatherViewModel(
                repository: WeatherRepository(service: WeatherService()),
              ),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima Tempo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const HomeScreen(),
    );
  }
}
