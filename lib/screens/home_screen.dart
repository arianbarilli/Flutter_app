// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Consulta de Clima')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite a cidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await viewModel.fetchWeather(_controller.text);
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            viewModel.isLoading
                ? const CircularProgressIndicator()
                : viewModel.weather == null
                ? const Text('Nenhuma informação encontrada')
                : WeatherCard(weather: viewModel.weather!),
          ],
        ),
      ),
    );
  }
}
