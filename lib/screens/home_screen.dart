// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _savedCities = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCities();
  }

  Future<void> _loadSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedCities = prefs.getStringList('cities') ?? [];
    });
  }

  Future<void> _saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_savedCities.contains(city)) {
      _savedCities.add(city);
      await prefs.setStringList('cities', _savedCities);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Consulta de Clima')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                final city = _controller.text.trim();
                if (city.isNotEmpty) {
                  await viewModel.fetchWeather(city);
                  await _saveCity(city);
                }
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Cidades salvas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children:
                  _savedCities
                      .map(
                        (city) => ActionChip(
                          label: Text(city),
                          onPressed: () async {
                            _controller.text = city;
                            await viewModel.fetchWeather(city);
                          },
                        ),
                      )
                      .toList(),
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
