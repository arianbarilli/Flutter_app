import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/search_input.dart';
import '../widgets/search_button.dart';
import '../widgets/weather_card.dart';
import '../widgets/saved_city_chip_list.dart';

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
      body: Center(
        child: SizedBox(
          width: 1366,
          height: 768,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFF46C8C4),
              ),
              // Decorações de canto
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Conteúdo central
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Clima Tempo',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Campo de entrada customizado
                    SearchInput(controller: _controller),
                    const SizedBox(height: 16),

                    // Botão customizado
                    SearchButton(
                      onPressed: () async {
                        final city = _controller.text.trim();
                        if (city.isNotEmpty) {
                          await viewModel.fetchWeather(city);
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // Lista de cidades salvas
                    if (viewModel.savedCities.isNotEmpty)
                      SavedCityChipList(
                        cities: viewModel.savedCities,
                        onSelected: (city) async {
                          _controller.text = city;
                          await viewModel.fetchWeather(city);
                        },
                      ),

                    const SizedBox(height: 30),

                    // Resultado da pesquisa
                    if (viewModel.isLoading)
                      const CircularProgressIndicator()
                    else if (viewModel.weather != null)
                      WeatherCard(weather: viewModel.weather!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
